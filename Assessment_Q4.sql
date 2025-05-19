/*Customer Lifetime Value (CLV) Estimation
Aim: to help the Marketing team estimate CLV based on account tenure and transaction volume (simplified model).
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
1. Account tenure (months since signup)
2. Total transactions
3. Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest

Tables used:
1. users_customuser
2. savings_savingsaccount

*/

WITH user_transactions AS (
    SELECT
        u.id AS customer_id,
        u.username AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months, -- This code block calculates how long a user has been using cowrywise --
        COUNT(s.id) AS total_transactions,
        ROUND(AVG(s.confirmed_amount * 0.001 / 100), 2) AS avg_profit_per_transaction -- The average transaction is rounded off to the nearest kobo --
    FROM users_customuser u
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    WHERE s.confirmed_amount > 0
    GROUP BY u.id, u.username, u.date_joined
),
/*The code block shows the total number of a customers transactions. This is rounded off to the nearest whole number. However, the (total_transactions / NULLIF(tenure_months, 0) 
avoids division by zero. It calculates the total Customer estimated life-time value*/
clv_estimate AS ( 
    SELECT
        customer_id,
        name,
        tenure_months,
        total_transactions,
        ROUND((total_transactions / NULLIF(tenure_months, 0)) * 12 * avg_profit_per_transaction, 2) AS estimated_clv 
    FROM user_transactions
)
SELECT *
FROM clv_estimate
ORDER BY estimated_clv DESC;
