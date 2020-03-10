# Initial setup

 ### Install git and Docker

Install git and the latest docker (which already contains docker-compose)

   [Install git for OSX](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   
   [Install Docker](https://www.docker.com/products/docker-desktop)
   
   Start the Docker engine by either opening the Docker app or restarting your machine.
      
### Clone the ClassTranscribe Repository

Clone the repository (with it's submodules)

  `git clone --recurse-submodules https://github.com/classtranscribe/Deployment.git`
  
Enter repository.

  `cd Deployment/`
  
Update submodules.

  `git submodule foreach git pull origin master`

* Use the development build instructions or the production build instructions below.
  
### Option 1- Frontend only Local Development

In such a development environment only the frontend code runs locally, while all the backend is run on a remote VM,
To run this, 
1. Make a copy of the `sample-environment-variable-file.local.frontend.env` as `.env`

  `cp sample-environment-variable-file.local.frontend.env .env`
  
2. Update the required environment variables in the .env file, (instructions are provided in the sample file).

3. Build and run docker-compose only for frontend

  Mac OSX and Linux:
  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d frontend`
  
  Windows 10:
  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.windows-dev.yml up --build -d frontend`

4. Use a browser to open the home page

  http://localhost/

### Windows 10 docker-compose technical note

Tech note: Mounting docker volumes is prone to errors on a windows machines. An additional docker-compose file, [docker-compose.windows-dev.yml](docker-compose.windows-dev.yml) is used to overcome some current incompatibilities of the Windows Subsystem for Linux environment. We expect this additional file will not be required when using WSL2 (this documentation will be updated in the future). To use this file add ```-f docker-compose.windows-dev.yml``` For example, if a typical docker-compose command is,
`docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d`

The command becomes,
`docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.windows-dev.yml up --build -d`

### Full FrontEnd and Backend Development

We recommend you first complete the frontend instructions above.

1. The environment file `.env` in `Deployment/` includes API keys for external services and passwords for backend components. To create the file either
i) Copy an existing `.env` file from another developer. Or,
ii) Start with the empty template env files (e.g. [sample-environment-variable-file.env](https://github.com/classtranscribe/Deployment/blob/master/sample-environment-variable-file.env) 

2. Build and run docker-compose to initially build and run all items

  Mac OSX and Linux:
  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d`
  
  Windows 10:
  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.windows-dev.yml up --build -d`

A successful build of all docker components will take 10 minutes and return to your shell prompt. Future builds are faster. 

The last few lines will be similar to -

````sh
Creating rabbitmq  ... done
Creating noderpcserver ... done
Creating pythonrpcserver ... done
Creating frontend  ... done
Creating traefik   ... done
Creating db        ... done
Creating pgadmin    ... done
Creating portainer  ... done
Creating api        ... done
Creating taskengine ... done
````

ClassTranscribe code is comprised of three containers -
````sh
frontend (the react code for the browser)
api (Provides Web-based REST API)
taskengine (Backend non-interactive batch tasks)
````

The third-party docker containers are 
````sh
rabbitmq, a third-party message queue service used to schedule backend tasks;
noderpcserver and pythonrpcserver to receive jobs from the message queue; 
traefik, a reverse proxy that routes web traffic to the appropriate container;
db, the SQL postgres database;
pgadmin, a web-based admin console for the database;
portainer, a web-based tool to manage and monitor docker containers.
````

3. Open the web app at [localhost](https://localhost) and accept the insecure self-generated https certificate
The web server will initially report a bad gateway while the container finishes building the ClassTranscribe container.

For the impatient - To view the build status of the ClassTranscribe container use the tail option on the frontend logs
```sh
docker-compose logs -f --tail="100" frontend
```

and expect to see 'Starting the development server...' after successful building of the frontend

To start development see the [Development-GettingStarted](./Development-GettingStarted.md) instructions.

### Web endpoints

(The trailing slashes are important)
* (https://localhost/traefik/) - Web routing to multiple containers
* (https://localhost/swag/) - List of ClassTranscribe API endpoints and verbs
* (https://localhost/portainer/) - Container administration and health status
* (https://localhost/pgadmin/) - Web GUI tool to manage the database
* (https://localhost/rabbitmq/) - RabbitMQ dashboard

### Production build instructions

* Create directories required for storing all the data using the script `create_directories.sh`

  Usage `./create_directories.sh <absolute_path_to_an_empty_directory>`
  
  Eg. `./create_directories.sh /home/username/docker_data`


1. Make a copy of the `sample-environment-variable-file.env` as `.env`

  `cp sample-environment-variable-file.env .env`
  
2. Update all the required environment variables in the .env file, (instructions are provided in the sample file), contact admin if clarification required.

3. Build and run docker-compose

  `docker-compose up --build -d`
  
  See notes above for Web endpoints.
  
