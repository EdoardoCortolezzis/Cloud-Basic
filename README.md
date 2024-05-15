## Deployment

To deploy the cloud system on your local machine using Docker and Docker Compose, follow these steps:

1. **Install Dependencies**: Ensure that Docker and Docker Compose are installed on your machine.

2. **Clone Repository**: Clone the repository containing the project files to your local machine.

3. **Configuration**: Review the configuration files, particularly the `docker-compose.yaml` file, and modify them according to your specific requirements. This includes adjusting ports, volumes, and services as necessary.

4. **Deployment**: To deploy the system without testing, run the following command:
   ```bash
   docker-compose -f docker-compose.yaml up -d
   ```
This command will start the services defined in the docker-compose.yaml file and create the containers for the system.

5. **Access the System**: Once deployed, access the Nextcloud instance at http://localhost:8081. Log in as an admin using the credentials defined in the docker-compose.yaml file and begin using the system.


6.**Optional Testing**: If you wish to perform load testing, deploy a Locust instance using the following command:
   ```bash
   docker-compose -f docker-compose-locust.yaml up -d
   ```
After deploying Locust, you can run the provided scripts to create users (create_users.sh) and conduct performance testing (locust_test.py) through the locust interface at http://localhost:8089.
