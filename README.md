# Deployment

### Getting Started

0. Install latest docker and docker-compose
1. Clone the repository (with it's submodules)
  `git clone --recurse-submodules https://github.com/classtranscribe/Deployment.git`
2. Enter repository.
  `cd Deployment/`
3. Update submodules.
  `git submodule foreach git pull origin master`

For a development build on a local machine,

1. Obtain a `.env` file from an admin.

2. Build and run docker-compose
  `docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d`
3. Run the app at [localhost](http://localhost)

For a production build do the following,

1. Create directories required for docker volumes using the script  `create_directories.sh`
  Usage `./create_directories.sh <absolute_path_to_an_empty_directory>`
  Eg. `./create_directories.sh /home/username/docker_data`
  
2. Make a copy of the `sample-environment-variable-file.env` as `.env`
  `cp sample-environment-variable-file.env .env`
  
3. Update all the required environment variables in the .env file, contact admin if clarification required.

4. Build and run docker-compose
  `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build -d`
