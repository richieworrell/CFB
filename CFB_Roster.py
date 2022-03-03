from __future__ import print_function
#from slack import WebClient
from datetime import datetime
from sqlalchemy import create_engine
import sqlalchemy
import cfbd
import pandas as pd
import json
from dataclasses import dataclass
from sqlite3.dbapi2 import Cursor
from pandas.io.json import json_normalize
from cfbd.rest import ApiException
from pprint import pprint

### pyodbc connection string ####
#cnxn = pyodbc.connect('Driver={PostgreSQL ODBC Driver(UNICODE)};'
#                      'Server=postgresq.cluster-catsuvgqqq1n.us-east-1.rds.amazonaws.com;'
#                      'Database=postgres;'
#                      'UID=rworrell;'
#                      'PWD=1998HondaCRV;'
#                      'PORT=5432;')

### sqlite3 connection function ###
def postgres_database_connection():
    """Returns the DB engine"""
    try:
        print('Connecting to DB')
        conn =  "postgresql+psycopg2://rworrell:1998HondaCRV@postgresq.cluster-catsuvgqqq1n.us-east-1.rds.amazonaws.com:5432/postgres" 
        engine = create_engine(conn)
        print('Connected to DB')
        return engine
    except Exception as e:
        print (e)

### INITIALIZE CFBD API ###
configuration = cfbd.Configuration()
configuration.api_key['Authorization'] = '+tizcy9ZN70h73z9dToPlfj1YDdUP6iHI5x/dxdnqJpAddAHgCnmz8fTqpGWC2Zb'
configuration.api_key_prefix['Authorization'] = 'Bearer'


### INITIALIZE ENGINE ###
engine = postgres_database_connection()
#df = pd.read_sql_query('select * from cfb.cfb_games', engine)
#print(df)

### GET API RESPONSE ###
api_instance = cfbd.PlaysApi(cfbd.ApiClient(configuration))
#conference = 'ACC' # str | Conference abbreviation filter (optional)
year = 2021
week = 1

#for i in range (1982, 2022):
#    api_response = api_instance.get_games(year=i)
#    #print(api_response)
#    df = pd.DataFrame.from_records([p.to_dict() for p in api_response])
#    df.head()
#    df = df.apply(lambda x: x.to_json(), axis=1)
#    connection = postgres_database_connection()
#    cursor = connection.connect()
#    for i in df:  
#
#        i = str(i).replace("'", '')
#        insert_sql = "INSERT INTO cfb.json_games (json_raw) VALUES ('{insert}')".format(insert=i)
#        #sqlalchemy.text(insert_sql)
#        cursor.execute(insert_sql)
#        print(" ")
#        print(insert_sql)

api_response = api_instance.get_plays(year=year, week=week)
print(api_response)

### CONVERT API RESPONSE TO PANDAS DATAFRAME ###
#df = pd.DataFrame.from_records([p.to_dict() for p in api_response])

#df.head()
#print(df.to_json())

## CONVERT EACH ROW OF DATAFRAM BACK TO JSON ####
#df = df.apply(lambda x: x.to_json(), axis=1)
#print(df)



### INITIALIZE CURSOR ##
#connection = postgres_database_connection()
#cursor = connection.connect()

## INSERT EACH JSON ROW TO DATABASE TABLE ###
#for i in df:  
#
#    i = str(i).replace("'", '')
#    insert_sql = "INSERT INTO cfb.json_games (json_raw) VALUES ('{insert}')".format(insert=i)
#    #sqlalchemy.text(insert_sql)
#    cursor.execute(insert_sql)
#    print(" ")
#    print(insert_sql)



