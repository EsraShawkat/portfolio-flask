import os
import csv
from flask import Flask, render_template, request, redirect
from utils.database import get_data
from dotenv import load_dotenv

app = Flask(__name__)

# Laad variabelen uit .env bestand
load_dotenv()

# Debug: print de connectiestring uit om te checken of hij goed geladen is
# print(f"DB connectiestring uit .env: {os.getenv('DB_CONNECTION_STRING')}")


@app.route('/')
def homepage():
    return render_template('index.html')

@app.route('/about.html')
def about():
    try:
        df = get_data() 
        ratings = df.to_dict(orient="records")
        print(ratings)
        return render_template('about.html', ratings=ratings)
    except Exception as e:
        return f"Database fout: {str(e)}"

@app.route('/<string:page_name>')
def html_page(page_name):
    return render_template(page_name)


# def write_to_file(data):
#     with open('database.txt', mode='a') as database:
#         email = data['email']
#         subject = data['subject']
#         message = data['message']
#         file = database.write(f'\n{email},{subject},{message}')


def write_to_csv(data):
    with open('database.csv', 'a', newline='') as csvfile:
        email = data['email']
        subject = data['subject']
        message = data['message']
        writer = csv.writer(csvfile)
        writer.writerow([email, subject, message])


@app.route('/submit_form', methods=['GET', 'POST'])
def submit_form():
    if request.method == 'POST':
        data = request.form.to_dict()
        write_to_csv(data)
        return redirect('/thankyou.html')
    else:
        return 'Something went wrong!'
