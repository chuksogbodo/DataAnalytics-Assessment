/*High-Value Customers with Multiple Products
Aim: to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
Tables used:
1. users_customuser
2. savings_savingsaccount
3. plans_plan
*/

SELECT
    u.id AS owner_id,
    u.username AS name,
    SUM(CASE WHEN p.is_regular_savings = 1 THEN 1 ELSE 0 END) AS savings_count, -- This portion counts the number of regular savings plan
    SUM(CASE WHEN p.is_a_fund = 1 THEN 1 ELSE 0 END) AS investment_count, -- This portion counts the number of investment plan
    ROUND(SUM(s.confirmed_amount) / 100.0, 2) AS total_deposits -- this sums the total deposits of the customer to the nearest whole number
FROM savings_savingsaccount s
INNER JOIN users_customuser u ON s.owner_id = u.id -- inner join of savings_savingsaccount and users_customuser at their relationship point
INNER JOIN plans_plan p ON s.plan_id = p.id -- inner join of savings_savingsaccount and plans_plan at their relationship point
WHERE s.confirmed_amount > 0
GROUP BY u.id, u.username
HAVING 
    savings_count > 0 AND investment_count > 0 -- savings_count and investment_count of the customer must not be zero or less 
ORDER BY total_deposits DESC;