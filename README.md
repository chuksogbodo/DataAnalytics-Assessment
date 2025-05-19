Question 1:
The question aims to identify customers who have both a savings and an investment plan with cross-selling opportunity.
The approach:
1. Joining some selected columns of the required tables. These included owner_id, username. The inner join was used to ensure 
only elements that are not related that are joined.
2. The SELECT statement was used to select elements key to the analysis before joining the tables at their relationship points. 

Challenges
I encountered errors initially while writing this code blocks "SUM(CASE WHEN p.is_regular_savings = 1 THEN 1 ELSE 0 END and ROUND(SUM(s.confirmed_amount) / 100.0, 2)." 
I was able to fix the challenge by consulting the internet and understanding how to navigate through this. This fixed the challenge.

Question 2:
Aim: to analyze how often customers transact to and segment them (e.g., frequent vs. occasional users).
I approached this challenge by joining the necessary columns of the required tables: user_customuser and savings_savingsaccount

Challenges
Starting with the right code block was a bit of a challenge since the end product was always different from the intended. However, I was able to fix this through the help of stackoverflow
and other internet resources. 

Question 3:
Aim: to flag accounts with no inflow transactions for over one year. The approach was to join the required tables through the primary key.

Challenges
While the SELECT and JOIN statements were no challenges, establishing the correct code blocks to get the exact requirement was challenging. There were errors in the code blocks. 
However, these were fixed. I also had help from online resources.

Question 4:
Aim: to help the Marketing team estimate CLV based on account tenure and transaction volume (simplified model).
The was also followed similar approaches as the other assessments. The JOINS were performed using the required columns from the required tables.

Challenges
This code block "TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
     COUNT(s.id) AS total_transactions,
        ROUND(AVG(s.confirmed_amount * 0.001 / 100), 2) AS avg_profit_per_transaction" was particularly challenging initially. But I was able to resolve this after consulting some resources. 

