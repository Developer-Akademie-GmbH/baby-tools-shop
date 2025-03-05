# E-Commerce Project For Baby Tools

### TECHNOLOGIES

- Python 3.10.10
- Django 5.1.6
- Venv

# Baby Tools Shop - Dockerized Setup

## Table of Contents
1. [Repository Description](#repository-description)
2. [Quickstart](#quickstart)
4. [Usage](#usage)
5. [Dockerfile Configuration and setup](dockerfile-configuration-and-setup)
6. [Port Configuration](port-configuration)
7. [Modifying the Application](modifying-the-application)
   

## Repository Description

This repository contains the setup for the Baby Tools Shop application, containerized using Docker. The purpose of this repository is to provide an easy and reproducible environment for running the Baby Tools Shop Django application inside a Docker container.

The project includes the following:
- A `Dockerfile` to containerize the application.
- Instructions for building and running the Docker container.

## Quickstart

1. Install the Docker Desktop

1. Clone the repository:

```bash
   git clone <repository_url>
   cd <repository_directory>
```
1. Create a dockerfile 

```bash
touch Dockerfile
```

1. Create a requirements.txt

```bash
touch requirements.txt
```
1. Buid the Docker image

```bash
docker build -t demo-app .
```
1. Run the Docker container

```bash
docker run -it --rm -p 8025:8025 demo-app
```
1. Visit the application in the browser

```bash
http://localhost:8025/
```

# This will get the Baby Tools Shop running in a Docker container on your local machine.

## Usage

## Configuration

This section provides detailed instructions on how to configure and modify the Dockerized setup for different results.

## Dockerfile Configuration and setup

1. The WORKDIR in the Dockerfile is set to /app/your_app This is where the Django project files are located.
1. If you want to change the working directory or the location of the project files, modify the WORKDIR and COPY instructions in the Dockerfile accordingly.
   
### The Dockerfile used for containerizing the Baby Tools Shop application:

```bash
# Use the official Python image
FROM python:3.10-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt  

# Copy all project files to the container
COPY . /app/

# Set working directory to Django application
WORKDIR /app/your_app_directory

# Expose port
EXPOSE 8025

# Command to run the application
ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8025"]
```

## Port Configuration

The Docker container is configured to expose port 8025. If you wish to use a different port, change the EXPOSE instruction in the Dockerfile and adjust the docker run command accordingly (e.g., -p <new_port>:5000).

## Modifying the Application

1. To modify the application or add additional dependencies, update the requirements.txt file.
1. Rebuild the Docker image after making changes to the application code or dependencies.




### DA Hints

This section will cover some hot tips when trying to interacting with this repository:

- Settings & Configuration for Django can be found in `babyshop_app/babyshop/settings.py`
- Routing: Routing information, such as available routes can be found from any `urls.py` file in `babyshop_app` and corresponding subdirectories

### Photos

##### Home Page with login

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080815407.jpg"></img>
##### Home Page with filter
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080840305.jpg"></img>
##### Product Detail Page
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080934541.jpg"></img>

##### Home Page with no login
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080953570.jpg"></img>


##### Register Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081016022.jpg"></img>


##### Login Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081044867.jpg"></img>
