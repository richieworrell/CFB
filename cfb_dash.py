from sqlalchemy import create_engine
import pandas as pd
from dataclasses import dataclass
from sqlite3.dbapi2 import Cursor
import os
import configparser


config = configparser.RawConfigParser()
config.read(os.path.join(os.path.abspath(os.path.dirname(__file__)), 'config.ini'))

print(config)

## sqlite3 connection function ###
def postgres_database_connection():
    """Returns the DB engine"""
    try:
        print('Connecting to DB')
        conn =  "postgresql+psycopg2://%s:%s@%s:5432/%s" % (config['DEFAULT']['username'], config['DEFAULT']['password'], config['DEFAULT']['database_ip'],'rw_cfb')
        #conn =  "postgresql+psycopg2://dba_richie:changeme@73.147.167.79:5432/rw_cfb" 
        engine = create_engine(conn)
        print('Connected to DB')
        return engine
    except Exception as e:
        print (e)

engine=postgres_database_connection()
connection = postgres_database_connection()
cursor = connection.connect()
sql = 'SELECT * FROM rw_cfb_data.cfb_plays'
cursor.execute(sql)

