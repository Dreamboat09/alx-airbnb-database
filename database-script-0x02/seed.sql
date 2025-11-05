
INSERT INTO user (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
(1, 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw_1', '1234567890', 'guest', '2025-01-10'),
(2, 'Bob', 'Miller', 'bob@example.com', 'hashed_pw_2', '0987654321', 'host', '2025-02-15'),
(3, 'Charlie', 'Smith', 'charlie@example.com', 'hashed_pw_3', '1122334455', 'admin', '2025-03-05');


INSERT INTO property (property_id, user_id, name, description, location, price_per_night, created_at, updated_at)
VALUES
(1, 2, 'Seaside Cottage', 'Cozy cottage by the beach with ocean views.', 'Malibu, CA', 250.00, '2025-04-01', '2025-04-15'),
(2, 2, 'Mountain Cabin', 'Rustic cabin surrounded by pine trees.', 'Aspen, CO', 180.00, '2025-04-10', '2025-04-12'),
(3, 2, 'City Apartment', 'Modern apartment in downtown area.', 'New York, NY', 300.00, '2025-05-01', '2025-05-05');


INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
(1, 1, 1, '2025-06-10', '2025-06-15', 1250.00, 'confirmed', '2025-06-01'),
(2, 2, 1, '2025-07-01', '2025-07-04', 540.00, 'pending', '2025-06-20'),
(3, 3, 1, '2025-08-15', '2025-08-20', 1500.00, 'canceled', '2025-07-30');
