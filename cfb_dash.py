from sqlalchemy import create_engine
import pandas as pd
from dataclasses import dataclass
from sqlite3.dbapi2 import Cursor
import os
import configparser

config = configparser.RawConfigParser()
config.read(os.path.join(os.path.abspath(os.path.dirname(__file__)), 'config.ini'))
#print(config.read(r'G:\My Drive\Python\config.ini'))
#test

## sqlite3 connection function ###
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

engine=postgres_database_connection()
sql = 'SELECT * FROM rw_cfb_data.cfb_teams'
print(pd.read_sql(sql, engine))

