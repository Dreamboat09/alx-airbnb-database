SELECT 
    bookings.*,
    users.*
FROM bookings
INNER JOIN users
    ON bookings.user_id = users.id;


SELECT 
    properties.*,
    reviews.*
FROM properties
LEFT JOIN reviews
    ON reviews.property_id = properties.id;


SELECT 
    users.*,
    bookings.*
FROM users
FULL OUTER JOIN bookings
    ON bookings.user_id = users.id;
