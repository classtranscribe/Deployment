# Getting started

We assume you've already followed the [README](README.md) instructions for setting up the local Development Docker build and have at least the frontend version running or the full stack running.

## Connect with us

We use slack class-transcribe.illinois.edu

## Install the development environment (Mac, Linux, Windows):

* Install [Visual Studio Code](https://code.visualstudio.com/download)
* Select Code Menu>Preferences>Extensions.  Install the "Docker" Extension by Microsoft for VS Code. For more information see (https://code.visualstudio.com/docs/azure/docker).
* To develop and debug remote: The Microsoft Extensions "Remote - SSH" and "Remote - SSH: Editing Configuration Files
ms-vscode-remote.remote-ssh-edit" are also recommended.

## Recommended documentation for frontend developers

The frontend libraries are listed in [FrontEnd/package.json](https://github.com/classtranscribe/FrontEnd/blob/master/package.json). We are using
* [pico-ui]()
* [semantic-ui](https://react.semantic-ui.com/)
* [react-redux](https://react-redux.js.org/)

## Recommended documentation for backend developers

* [Dockerfile](https://docs.docker.com/engine/reference/builder/) [Compose file](https://docs.docker.com/compose/compose-file/)
* The Web API is implemented using (https://docs.microsoft.com/en-us/aspnet/core/tutorials/first-web-api?view=aspnetcore-3.0&tabs=visual-studio)
* Data is stored in a SQL database, postgreSQL. (https://www.postgresql.org/docs/current/tutorial-sql.html)

## Development cycle and practices

* We use the WebAPI project to track bugs and to dos.
* Before making modifications, create a branch e.g. myname-2020-01-explore and send code review or pull requests to merge in master
* The WebAPI provides a pure REST API. Based on the .env settings frontend react development can therefore send API requests to the dev server, localhost or in theory but not recommended, production

## Versioning

* The main server at classtranscribe.illinois.edu uses the head commit of the master branch all subprojects
* The commit hashes stored in the Deployment/ are ignoed
* The development server is updated 3am
* The production server is restarted at 3am


## Known gotchas (Windows)

* If docker builds fail during `apt update` with a complaint that updates are in the future, the docker container  time is out of sync. Fix: Restart docker.
* Docker commands can be tediously slow on Windows-10 enterprise/nuiversity-controlled laptops if not connected to the VPN. Workaround: use a VPN
