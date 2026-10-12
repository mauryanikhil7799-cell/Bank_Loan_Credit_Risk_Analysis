/*
Advanced Credit Risk Analysis

Purpose
---	Perform advanced credit risk analysis to identify
	high-risk customers, loan exposure, default patterns,
	and customer-level risk indicators using advanced SQL techniques---

Task 1  → Which customers have total loan exposure above the average customer exposure?
Task 2  → Which customers have a credit score below the overall average credit score?
Task 3  → Who are the top 10 customers by total loan exposure?
Task 4  → Which customers have multiple loans and at least one default?
Task 5  → Which customers have defaulted on multiple loans?
Task 6  → Which customers have a high credit score but have defaulted?
Task 7  → What is the default rate by income range?
Task 8  → What is the default rate by loan amount range?
Task 9  → What is the average loan amount by loan type?
Task 10  → Which loan type has the highest default rate?
Task 11  → Which credit-score range has the highest default rate?
Task 12  → Which employment status has the highest default rate?
Task 13  → Which customers have high loan exposure and poor credit scores?
Task 14  → Which customers have high income but have defaulted?
*/

USE Bank_Loan_Credit_Risk_Analysis
--Task-1 Write a query to find the Total Loan Exposure above the average Customer exposure---

WITH Customer_Exposure AS
(
	SELECT
	Customer_ID,
	SUM(Loan_Amount) AS Loan_Exposure
	FROM Loan
	GROUP BY Customer_ID
)
SELECT*
FROM Customer_Exposure
WHERE Loan_Exposure>
					(SELECT AVG( Loan_Exposure)
					FROM Customer_Exposure);

---Task-2 Write a query to find out the customer who has lower credit score from overall avg credit score---
SELECT
Customer_ID,
Credit_Score,
ROUND(AVG(Credit_Score)OVER(),2) AS Avg_Credit_Score
FROM Customers
WHERE Credit_Score<(SELECT AVG(Credit_Score)FROM Customers)

---Task-3 Write an query to find top 10 customer with highest loan exposure---
SELECT TOP 10
Customer_ID AS highest_loan_exposure_Customer,
SUM(Loan_Amount) AS Highest_Loan_Amount
FROM Loan
GROUP BY Customer_ID
ORDER BY SUM(Loan_Amount) DESC

---Task-4 Write an query to find the customer who have multiple Loan And atleast one loan is default---
SELECT
Customer_ID,
COUNT(Loan_id) AS Total_Loan
FROM Loan
GROUP BY Customer_ID
HAVING COUNT(Loan_id)>1 AND SUM(Default_Flag)>=1;

---Task-5 Write a query to find the customer who have default multiple Loan---
SELECT
Customer_ID,
SUM(Default_Flag) AS Default_Loan
FROM Loan
GROUP BY Customer_ID

--- Task-6 Write a Query to find out the Customer with high Credit score but the defaulted(High Credit Score=700++---

SELECT
c.Customer_ID,
c.Customer_Name,
c.Credit_Score,
l.Default_Flag
FROM Loan AS l
Join Customers AS c
ON c.Customer_ID=l.Customer_ID
WHERE c.Credit_Score>=700 AND l.Default_Flag=1

---Task 7 Write a query to find out default rate bassed on the Income range---
SELECT
CASE
WHEN c.Annual_Income >=500000 THEN 'High_Income_Individual'
	WHEN c.Annual_Income >200000 THEN 'Avg_Income_Individual'
	ELSE 'Low_Income_Individual' 
	END
	AS Income_Range,
CAST(SUM(l.Default_Flag)*100.0/COUNT(*)AS DECIMAL(10,2)) AS Default_Rate
FROM Loan AS l
JOIN Customers AS c
ON l.Customer_ID=c.Customer_ID
GROUP BY CASE
WHEN c.Annual_Income >=500000 THEN 'High_Income_Individual'
	WHEN c.Annual_Income >200000 THEN 'Avg_Income_Individual'
	ELSE 'Low_Income_Individual' 
	END;

	---Task 8 Write a query to find out default rate bassed on the Loan range---
DROP VIEW IF EXISTS vm_Loan_Range;
GO
	CREATE VIEW vm_Loan_Range AS
	SELECT *,
	CASE
		WHEN Loan_Amount>=500000 THEN 'High Ticket Loans'
		WHEN Loan_Amount<=300000 THEN 'Meduim Ticket Loans'
		ELSE 'Small Ticket Loans'
	END AS Loan_Range
	FROM Loan ;
---Just For Fun----
SELECT
Loan_Range,
CAST(SUM(Default_Flag)*100.0/COUNT(*)AS DECIMAL(10,2)) AS Defaut_Rate
FROM vm_Loan_Range
GROUP BY Loan_Range

---Task-9 What is the Avg Loan Amount by loan type---
SELECT
lt.Loan_Type,
AVG(l.Loan_Amount) AS Avg_Loan
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type;

---Task-10 Which loan_type has the highest loan default rate---
SELECT 
lt.Loan_Type,
CAST(SUM(l.Default_Flag)*100.0/COUNT(*) AS DECIMAL(10,2)) AS Default_Rate
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type
ORDER BY CAST(SUM(l.Default_Flag)*100.0/COUNT(*) AS DECIMAL(10,2)) DESC

----FOR HIGEST BEFORE SELECT WRITE TOP 1---

---Task-11 Write a query to get the credit range who has the higest default rate using view---
DROP VIEW IF EXISTS vm_Credit_Range;
GO
CREATE VIEW vm_Credit_Range AS 
SELECT*,
CASE
	WHEN Credit_Score>=700 THEN 'High_Range'
	WHEN Credit_Score>=600 THEN 'Avg_Range'
	ELSE 'Low_Rage'
END AS Credit_Range
FROM Customers;

SELECT
c.Credit_Range,
CAST(SUM(l.Default_Flag)*100.0/COUNT(*) AS DECIMAL (10,2)) AS Default_Rate
FROM Loan AS l
JOIN vm_Credit_Range AS c
ON l.Customer_ID=c.Customer_ID
GROUP BY c.Credit_Range
ORDER BY CAST(SUM(l.Default_Flag)*100.0/COUNT(*) AS DECIMAL (10,2))  DESC

---Task 12  → Which employment status has the highest default rate?----
SELECT
c.Employment_Status,
CAST(SUM(l.Default_Flag)*100.0/COUNT(*) AS DECIMAL(10,2)) AS Default_Rate
FROM Loan AS l
JOIN Customers AS c
ON c.Customer_ID=l.Customer_ID
GROUP BY c.Employment_Status
ORDER BY CAST(SUM(l.Default_Flag)*100.0/COUNT(*) AS DECIMAL(10,2)) DESC

---Task 13  → Which customers have high loan exposure and poor credit scores?---
SELECT
c.Customer_Name,
c.Customer_ID,
c.Credit_Score,
SUM(l.Loan_Amount) AS Loan_Exposure
FROM Loan AS l
JOIN Customers AS c
ON c.Customer_ID=l.Customer_ID
WHERE c.Credit_Score<=600
GROUP BY c.Customer_Name,c.Customer_ID,c.Credit_Score
ORDER BY SUM(l.Loan_Amount) DESC


---Task 14  → Which customers have high income but have defaulted? (HighIncome 500000 and Above in this case)---
SELECT
l.Customer_ID,
c.Customer_Name,
c.Annual_Income,
l.Default_Flag
FROM Loan AS l
JOIN Customers AS c
ON c.Customer_ID=l.Customer_ID
WHERE l.Default_Flag=1 AND c.Annual_Income>=500000