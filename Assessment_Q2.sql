/*Transaction Frequency Analysis
Aim: to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)
Tables used:
1. users_customuser
2. savings_savingsaccount

The code block is divided into 3 segments: monthly transactions per user, average transactions per user, and labeled users
*/

WITH transactions_per_user_month AS (
    SELECT
        s.owner_id,
        DATE_FORMAT(s.maturity_start_date, '%Y-%m') AS year_month_str,
        COUNT(*) AS monthly_transactions
    FROM savings_savingsaccount s
    GROUP BY s.owner_id, year_month_str
),
average_transactions_per_user AS (
    SELECT
        u.id AS user_id,
        ROUND(AVG(t.monthly_transactions), 2) AS avg_transactions_per_month
    FROM users_customuser u
    INNER JOIN transactions_per_user_month t ON u.id = t.owner_id
    GROUP BY u.id
),
labeled_users AS ( /*The code block calculates number of customers with average transaction more than 10 in a month. 
					They are labelled "High Frequency", etc.*/
    SELECT
        user_id,
        avg_transactions_per_month, 
        CASE
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM average_transactions_per_user
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM labeled_users
GROUP BY frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
