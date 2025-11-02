CREATE TABLE user (
user_id INT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
password_hash VARCHAR(100) NOT NULL,
phone_number VARCHAR (15),
role ENUM ('guest', 'host', 'admin'), NOT NULL,
created_at DATE
);



CREATE TABLE property (
property_id INT PRIMARY KEY,
user_id, REFERENCES user(user_id),
name VARCHAR(50) NOT NULL,
decription TEXT NOT NULL,
location VARCHAR NOT NULL,
pricepernight DECIMAL NOT NULL,
created_at DATE,
updated_at DATE                                                                                        
);



CREATE TABLE booking (
booking_id INT PRIMARY KEY,
property_id REFERENCES property(property-id),
user_id REFERENCES user(user_id);
start_date DATE NOT NULL,
end_date DATE NOT NULL,
total_price DECIMAL not NULL,
status ENUM ('pending', 'confirmed', 'canceled') NOT NULL,
created_at DATE
):