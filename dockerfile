# Use an official Python image as the base
FROM python:3.9-slim

# Set the working directory inside the container

WORKDIR /app

# Copy only the requirements file and install dependencies

COPY requirements.txt ${WORKDIR}
RUN python -m pip install --no-cache-dir -r requirements.txt

# Copy the code into the working direction

COPY . ${WORKDIR}

# Change to the app directory and run database migrations

WORKDIR /app/babyshop_app
RUN python manage.py makemigrations && python manage.py migrate

EXPOSE 8025

# This is the command that will be executed on container launch

ENTRYPOINT ["sh", "-c", "python manage.py runserver 0.0.0.0:8025"]