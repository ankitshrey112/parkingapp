#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
BOLD='\033[1m'

start_time=$(date +%s.%N)

echo -e "${YELLOW}******************************************************************** Running tests${NC}"
docker-compose exec web bundle exec rspec ./spec/services/get_nearest_availabilities_spec.rb
echo -e "${GREEN}******************************************************************** Tests executed seccessfully${NC}"

end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)

echo -e "${GREEN}${BOLD}******************************************************************** TESTS COMPLETED !!, Elapsed time -> ${elapsed_time}${NC}"
