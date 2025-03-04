# https://dev.mysql.com/doc/connector-python/en/connector-python-installation.html

# https://auth0.com/blog/sqlalchemy-orm-tutorial-for-python-developers/

# https://oege.ie.hva.nl/phpmyadmin/index.php

# mysqlconnector
import pandas as pd
from sqlalchemy import create_engine, text
import mysql.connector

host='oege.ie.hva.nl'
database='zshawkae'
user='shawkae'
password='LTcsX2bOK2JwcN2/'

connection = mysql.connector.connect(host= host,
                                         database= database,
                                         user= user,
                                         password= password)


engine = create_engine(f"mysql+mysqlconnector://{user}:{password}@{host}/{database}")

def get_data():
    with engine.connect() as connection:
        df = pd.read_sql(text("SELECT Naam, Rating FROM esra_ratings"), con=connection)
        print(df)
        return df
    








