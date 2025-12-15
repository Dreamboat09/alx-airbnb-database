# Unleashing Advanced Querying Power

### 1. INNER JOIN — Get all bookings AND the users who made those bookings
Meaning: Only show rows where a booking has a matching user (i.e., user_id exists in both tables).

### 2. LEFT JOIN — Get all properties including those with no reviews
Meaning: Show all properties even if they have zero reviews.Reviews will appear as NULL when missing.

### 3. FULL OUTER JOIN — Get all users and all bookings
Even if: A user has no booking, OR A booking has no valid user_id


## correlated and non-correlated subqueries 
Non-correlated subquery → runs once, result reused
Correlated subquery → runs once per row in the outer query