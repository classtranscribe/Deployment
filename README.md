# Deployment

### Getting Started

0. Install latest docker and docker-compose

   [Install Docker](https://www.docker.com/products/docker-desktop)
   
   Windows and Mac desktop builds already include docker-compose. You will need to start docker engine by opening the Docker app or restarting your machine.

1. Clone the repository (with it's submodules)

  `git clone --recurse-submodules https://github.com/classtranscribe/Deployment.git`
  
2. Enter repository.

  `cd Deployment/`
  
3. Update submodules.

  `git submodule foreach git pull origin master`

4. Then use the development build instructions or the production build instructions below -



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

(https://localhost/traefik/) - Web routing to multiple containers
(https://localhost/swag/) - List of ClassTranscribe API endpoints and verbs
(https://localhost/portainer/) - Container administration and health status


### Production build instructions

1. Create directories required for docker volumes using the script  `create_directories.sh`

  Usage `./create_directories.sh <absolute_path_to_an_empty_directory>`
  
  Eg. `./create_directories.sh /home/username/docker_data`
  
2. Make a copy of the `sample-environment-variable-file.env` as `.env`


  `cp sample-environment-variable-file.env .env`
  
3. Update all the required environment variables in the .env file, contact admin if clarification required.

4. Build and run docker-compose

  `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build -d`
  
  See above notes for Web endpoints.
  
