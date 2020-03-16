# Initial setup

 ### Install git and Docker

Install git and the latest docker (which already contains docker-compose)

   [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   
   [Install Docker](https://www.docker.com/products/docker-desktop)
   
   Start the Docker engine by either opening the Docker app or restarting your machine.
   
   You will also need an editing environment. These instructions assume you have [VS Code](https://code.visualstudio.com/) installed.
      
### Clone the ClassTranscribe Repository

Clone the repository (with it's submodules). If using VS Code, open a shell then type

  `git clone --recurse-submodules https://github.com/classtranscribe/Deployment.git`
  
Enter the repository and update the submodules.

  `cd Deployment/`

  `git submodule foreach git pull origin master`

* Use the development build instructions or the production build instructions below.
  
### Option 1- Frontend only Local Development

This option is designed for frontend web developers. The frontend code runs locally, while all the backend is run on a remote Virtual Machine.

1. Make a copy of the `sample-environment-variable-file.local.frontend.env` as `.env`

  `cp sample-environment-variable-file.local.frontend.env .env`
  
2. Update the required environment variables in the .env file, (instructions are provided in the sample file) to connect to your development server.

3. Build and run docker-compose only for frontend

  Mac OSX and Linux:
  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d frontend`
  
  Windows 10:
  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.windows-dev.yml up --build -d frontend`

4. Use a browser to open the home page

  http://localhost/

### Windows 10 docker-compose technical note

Tech note: Mounting docker volumes is prone to errors on a Windows machines. An additional docker-compose file, [docker-compose.windows-dev.yml](docker-compose.windows-dev.yml) is used to overcome some current incompatibilities of the Windows Subsystem for Linux environment. We expect this additional file will not be required when using WSL2 and this documentation will be updated in the future. To use this workaround append ```-f docker-compose.windows-dev.yml``` to the list of compose files For example, if a typical docker-compose command is,
`docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d`

The command becomes,
`docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.windows-dev.yml up --build -d`

### Full FrontEnd and Backend Development

We recommend you first complete the frontend instructions above.

1. The environment file `.env` in `Deployment/` includes API keys for external services and passwords for backend components. To create the file either
i) Copy an existing `.env` file from another developer. Or,
ii) Copy and edit the empty template file [sample-environment-variable-file.env](https://github.com/classtranscribe/Deployment/blob/master/sample-environment-variable-file.env) and save it as `.env`

2. Build and run docker-compose to initially build and start all containers

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
taskengine (ClassTranscribe's backend non-interactive batch tasks)
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

For the impatient:  To view the build status of the ClassTranscribe container use the tail option on the frontend logs
```sh
docker-compose logs -f --tail="100" frontend
```

and expect to see 'Starting the development server...' after successful build of the frontend

Next Steps. To start development see the [Development-GettingStarted](./Development-GettingStarted.md) instructions.

### Web endpoints

(The trailing slashes are important)
* (https://localhost/traefik/) - Web routing to multiple containers
* (https://localhost/swag/) - List of ClassTranscribe API endpoints and verbs
* (https://localhost/portainer/) - Container administration and health status
* (https://localhost/pgadmin/) - Web GUI tool to manage the database
* (https://localhost/rabbitmq/) - RabbitMQ dashboard

### Production build instructions
1. We assume you have already created a virtual machine, with TCP ports 80 and 443 publicly available, created a local user (e.g. 'classtranscribeuser') and associated home directory.

2. Create a root directory to hold ClassTranscribe data (files, database). Initialize the sub-directories to store the data using the script `create_directories.sh`
  
  For example, `./create_directories.sh /home/classtranscribeuser/docker_data`

3. Make a copy of the `sample-environment-variable-file.env` as `.env` inside the `Deployment` directory

  `cp sample-environment-variable-file.env .env`
  
4. Update all the required environment variables in the .env file, (instructions are provided in the sample file), contact admin if clarification required.

5. To pull the latest build and run ClassTranscribe

 `docker-compose up --pull --build -d`
 
 or to build and run the current local version

`docker-compose up  --build -d`

For initial testing of the production server, please see the web endpoints listed above. For security `TRAEFIK_IPFILTER` can be used to ensure that all services apart from the frontend are only reachable by a limited set of IP addresses.
By default `TRAEFIK_IPFILTER` is configured to be `127.0.0.1`


6. An example cron entry is shown below to automatically restart the service when the server is rebooted.

```sh
@reboot sleep 20 && /usr/local/bin/docker-compose -f /home/classtranscribeuser/Deployment/docker-compose.yml up --build -d
```
