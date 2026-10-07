/*
Customer & Credit Risk Analysis
Purpose
---	Analyze customer Characteristics and credit analysis indicaotors based
	on Employment Status Income Loan Exposure and default Behaviour---

Task 1  → How many customers are there by employment status?
Task 2  → What is the average income by employment status?
Task 3  → What is the average credit score by employment status?
Task 4  → How many customers fall into different credit-score ranges?
Task 5  → What is the default rate by credit-score range?
Task 6  → What is the default rate by employment status?
Task 7  → What is the total loan amount by credit-score range?
Task 8  → Which customers have the highest total loan exposure?
Task 9  → Which customers have multiple loans?
Task 10 → What is the default rate by loan type?
*/

USE Bank_Loan_Credit_Risk_Analysis

---Task-1 Write a query to get the total no of customer by emplyememt status---
SELECT
Employment_Status,
COUNT(Customer_ID) AS Total_Customer
FROM Customers
GROUP BY Employment_Status
ORDER BY COUNT(Customer_ID);

---Task-2 Write a query to get the average income by employement status---
SELECT
Employment_Status,
AVG(Annual_Income) AS Avg_Income
FROM Customers
GROUP BY Employment_Status
ORDER BY AVG(Annual_Income)

---Task-3 Write a query to get the avg_credit_score of customer By Employement status---
SELECT
Employment_Status,
AVG(Credit_Score) AS Avg_Credit_score
FROM Customers
GROUP BY Employment_Status
ORDER BY AVG(Credit_Score)

---Task-4 Write a Query to make three credit range 700 and above Excellent below 700 Average and below 600 Poor and find out total no of Customer from diffrent Credit Range---

SELECT
CASE
	WHEN Credit_Score>=700 THEN 'Excellent'
	WHEN  Credit_Score>=600 AND Credit_Score<=699 THEN 'Average'
	ELSE 'Poor'
END AS Credit_Range,
COUNT(Customer_ID) AS Total_Customers
FROM Customers
GROUP BY CASE
	WHEN Credit_Score>=700 THEN 'Excellent'
	WHEN  Credit_Score>=600 AND Credit_Score<=699 THEN 'Average'
	ELSE 'Poor'
END
ORDER BY CASE
	WHEN Credit_Score>=700 THEN 'Excellent'
	WHEN  Credit_Score>=600 AND Credit_Score<=699 THEN 'Average'
	ELSE 'Poor'
END

---Task-5 Write a query to get the Defaule Rate by Credit Range---

SELECT
Credit_Range,
COUNT(*) AS Total_Loan,
SUM(Default_Flag) as Default_Loan,
CAST(SUM(Default_Flag)*100.0/COUNT(*) AS DECIMAL (10,2)) AS Default_Rate
FROM
(
	SELECT
	CASE 
		WHEN c.Credit_Score>= 700 THEN 'Excellent'
		WHEN c.Credit_Score>= 600 AND c.Credit_Score<=699 THEN 'Average'
		ELSE 'Poor'
		END AS Credit_Range,
		l.Default_Flag
	FROM Loan AS l
	JOIN Customers AS c
	ON c.Customer_ID=l.Customer_ID
) AS T
GROUP BY Credit_Range

---Task-6 Write a query to get the Defaukt rate by Employee status---
SELECT
c.Employment_Status,
COUNT(*) AS Total_Loan,
SUM(l.Default_Flag) AS Default_Loan,
CAST(SUM(l.Default_Flag)*100.0/COUNT(*) AS decimal(10,2)) AS Default_Rate
FROM Loan AS l
JOIN Customers AS c
ON c.Customer_ID=l.Customer_ID
GROUP BY c.Employment_Status

---Task-7 Write a query to get the total amount of Loan by Credit range---
SELECT
CASE 
	WHEN c.Credit_Score>= 700 THEN 'Excellent'
	when c.Credit_Score>=600 AND c.Credit_Score <= 699 THEN 'Average'
	ELSE 'Poor'
END AS Credit_Range,
SUM(l.Loan_Amount) AS Total_Loan
FROM Loan AS l
JOIN Customers AS c
ON c.Customer_ID=l.Customer_ID
GROUP BY CASE 
	WHEN c.Credit_Score>= 700 THEN 'Excellent'
	when c.Credit_Score>=600 AND c.Credit_Score <= 699 THEN 'Average'
	ELSE 'Poor'
END
ORDER BY CASE 
	WHEN c.Credit_Score>= 700 THEN 'Excellent'
	when c.Credit_Score>=600 AND c.Credit_Score <= 699 THEN 'Average'
	ELSE 'Poor'
END;

---Task-8 Write a Query to get the Clients with Highest Loan_Exposure---
SELECT TOP 100
Customer_ID,
SUM(Loan_Amount) AS Total_Loan
FROM Loan
GROUP BY Customer_ID
ORDER BY SUM(Loan_Amount) DESC;

---Task-9 Write an Query to get the Customer who have Multiple Loan TOP 100 ---
SELECT TOP 100
Customer_ID,
COUNT(Loan_ID) AS Total_Loan
FROM Loan 
GROUP BY Customer_ID
HAVING  COUNT(Loan_ID)>1
ORDER BY COUNT(Loan_ID) DESC;

---Task-10 Write an Query to get the how many Customers there are who have Multiple Loan ---
SELECT
COUNT(*) AS Customers_With_Multiple_Loan
FROM(
	SELECT
	Customer_ID
	FROM Loan
	GROUP BY Customer_ID
	HAVING Count(Loan_ID)>1
	) AS T

---Task-11 What is the default rate by loan type?
SELECT
lt.Loan_Type,
SUM(l.Default_Flag) as Total_Default_Loan,
COUNT(*) AS Total_Loan,
CAST(SUM(l.Default_Flag)*100.0/COUNT(*) AS DECIMAL(10,2)) AS Default_Rate
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type