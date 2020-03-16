docker stop frontend
docker wait frontend
docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.windows-dev.yml up --build -d frontend
start https://localhost