/*Добавьте в этот файл все запросы, для создания схемы сafe и
 таблиц в ней в нужном порядке*/
CREATE SCHEMA cafe;  

CREATE TYPE cafe.restaurant_type AS ENUM ('coffee_shop', 'restaurant', 'bar', 'pizzeria');

CREATE TABLE cafe.restaurants (
    restaurant_uuid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar NOT NULL,
    type cafe.restaurant_type NOT NULL,
    menu jsonb NOT NULL
);

CREATE TABLE cafe.managers (
    manager_uuid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar NOT NULL,
    phone text
);

CREATE TABLE cafe.restaurant_manager_work_dates (
    restaurant_uuid uuid REFERENCES cafe.restaurants(restaurant_uuid),
    manager_uuid uuid REFERENCES cafe.managers(manager_uuid), 
    start_date date NOT NULL, 
    end_date date NOT NULL,
    PRIMARY KEY (restaurant_uuid, manager_uuid)
);

CREATE TABLE cafe.sales (
    date date NOT NULL, 
    restaurant_uuid uuid REFERENCES cafe.restaurants(restaurant_uuid),
    avg_check numeric(6, 2) NOT NULL,
    PRIMARY KEY (restaurant_uuid, date)
);
