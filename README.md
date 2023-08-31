
**Ruby on Rails Carpark Availability API**


The "Ruby on Rails Carpark Availability API" is a robust web application built using the Ruby on Rails framework. Its primary purpose is to deliver a powerful and accurate API endpoint that facilitates the retrieval of real-time carpark availability data in Singapore. The API is designed to provide users with the most up-to-date information about available parking slots, based on the latitude and longitude coordinates provided by the user.


**Features**


- Live Carpark Availability: The API is meticulously designed to deliver real-time carpark availability data, ensuring that users receive the latest information about parking slot availability.

- Precise Location-Based Search: Users can effortlessly provide their exact latitude and longitude coordinates, which the API utilizes to return a list of the nearest carparks in Singapore.

- Data Sourced from HDB: The API fetches its data from the Housing & Development Board (HDB) website, a reliable and authoritative source for carpark information in Singapore.


**How It Works**


- User's Location Coordinates: Users input their current location's latitude and longitude coordinates through the API's intuitive request structure.

- API Request Handling: The API processes the incoming request and uses the provided coordinates to identify the nearest carparks.

- Data Retrieval from HDB: The API accesses the Housing & Development Board website's comprehensive carpark dataset to gather accurate carpark details, including location, total slots, and current availability.

- Response Formation: The API constructs a well-structured JSON response containing the list of nearest carparks along with their respective availability information.


**Setup Instructions**


1. Install Homebrew (if not already installed):
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

2. Install GPG (if not already installed):
	brew install gpg

3. Install RVM:
	\curl -sSL https://get.rvm.io | bash -s stable

4. Install Ruby 3.0.0:
	rvm install 3.0.0

5. Set Ruby 3.0.0 as the default:
	rvm use 3.0.0 --default

6. Install MySQL using Homebrew:
	brew install mysql

7. Start MySQL database server on docker:
	docker compose up --build

8. Install required gems:
	bundle install

9. Run database migrations:
	rails db:migrate

10. Import carparks static information from csv already included in tmp file:
	rake load:import_carparks_information

11. Updates latest carpark availability from Carpark Availability API:
	rake load:update_carpark_availabilities

12. Start rails server on localhost 3000:
	rails server

13.	Access the API:
	Make API requests to http://localhost:3000/carparks/nearest?latitude=1.37326&longitude=103.897&page=1&per_page=10


**Approach**


Models:

1. Carpark:
	- The Carpark model is used to store carpark information.

	- It includes attributes like carpark_number, address, latitude, longitude and other fields.

	- The model utilizes the geocoder gem for geocoding the addresses and coordinates.

	- One Carpark may have only one CarparkAvailability.

	- Static data is loaded into to model from HBD dataset.

2. CarparkAvailability:
	- The CarparkAvailability model stores real-time availability information for carparks.

	- It includes attributes such as carpark_number, total_slots, and available_slots.

	- every CarparkAvailability belongs to one Carpark.

	- Data will be loaded from HBD API.


Gems Used:

1. geocoder: powerful ror geocoding gem, used to search closest carparks to a given geo co-ordinate.

	Benefits of Using Geocoder: 
		Accuracy: Geocoder provides accurate geocoding and reverse geocoding capabilities, ensuring precise location-based searches
		Simplicity: Implementing nearest searches becomes straightforward using the built-in methods provided by the geocoder gem.
		Flexibility: You can adjust search radius and parameters to suit your specific needs.

2. kaminari: used for pagination

3. rest-client: gem is used to make API calls to an external data source

4. active_interaction: gem is used for seperation of concerns and easy input validation.

5. rspec: to write unit tests

**Run Tests**

rspec ./spec/services/get_nearest_availabilities_spec.rb








