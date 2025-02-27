# Gebruik een officiële Python-image als basis
FROM python:3.9

# Stel de werkdirectory in de container in
WORKDIR /app

# Kopieer de projectbestanden naar de container
COPY . /app

# Installeer afhankelijkheden
RUN pip install --no-cache-dir -r requirements.txt

# Stel de environment variabelen in voor Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development

# Open de poort die Flask gebruikt
EXPOSE 5000

# Start de Flask-app
CMD ["flask", "run"]