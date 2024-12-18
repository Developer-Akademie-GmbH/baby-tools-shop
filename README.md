# Baby Tools Shop

## Table of Contents

1. [Project Overview](#project-overview)
2. [Quickstart](#quickstart)
3. [Configuration](#configuration)
4. [Deploying with Docker](#deploying-with-docker)
5. [Hints](#hints)

## Project Overview

The **Baby Tools Shop** project is a Django-based web application that allows users to browse and purchase baby tools. It includes:

- **Django** for backend development.
- **Python 3.9** as the programming language.
- **Docker** for containerization.

### Technologies

The application uses the following technologies:

- **Python 3.9**
- **Django 4.0.2**
- **Venv** for managing the virtual environment

## Quickstart

To get started with the Baby Tools Shop, follow these steps:

1. **Set up your Python environment:**

   ```python
   python -m venv your_environment_name
   ```

2. **Activate the virtual environment:**

   ```python
   your_environment_name\Scripts\activate
   ```

3. **Navigate to the project directory:**

   ```python
   cd babyshop_app
   ```

4. **Install Django:**

   ```python
    python -m pip install Django==4.0.2
   ```

5. **Go to the root directory and create a `requirements.txt` file:**

   - Change to the root directory:

     ```bash
     cd ..
     ```

   - Create the `requirements.txt` file:

     ```bash
     nano requirements.txt
     ```

   - Add the following dependencies to the file:

     ```txt
     Django==4.0.2
     pillow==10.4.0
     ```

   - Save and exit the file.

6. **Apply migrations:**

   ```python
    python manage.py makemigrations
   ```

   ```python
    python manage.py migrate
   ```

7. **Create a superuser:**

   ```python
    python manage.py createsuperuser
   ```

   - **Important**: Use a DJANGO_SUPERUSER_USERNAME, DJANGO_SUPERUSER_EMAIL and a DJANGO_SUPERUSER_PASSWORD

8. **Run the development server:**

   ```python
    python manage.py runserver
   ```

   - You can access the admin panel at http://<your_ip>:8000/admin
   - Create products in the admin panel

## Configuration

1. **Configure your environment:**
    Modify the **ALLOWED_HOSTS** setting in **settings.py** to include the domain names or IP addresses that will be used to access the application.

    ```python
    ALLOWED_HOSTS = ['your_domain_or_ip']
    ```

    - Configures allowed hosts: This setting specifies which domain names or IP addresses are permitted to access your Django application.
    - Enhances security: It prevents HTTP Host header attacks by only allowing requests from specified hosts.
    - Set for production: Replace 'your_domain_or_ip' with your actual domain or server IP to make your site accessible.

2. **Create Dockerfile:**

    ```docker
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
    ```

## Deploying with Docker

1. **Copy the Project Folder to your VM**
2. **Build the Docker image:**

    ```docker
    docker build -t app_name .
    ```

    - Builds a Docker image: This command creates a Docker image from the Dockerfile in the current directory.
    - Tags the image: -t app_name assigns the tag app_name to the image, which can be used for easy reference.
    - Prepares for deployment: The image contains the application and its dependencies, ready for running in a container.

3. **Create Docker volumes:**

    ```docker
    docker volume create babyshop_db
    docker volume create babyshop_media
    docker volume create babyshop_static
    ```

    - Create Docker volumes: These commands create named volumes that can be used to persist data across Docker container restarts and re-creations.
    - babyshop_db: Volume for storing database data.
    - babyshop_media: Volume for storing user-uploaded media files.
    - babyshop_static: Volume for storing static files like CSS and JS.
    - Ensures data persistence: Keeps your application data safe and accessible even if containers are removed or recreated.

4. **Run the Docker container:**

    ```docker
    docker run -d --name app_name_container \
      -p 8025:8025 \
      -v babyshop_db:/app/babyshop_app/db \
      -v babyshop_media:/app/babyshop_app/media \
      -v babyshop_static:/app/babyshop_app/static \
      --restart on-failure \
      app_name
    ```

    - Run a Docker container: This command starts a new container from the Docker image named app_name.
    - Detach mode (-d): Runs the container in the background.
    - Name the container (--name babyshop_app_container): Assigns the name babyshop_app_container to the running container for easier management.
    - Port mapping (-p 8025:8025): Maps port 8025 on the host to port 8025 in the container, making the app accessible via port 8025.
    - Mount volumes (-v):

      - babyshop_db:/app/babyshop_app/db: Maps the babyshop_db volume to the container’s database directory.
      - babyshop_media:/app/babyshop_app/media: Maps the babyshop_media volume to the container’s media directory.
      - babyshop_static:/app/babyshop_app/static: Maps the babyshop_static volume to the container’s static files directory.

    - Restart policy (--restart on-failure): Automatically restarts the container if it fails, but not if stopped manually.

    - You can access your app at http://<vm_ip>:8025/

5. **Create a superuser**

    ```docker
    docker ps
    ```

    - Shows active containers: Lists all running containers with their IDs and names.
    - Identify your container: Find the container ID or name for your Django app.

    ```docker
    docker exec -it <container_name_or_id> /bin/bash
    ```

    - Execute a command inside a container: Opens an interactive terminal (-it) within the specified container.
    - Replace <container_name_or_id>: Use the actual container name or ID from the previous command.

    ```docker
    python manage.py createsuperuser
    ```

    - Run Django’s superuser creation command: This will prompt you to enter
    - a DJANGO_SUPERUSER_USERNAME,
    - a DJANGO_SUPERUSER_EMAIL email
    - a DJANGO_SUPERUSER_PASSWORD password for the new superuser account.

    ```docker
    exit
    ```

    - Close the interactive session: Logs out of the container’s shell and returns to your host machine's terminal.
    - You can access your app at http://<vm_ip>:8025/admin
    - Login with your superuser details
    - You can place products/ categories, get user rules and manage user rules

## Hints

Here are some useful tips for interacting with this repository:

- **Configuration**: The main configuration file for the Django project is located in `babyshop_app/babyshop/settings.py`. Make sure to configure your database, static files, and media paths properly for your environment.
- **Routing**: The routing configuration can be found in the `urls.py` file. This file defines the available routes and how they map to views in the application.
- **Django Admin**: You can access the admin panel via `/admin`. To create products, categories, and manage users, make sure you create a superuser by running `python manage.py createsuperuser` and logging in.
- **Media Files**: When uploading product images, make sure the `MEDIA_ROOT` and `MEDIA_URL` are configured correctly to serve the images in both development and production environments.
- **Database Management**: Always use migrations (`python manage.py makemigrations` and `python manage.py migrate`) to update your database schema after modifying models. This ensures data consistency.

## Example Screenshots

### Home Page

![Home Page](./project_images/capture_20220323080815407.jpg 'Home Page')

This screenshot shows the home page with all products listed.

### Home Page with Filter

![Home Page with filter](./project_images/capture_20220323080840305.jpg 'Home Page with filter')

Here, you can see the filtering functionality that allows users to search for products based on categories.

### Product Detail Page

![Product Detail Page](./project_images/capture_20220323080934541.jpg 'Product Detail Page')

This is the product detail page where users can view product descriptions, prices, and images.

### Register Page

![Register Page](./project_images/capture_20220323081016022.jpg 'Register Page')

A registration page for new users to sign up.

### Login Page

![Login Page](./project_images/capture_20220323081044867.jpg 'Login Page')

Login page for existing users to authenticate and access their accounts.
