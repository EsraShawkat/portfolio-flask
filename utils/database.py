import os
import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# Laad variabelen uit .env of CI/CD environment
load_dotenv()

# Haal connectiestring uit environment variable
DB_CONNECTION_STRING = os.getenv("DB_CONNECTION_STRING")

# Controleer of hij bestaat
if not DB_CONNECTION_STRING:
    raise Exception("FOUT: DB_CONNECTION_STRING is niet gezet!")

# Print voor debug (optioneel, haal weg voor productie)
print(f"Connectiestring: {DB_CONNECTION_STRING}")

# Maak database engine aan
engine = create_engine(DB_CONNECTION_STRING)

# Functie om data op te halen
def get_data():
    with engine.connect() as connection:
        df = pd.read_sql(text("SELECT Naam, Rating FROM esra_ratings"), con=connection)
        print(df)
        return df
