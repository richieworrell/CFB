from __future__ import print_function
from sqlalchemy import create_engine
import cfbd
import pandas as pd
import json
from dataclasses import dataclass
from sqlite3.dbapi2 import Cursor
from pandas.io.json import json_normalize
from cfbd.rest import ApiException
from pprint import pprint
import configparser
import os

config = configparser.RawConfigParser()
config.read(os.path.join(os.path.abspath(os.path.dirname(__file__)), 'config.ini'))

### sqlite3 connection function ###
def postgres_database_connection():
    """Returns the DB engine"""
    try:
        print('Connecting to DB')
        conn =  "postgresql+psycopg2://%s:%s@%s:5432/%s" % (config['DEFAULT']['username'], config['DEFAULT']['password'], config['DEFAULT']['database_ip'],'rw_cfb')
        engine = create_engine(conn)
        print('Connected to DB')
        return engine
    except Exception as e:
        print (e)

### INITIALIZE CFBD API ###
configuration = cfbd.Configuration()
configuration.api_key['Authorization'] = config['DEFAULT']['cfbd_token']
configuration.api_key_prefix['Authorization'] = 'Bearer'


### INITIALIZE ENGINE ###
engine = postgres_database_connection()

### GET API RESPONSE ###
api_instance = cfbd.TeamsApi(cfbd.ApiClient(configuration))
#conference = 'ACC' # str | Conference abbreviation filter (optional)
api_response = api_instance.get_teams()



#### CONVERT API RESPONSE TO PANDAS DATAFRAME ###
df = pd.DataFrame.from_records([p.to_dict() for p in api_response])
### BREAK OUT THE NESTED VALUES FROM API RESPONSE ###
df['city'] = df[['location']].apply(lambda x: x.location['city'], axis=1)
df['capacity'] = df[['location']].apply(lambda x: x.location['capacity'], axis=1)
df['dome'] = df[['location']].apply(lambda x: x.location['dome'], axis=1)
df['elevation'] = df[['location']].apply(lambda x: x.location['elevation'], axis=1)
df['grass'] = df[['location']].apply(lambda x: x.location['grass'], axis=1)
df['latitude'] = df[['location']].apply(lambda x: x.location['latitude'], axis=1)
df['longitude'] = df[['location']].apply(lambda x: x.location['longitude'], axis=1)
df['location_name'] = df[['location']].apply(lambda x: x.location['name'], axis=1)
df['state'] = df[['location']].apply(lambda x: x.location['state'], axis=1)
df['timezone'] = df[['location']].apply(lambda x: x.location['timezone'], axis=1)
df['venue_id'] = df[['location']].apply(lambda x: x.location['venue_id'], axis=1)
df['year_constructed'] = df[['location']].apply(lambda x: x.location['year_constructed'], axis=1)
df.head()

## CONVERT EACH ROW OF DATAFRAM BACK TO JSON ####
df = df.apply(lambda x: x.to_json(), axis=1)

### INITIALIZE CURSOR ##
connection = postgres_database_connection()
cursor = connection.connect()

## INSERT EACH JSON ROW TO DATABASE TABLE ###
for i in api_response:  
    i = i.to_dict()
    i = json.dumps(i, indent = 4) 
    i = str(i).replace("'", '')
    insert_sql = "INSERT INTO dev_raw.json_teams (json_raw) VALUES ('{insert}')".format(insert=i)
    cursor.execute(insert_sql)
    print(" ")
    print(insert_sql)



