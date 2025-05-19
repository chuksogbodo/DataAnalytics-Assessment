/*Account Inactivity Alert
Aim: to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

Tables used:
1. plans_plan
2. savings_savingsaccount
*/

SELECT
    s.plan_id,
    s.owner_id,
    CASE -- Build a case savings and investments --
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Not available'
    END AS type,
    MAX(s.maturity_start_date) AS last_transaction_date, -- To find the most recent transaction for each user --
    DATEDIFF(CURDATE(), MAX(s.maturity_start_date)) AS inactivity_days
FROM savings_savingsaccount s -- s is used as alias for savings_savingsaccount--
INNER JOIN plans_plan p ON s.plan_id = p.id
WHERE s.confirmed_amount > 0
GROUP BY s.plan_id, s.owner_id, type
HAVING MAX(s.maturity_start_date) <= DATE_SUB(CURDATE(), INTERVAL 365 DAY) -- This filters inactive accounts for one year or more--
ORDER BY inactivity_days DESC;