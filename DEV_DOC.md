# Developer Documentation (DEV_DOC)

This documentation provides developers with the necessary technical details to set up, build, and manage the infrastructure from scratch.

## 1. Environment Setup (From Scratch)

### Prerequisites
- Docker and Docker Compose (V2) must be installed on the host machine.
- `make` must be installed.
- The host machine must have the domain routed to localhost. Edit `/etc/hosts` as root and append: `127.0.0.1 kacherch.42.fr`

### Configuration and Secrets Setup
The repository does not contain sensitive data. Before building the project, you must manually create the configuration and secret files:

1. Create the `.env` file at the root of the project containing non-sensitive variables:
    SQL_HOST=mariadb
    SQL_DATABASE=wordpress_db
    SQL_USER=wp_user
    DOMAIN_NAME=kacherch.42.fr
    WP_TITLE=Inception
    WP_ADMIN_USER=kacherch_admin
    WP_ADMIN_EMAIL=admin@kacherch.42.fr
    WP_USER=visitor
    WP_USER_EMAIL=visiteur@kacherch.42.fr

2. Create the Docker Secrets in the terminal:
    mkdir secrets
    echo "your_db_password" > secrets/db_password.txt
    echo "your_root_password" > secrets/db_root_password.txt
    echo "your_wp_admin_password" > secrets/wp_admin_password.txt
    echo "your_wp_user_password" > secrets/wp_user_password.txt

3. Create the data directories on the host machine:
    mkdir -p /home/kacherch/data/mariadb
    mkdir -p /home/kacherch/data/wordpress

## 2. Building and Launching the Project
The project utilizes a Makefile to streamline Docker Compose commands.
- `make` or `make up`: Builds the images and starts the containers in detached mode (`docker compose up --build -d`).
- `make down`: Stops the containers and removes the networks (`docker compose down`).
- `make clean`: Stops containers and removes all project volumes to reset the databases.
- `make fclean`: Performs a total wipe, stopping containers, removing volumes, images, and clearing the host data directories.

## 3. Container and Volume Management Commands
Useful commands for debugging and management:
- Accessing a container shell: `docker exec -it <container_name> /bin/sh`
- Viewing live logs: `docker compose logs -f <service_name>`
- Inspecting volumes: `docker volume ls` and `docker volume inspect <volume_name>`
- Checking network connections: `docker network inspect srcs_inception`

## 4. Data Storage and Persistence
By default, Docker containers are ephemeral. To ensure data persists across container restarts and deletions, the project uses local bind mounts. 

Data is stored persistently on the host machine in the `/home/kacherch/data/` directory:
- `/home/kacherch/data/mariadb`: Contains all database tables and system files. It is mounted to `/var/lib/mysql` inside the MariaDB container.
- `/home/kacherch/data/wordpress`: Contains the core WordPress files, PHP scripts, themes, and uploaded media. It is mounted to `/var/www/wordpress` inside both the WordPress and NGINX containers.

If the containers are destroyed, the data remains intact in these host directories. To start fresh, you must manually delete the contents of these directories on the host machine.
