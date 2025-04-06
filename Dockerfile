FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip3 install -r requirements.txt

# works only when the docker file is in the app folder...
COPY . . 

EXPOSE 50505

ENTRYPOINT ["gunicorn", "app:app"]