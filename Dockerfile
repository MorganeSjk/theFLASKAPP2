FROM python:latest

#We copy all our files except Dockerfile and docker-compose.yml
COPY templates .
COPY tests .
COPY .gitignore .
COPY app.py .
COPY config.py .
COPY model_saved .
COPY READMe.md .
COPY requirements.txt .

#Install dependencies (they are all presented in the requirements.txt file)
RUN pip install -r requirements.txt

COPY Dockerfile .
COPY docker-compose.yml . 

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh
ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

EXPOSE 5000

CMD ["python", "app.py", "runserver", "--host=0.0.0.0", "--threaded"]