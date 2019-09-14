# Deployment

### Getting Started

1. Open the `.env` file in the `/Deployment` folder and go the the environment variables for FrontEnd. Obtain the env variables `REACT_APP_DOMAIN` and `REACT_APP_CLIENT_ID` from an admin.

2. Run the app at [localhost 3000](http://localhost:3000)
```
$ docker-compose -f docker-compose.yml -f docker-compose.frontend.dev.yml up frontend
```