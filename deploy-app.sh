#!/bin/bash

#restarts services, runs db migrations, runs rake tasks for data initialization, runs tests, redirects to browser 

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'

MYSQL_USER="user"
MYSQL_PASSWORD="password"
MYSQL_DATABASE="parking-db"

start_time=$(date +%s.%N)

echo -e "${YELLOW}******************************************************************** Stopping services${NC}"
docker-compose down web
echo -e "${GREEN}******************************************************************** Services stopped successfully${NC}"

echo -e "${YELLOW}******************************************************************** Starting services${NC}"
docker-compose up --build -d
docker-compose exec web rm /app/tmp/pids/server.pid
echo -e "${GREEN}******************************************************************** Services started successfully${NC}"

echo "${YELLOW}******************************************************************** Waiting for database connection"
until docker-compose exec db mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1"; do
	echo -e "${BLUE}ping${NC}"  
	sleep 1
done
echo -e "${GREEN}******************************************************************** Database connected successfully${NC}"

echo -e "${YELLOW}******************************************************************** Running database migration${NC}"
docker-compose exec web bundle exec rails db:migrate
echo -e "${GREEN}******************************************************************** Database migrations completed successfully${NC}"

end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)

echo -e "${GREEN}${BOLD}******************************************************************** DEPLOYED SUCCESSFULLY !!, Elapsed time -> ${elapsed_time}${NC}"
