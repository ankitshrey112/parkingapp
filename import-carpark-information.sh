#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
BOLD='\033[1m'

start_time=$(date +%s.%N)

echo -e "${YELLOW}******************************************************************** Importing carpark details${NC}"
docker-compose exec web bundle exec rake load:import_carparks_information
echo -e "${GREEN}******************************************************************** Imported carpark details successfully${NC}"

end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)

echo -e "${GREEN}${BOLD}******************************************************************** IMPORTED SUCCESSFULLY !!, Elapsed time -> ${elapsed_time}${NC}"
