/*
Customer Risk Segmentation
Purpose
---	Segment customers into Low, Medium, and High Risk
	based on credit score, loan exposure, loan count,
	and default behaviour---

Task 1  → Rank customers by total loan exposure.
Task 2  → Rank loan types by default rate.
Task 3  → What percentage of the total loan portfolio does each loan type represent?
Task 4  → What is the cumulative loan exposure by disbursement date?
Task 5  → What is the customer-level loan and default summary?
Task 6  → Identify high-risk customers based on multiple risk indicators.
Task 7  → Calculate a customer-level risk score.
Task 8  → Categorize customers into Low, Medium, and High Risk.
*/
USE Bank_Loan_Credit_Risk_Analysis;
GO
--- Task-1 Write a Query to Rank Customer by Loan Exposure---

SELECT
RANK()OVER(ORDER BY (SUM(Loan_Amount)) DESC) AS Cusomer_rank,
Customer_ID,
SUM(Loan_Amount)AS Loan_Exposure
FROM LOAN
GROUP BY Customer_ID

---Task-2 Write a query to rank loan types by default rate---
SELECT
lt.Loan_Type,
RANK() OVER (ORDER BY SUM(l.Default_Flag)*100.0/COUNT(*)  DESC) AS Loan_Type_Rank
FROM Loan AS l
JOIN Loan_Type AS lt
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type

---Task-3 write a query to get the cumulative loan exposure by disbursment date---
SELECT
Disbursement_Date,
SUM(Loan_Amount) AS Loan_Exposure,
SUM(SUM(Loan_Amount))OVER(ORDER BY Disbursement_Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_Loan_Exposure
FROM LOAN
GROUP BY Disbursement_Date

--- Task-4 What is the customer-level loan and default summary?---
SELECT
Customer_ID,
COUNT(Loan_ID) Total_Loans,
SUM(Loan_Amount) AS Total_Loan_Exposure,
SUM(Default_Flag) AS Default_Summary
FROM Loan
GROUP BY Customer_ID
HAVING SUM(Default_Flag)>=1
ORDER BY Customer_ID

---Task 6  → Identify high-risk customers based on multiple risk indicators.---	
SELECT
c.Customer_ID,
c.Credit_Score,
c.Annual_Income,
COUNT(l.Loan_ID) AS Total_Loan,
SUM(l.Loan_Amount) AS Total_Loan_Exposure,
SUM(l.Default_Flag) AS Default_Rate,
CASE 
	WHEN c.Credit_Score >=600  AND SUM(l.Default_Flag)>=1 THEN 'Low_Risk'
	WHEN c.Credit_Score >=600  AND SUM(l.Default_Flag)>=1 THEN 'Medium_Risk'
	ELSE 'Low_Risk'
END AS Risk_Range
FROM Customers AS c
JOIN Loan AS l
ON c.Customer_ID=l.Customer_ID
GROUP BY c.Customer_ID,c.Credit_Score,c.Annual_Income
ORDER BY CASE 
	WHEN c.Credit_Score >=600  AND SUM(l.Default_Flag)>=1 THEN 'Low_Risk'
	WHEN c.Credit_Score >=600  OR SUM(l.Default_Flag)>=1 THEN 'Medium_Risk'
	ELSE 'Low_Risk'
END;

---Task 7  → Calculate a customer-level risk score.---
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Credit_Score,
    c.Annual_Income,
    COUNT(l.Loan_ID) AS Total_Loans,
    SUM(l.Default_Flag) AS Defaulted_Loans,
    CASE
        WHEN c.Credit_Score < 600 THEN 3
        WHEN c.Credit_Score < 700 THEN 2
        ELSE 0
    END
    + CASE
        WHEN SUM(l.Default_Flag) >= 1 THEN 3
        ELSE 0
    END
    + CASE
        WHEN COUNT(l.Loan_ID) > 2 THEN 1
        ELSE 0
    END
    + CASE
        WHEN c.Annual_Income < 20000 THEN 1
        ELSE 0
    END AS Risk_Score
FROM Customers AS c
JOIN Loan AS l
    ON c.Customer_ID = l.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.Credit_Score,
    c.Annual_Income
ORDER BY Risk_Score DESC;

---Task 8  → Categorize customers into Low, Medium, and High Risk.---
SELECT
c.Customer_ID,
c.Customer_Name,
c.Credit_Score,
SUM(Default_Flag) AS Default_Loan,
CASE 
    WHEN Credit_Score<600 AND SUM(Default_Flag)>=1 THEN 'High_Risk'
    WHEN Credit_Score<600 or SUM(Default_Flag)>=1 THEN 'Meduim_Risk'
    ELSE 'Low_Risk'
END AS Customer_Category
FROM Customers AS c
JOIN Loan AS l
ON c.Customer_ID=l.Customer_ID
GROUP BY c.Customer_ID,c.Customer_Name,c.Credit_Score

