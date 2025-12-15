SELECT
    u.id AS user_id,
    u.first_name,
    u.last_name,
    COUNT(b.id) AS total_bookings
FROM users u
LEFT JOIN bookings b
    ON b.user_id = u.id
GROUP BY u.id, u.first_name, u.last_name
ORDER BY total_bookings DESC;




SELECT
    p.id AS property_id,
    p.name,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS property_rank
FROM properties p
LEFT JOIN bookings b
    ON b.property_id = p.id
GROUP BY p.id, p.name
ORDER BY property_rank;

SELECT
    p.id AS property_id,
    p.name,
    COUNT(b.id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS property_row_number
FROM properties p
LEFT JOIN bookings b
    ON b.property_id = p.id
GROUP BY p.id, p.name
ORDER BY property_row_number;
