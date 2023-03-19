## ais-etl
Thi repo contains the code for the AIS ETL process. 

## Pre-requisites
- Go --> https://go.dev/doc/install
- Run the following command to install the dependencies:
```make deps```

## How to run
To run the code, you need to have a .env file in the root of the project. The .env file should contain the variables 
from the .env.example file with the correct values.

To run the code, you need to run the following command:
```make run```

## Client package
The client package contains the code to connect to the AIS API and receive AIS data.

## Worker package
The worker package contains the code to process the AIS data and store it in the database.

## DAL package
The DAL package contains the code to connect to the database and perform CRUD operations. However, it is not yet 
implemented.