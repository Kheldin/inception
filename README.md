*This project has been created as part of the 42 curriculum by kacherch.*

# Inception

## Description
The goal of this project is to broaden our knowledge of system administration by using Docker to containerize a complete web infrastructure. Rather than installing services directly on a host machine, we build and link isolated containers that communicate securely. 

This project sets up a LEMP-like stack (Linux, NGINX, MariaDB, PHP/WordPress). Every service is built from a custom Dockerfile based on **Alpine Linux** (for a lightweight footprint) and is managed via a single `docker-compose.yml` file. 

### Main Design Choices & Sources
- **Alpine Linux**: Chosen as the base image for all containers to minimize size and attack surface.
- **TLSv1.3 Only**: NGINX is configured as the sole entry point to the infrastructure, running strictly over HTTPS.
- **Custom Entrypoints**: PID 1 handling is properly managed using `exec` in shell scripts to ensure graceful shutdowns (avoiding exit code 137).
- **Security-First**: Database and admin credentials are removed from standard environment variables and injected securely using Docker Secrets.

### Technical Comparisons
As part of the system administration research for this project, the following architectural concepts were compared:

- **Virtual Machines vs Docker**: 
  Virtual Machines emulate an entire hardware stack and run a full guest Operating System, making them resource-heavy. Docker containers share the host OS kernel and isolate applications at the process level, making them significantly faster, lighter, and easier to deploy.
- **Secrets vs Environment Variables**: 
  Environment variables are easily exposed if a user gains shell access and types `env`, or if logs leak configuration details. Docker Secrets mount sensitive data into a temporary, in-memory file system (`/run/secrets/`), ensuring passwords are never permanently written to the container's disk or exposed in the environment block.
- **Docker Network vs Host Network**: 
  Using the host network binds container ports directly to the host's interfaces, removing isolation. Using a custom Docker Bridge Network (as done in this project) provides internal DNS resolution (containers can ping each other by name, e.g., `mariadb`) and completely isolates backend services like the database from the outside world.
- **Docker Volumes vs Bind Mounts**: 
  Docker Volumes are entirely managed by Docker and stored in `/var/lib/docker/volumes/`. Bind Mounts link a specific path on the host machine (e.g., `/home/kacherch/data`) directly to a directory inside the container. We use Bind Mounts in this project to ensure data persists easily on the host VM even if Docker is completely purged.

## Instructions
To compile and execute this project, follow these steps:

1. **Host Setup**:
   Ensure your local `/etc/hosts` file routes the domain to localhost:
   `127.0.0.1 kacherch.42.fr`

2. **Data Directories**:
   Create the required directories on your host machine to persist data:
   
       mkdir -p /home/kacherch/data/mariadb
       mkdir -p /home/kacherch/data/wordpress

3. **Environment & Secrets**:
   - Fill the `.env` file at the root with non-sensitive variables.
   - Create a `secrets/` directory at the root and add your password files (`db_password.txt`, `wp_admin_password.txt`, etc.).

4. **Execution**:
   Run the Makefile at the root of the repository:
   
       make

   This will build the images and launch the containers in the background. Access the site at `https://kacherch.42.fr`.

*For more detailed operational instructions, refer to USER_DOC.md and DEV_DOC.md.*

## Resources
**Classic References:**
- [Docker Documentation](https://docs.docker.com/)
- [Alpine Linux Wiki](https://wiki.alpinelinux.org/)
- [NGINX Official Documentation](https://nginx.org/en/docs/)
- [MariaDB Server Documentation](https://mariadb.com/kb/en/documentation/)

**Use of Artificial Intelligence:**
An AI assistant (LLM) was utilized during the development of this project for the following tasks:
- **Debugging and Error Resolution**: Troubleshooting specific Docker daemon errors, such as volume mounting issues and the `bind-address` syntax error in MariaDB.
- **Concept Clarification**: Understanding the technical reasons behind container exit code 137, PID 1 management, and the necessity of using the `exec` command in shell entrypoint scripts.
- **Documentation Structuring**: Generating the Markdown templates for `USER_DOC.md`, `DEV_DOC.md`, and this `README.md` to ensure compliance with the project's strict formatting guidelines.
