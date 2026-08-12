# User Documentation (USER_DOC)

Welcome to the user documentation for the Inception project. This guide explains how to interact with the infrastructure, manage the services, and access the website.

## 1. Provided Services
This project deploys a complete, secure web hosting stack using Docker. It includes three main services:
- **NGINX**: The web server. It is the only entry point to the infrastructure, strictly accessible via HTTPS (port 443) using TLSv1.3 encryption.
- **WordPress**: The Content Management System (CMS), running via PHP-FPM, where the actual website is built and managed.
- **MariaDB**: The relational database that safely stores all WordPress site data and user accounts.

## 2. Starting and Stopping the Project
The project is managed via a `Makefile` at the root of the repository.

- **To start the project**: Run `make` or `make up`. This will build the containers in the background.
- **To stop the project**: Run `make down`. This safely stops the containers without deleting your data.

## 3. Accessing the Website and Administration Panel
Before accessing the site, ensure your local `/etc/hosts` file routes the domain to your local machine:
`127.0.0.1 kacherch.42.fr`

- **Public Website**: Open your web browser and navigate to `https://kacherch.42.fr`. 
  *(Note: Because the SSL certificate is self-signed, your browser will display a security warning. You can safely bypass it by clicking "Advanced" -> "Proceed to site".)*
- **Administration Panel**: Navigate to `https://kacherch.42.fr/wp-admin`.

## 4. Locating and Managing Credentials
For maximum security, passwords are not stored in standard environment variables. They are managed using **Docker Secrets**.
- **Non-sensitive configuration** (domain name, usernames, titles) is located in the `.env` file at the root of the project.
- **Passwords** are stored in plain text files inside the `secrets/` directory. 
- To change a password, modify the corresponding `.txt` file in the `secrets/` directory *before* starting the containers.

*Warning: Neither the `.env` file nor the `secrets/` directory are tracked by Git to prevent credential leaks.*

## 5. Checking Service Health
To verify that all services are running correctly:
- Run `docker ps` to see the status of the three containers (`nginx`, `wordpress`, `mariadb`). They should all display an "Up" status.
- To view live logs and check for internal errors, use the command: `docker compose logs -f`
