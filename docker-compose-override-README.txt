# on dev/local machine, copy this file as "docker-compose.override.yml"

version: "3.4"

services:
  frontend:
    image: node:lts    
    volumes:
      - ./FrontEnd:/frontend
      - /frontend/node_modules
    env_file:
      .env
    container_name: "frontend"
    labels:
      - "traefik.enable=true"
      - "traefik.backend=frontend"
      - "traefik.port=3000"
      - "traefik.frontend.rule=PathPrefix: /"
      - "traefik.website.frontend.whiteList.sourceRange=${TRAEFIK_IPFILTER:-172.16.0.0/12}"
    command: /bin/sh -c "cd frontend; yarn; yarn install; yarn start"
  
  pythonrpcserver:    
    volumes:
      - "${DATA:-~/docker_data}/data:/data"
  
  db:
    ports:
      - "5432:5432"

  pgadmin:
    image: dpage/pgadmin4:4.11
    depends_on:
      - db
      - traefik
    volumes:
      - "${DATA:-~/docker_data}/pga4volume:/var/lib/pgadmin"
    env_file:
      - ".env"
    environment:
      - PGADMIN_DEFAULT_EMAIL=${ADMIN_USER_ID:-guest}
      - PGADMIN_DEFAULT_PASSWORD=${ADMIN_PASSWORD:-guest}
    container_name: "pgadmin"
    labels:
      - "traefik.enable=true"
      - "traefik.backend=pgadmin"
      - "traefik.port=80"
      - "traefik.frontend.rule=PathPrefix:/pgadmin"
      - "traefik.website.frontend.whiteList.sourceRange=${TRAEFIK_IPFILTER:-172.16.0.0/12}"

  elasticsearch:
    ports:
      - "9200:9200"
      - "9300:9300"

  kibana:
    container_name: kibana
    image: docker.elastic.co/kibana/kibana:7.6.2
    ports:
      - 5601:5601
    depends_on:
      - elasticsearch
    environment:
      - ELASTICSEARCH_URL=http://localhost:9200
    # environment:
    #   - SERVER_BASEPATH=/kibana/
    labels:
      - "traefik.enable=true"
      - "traefik.backend=frontend"
      - "traefik.port=5601"
      - "traefik.frontend.rule=PathPrefix: /kibana/"
      - "traefik.website.frontend.whiteList.sourceRange=${TRAEFIK_IPFILTER:-172.16.0.0/12}"

  rabbitmq:
    ports:
      - "5672:5672"
  