// load('/usr/local/mongodb/cars.js')
// for demo prupose only, use BSON int as much as possible
var cars = [
    {
        brand: 'Toyota', model: 'Supra',  engine: 'Petrol',   gearbox: 'Manual'
    },
    {
        brand: 'Toyota', model: 'Camry',  engine: 'Petrol',   gearbox: 'Auto', mileage:120000,  year:2010
    },
    {
        brand: 'Honda',  model: 'CR-V',   engine: 'Hybrid',   gearbox: 'CVT',  
    },
    {
        brand: 'Honda',  model: 'Civic',  engine: 'Petrol',   gearbox: 'Auto',  mileage:NumberInt(5000),  year:2019
    },
    {
        brand: 'Toyota', model: 'Corolla', engine: 'Petrol',  gearbox: 'Manual',  mileage:NumberLong(200000),year:2000
    },
    {
        brand: 'Honda',  model: 'Accord',  engine: 'Diesel',  gearbox: 'CVT',  mileage:NumberLong(65000), year:2010
    },
    {
        brand: 'Lexus',  model: 'RX350H',  engine: 'Hybrid',  gearbox: 'CVT',   mileage:7000,    year:2018
    },
    {
        brand: 'Nissan',  model: 'Leaf',  engine: 'Electric',  gearbox: 'CVT',   mileage:15000,    year:2010
    },
    {
        brand: 'Ford',  model: 'F-150',  engine: 'Petrol',  gearbox: 'Auto',   mileage:27000,    year:2015
    },
    {
        brand: 'Honda',  model: 'Civic',  engine: 'Diesel',  gearbox: 'Manual',   mileage:35000,    year:2016
    }
]