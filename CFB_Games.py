from __future__ import print_function
from datetime import datetime
from sqlalchemy import create_engine
import cfbd
import pandas as pd
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
api_instance = cfbd.GamesApi(cfbd.ApiClient(configuration))

### LOOP THROUGH EACH YEAR OF GAMES, INSERT RAW JSON ROW TO DB FOR EACH INDIVIDUAL GAME ###
for i in range (1992, 2022):
    api_response = api_instance.get_games(year=i)
    #print(api_response)
    df = pd.DataFrame.from_records([p.to_dict() for p in api_response])
    df.head()
    df = df.apply(lambda x: x.to_json(), axis=1)
    connection = postgres_database_connection()
    cursor = connection.connect()
    for i in df:  

        i = str(i).replace("'", '')
        insert_sql = "INSERT INTO dev_raw.json_games (json_raw) VALUES ('{insert}')".format(insert=i)
        #sqlalchemy.text(insert_sql)
        #cursor.execute(insert_sql)
        print(" ")
        print(insert_sql)



