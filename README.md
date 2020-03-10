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
  
### Development build on a local machine

1. Obtain a `.env` file from an admin and place it in `Deployment/`

2. Build and run docker-compose

  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d`

A successful build will take 10 minutes and return to your shell prompt. The last few lines will be similar to -

````sh
Creating rabbitmq  ... done
Creating rpcserver ... done
Creating frontend  ... done
Creating traefik   ... done
Creating db        ... done
Creating pgadmin    ... done
Creating portainer  ... done
Creating api        ... done
Creating taskengine ... done
````

3. Open the web app at [localhost](https://localhost) and accept the insecure self-generated https certificate
The web server will initially report a bad gateway while the container finishes building the ClassTranscribe container.

To view the build of the ClassTranscribe container use
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

### Frontend only Local Development

In such a development environment only the frontend code runs locally, while all the backend is run on a VM,
To run this, 
1. Make a copy of the `sample-environment-variable-file.local.frontend.env` as `.env`

  `cp sample-environment-variable-file.local.frontend.env .env`
  
2. Update all the required environment variables in the .env file, (instructions are provided in the sample file), contact admin if clarification required.

3. Build and run docker-compose only for frontend

  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d frontend`

### Local Development on a Windows Machine

As mounting docker volumes is not the easiest thing on a windows machines some extra care has to be taken. An additional docker-compose file - [docker-compose.windows-dev.yml](docker-compose.windows-dev.yml) is used to allow for such incompatibilities.

To use this file,
If a typical docker-compose command is,
`docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d`

It becomes,
`docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.windows-dev.yml up --build -d`

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
  
