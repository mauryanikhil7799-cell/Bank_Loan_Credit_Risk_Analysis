/*
Loan Portfolio Analysis

Purpose
--- Analyze the Loan Portfolio by Loan Type, Term, Amount,
    Interest Rate and Status ---

Task--

How many loans are there by Loan Type?
What is the total loan amount by Loan Type?
What is the average loan amount by Loan Type?
What is the average interest rate by Loan Type?
How many loans are there by Loan Status?
What percentage of loans are in each status?
Which Loan Type has the highest loan amount?
Which Loan Type has the highest number of loans?
What is the average Loan Term by Loan Type?
What is the highest and minimum Loan Term?
*/

---Task-1 How many loans are there by Loan Type?---
SELECT
lt.Loan_Type,
l.Loan_Type_ID,
COUNT(Loan_ID) AS Total_Loan
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY l.Loan_Type_ID,lt.Loan_Type;

--- Task-2 What is the total loan amount by Loan Type?
SELECT
lt.Loan_Type,
l.Loan_Type_ID,
SUM(l.Loan_Amount) AS Total_Loan_Type_Amount
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type,
l.Loan_Type_ID;

---Task-3 What is the average loan amount by Loan Type make it High to Low?---
SELECT
lt.Loan_Type,
l.Loan_Type_ID,
AVG(l.Loan_Amount) AVG_Loan
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type,
l.Loan_Type_ID
ORDER BY AVG(l.Loan_Amount) DESC

---Task-4 How many loans are there by Loan Status?---
SELECT
Loan_Status,
COUNT(Loan_ID) AS Total_Loan
FROM Loan 
GROUP BY Loan_Status

---Task-5 What percentage of loans are in each status?---

SELECT
Loan_Status,
COUNT(Loan_ID) AS Total_Loan,
COUNT(Loan_ID) * 100.0/SUM(COUNT(Loan_ID)) OVER() AS Loan_Percentage
FROM Loan
GROUP BY Loan_Status;

---Task-6 Which Loan Type has the highest loan amount?---
SELECT TOP 1
lt.Loan_Type,
SUM(l.Loan_Amount) AS Total_Loan
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type
ORDER BY SUM(l.Loan_Amount) DESC

--- TASK-7 Which Loan Type has the highest number of loans?---
SELECT
lt.Loan_Type,
COUNT(l.Loan_ID) AS Total_Loan
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type
ORDER BY COUNT(l.Loan_ID) DESC

---Task-8 What is the average interest rate by Loan Type?---
SELECT
lt.Loan_Type,
AVG(l.Interest_Rate) AS Avg_Interest_Rate
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type
ORDER BY AVG(l.Interest_Rate)

---Task-9 What is the average Loan Term by Loan Type?---
SELECT
lt.Loan_Type,
AVG(l.Loan_Term_Months) AS Avg_Loan_Term
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID= lt.Loan_Type_ID
GROUP BY lt.Loan_Type
ORDER BY AVG(l.Loan_Term_Months)

---Task-10 What is the Higest Loan Term and Minimun Loan Term?
SELECT
MAX(Loan_Term_Months) Highest_Loan_Term,
MIN(Loan_Term_Months) Lowest_Loan_Term
FROM Loan