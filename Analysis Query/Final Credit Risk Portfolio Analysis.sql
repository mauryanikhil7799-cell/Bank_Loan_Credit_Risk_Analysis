/*
Final Credit Risk Portfolio Analysis
Purpose
---	Create final customer and portfolio-level risk analysis and generate business insights for credit risk decision-making---

Task 1  → What are the overall portfolio KPIs?
Task 2  → What is the portfolio risk summary by credit range?
Task 3  → What is the loan type risk summary?
Task 4  → What is the employment status risk summary?
Task 5  → Who are the top 10 high-risk customers?
Task 6  → Which customers have the highest default exposure?
Task 7  → Create a final customer-level Credit Risk Dashboard Dataset.
*/
USE Bank_Loan_Credit_Risk_Analysis



---Task 1  → What are the overall portfolio KPIs?---
SELECT
COUNT(DISTINCT Customer_ID) AS Total_Customers,
COUNT(*) AS Total_Loans,
SUM(Loan_Amount) AS Total_Loan_Disburse,
CAST(SUM(Default_Flag)*100.0/COUNT(*) AS DECIMAL(10,2)) AS Defalut_Rate,
AVG(Loan_Amount) AS Average_Loan_Amount
FROM LOAN;

---Task 2 → What is the portfolio risk summary by credit range?---
SELECT
CASE
	WHEN c.Credit_Score>=700 THEN 'Excellent'
	WHEN c.Credit_Score>=600 THEN 'Average'
	ELSE 'Poor'
END AS Credit_Range,
COUNT(l.Loan_ID) AS Total_Loans,
SUM(l.Loan_Amount) AS Toatl_Loan_Disbursement,
CAST(SUM(Default_Flag)*100.0/COUNT(*) AS DECIMAL (10,2)) AS Default_Rate
FROM Customers AS c
JOIN Loan AS l
ON c.Customer_ID=l.Customer_ID
GROUP BY CASE
	WHEN c.Credit_Score>=700 THEN 'Excellent'
	WHEN c.Credit_Score>=600 THEN 'Average'
	ELSE 'Poor'
END 
ORDER BY CAST(SUM(Default_Flag)*100.0/COUNT(*) AS DECIMAL (10,2));


---Task 3  → What is the loan type risk summary?---
SELECT
lt.Loan_Type,
COUNT(l.Loan_ID) AS Total_Loans,
SUM(l.Loan_Amount) AS Toatl_Loan_Disbursement,
SUM(l.Default_Flag) AS Defaulted_Loans,
CAST(SUM(Default_Flag)*100.0/COUNT(*) AS DECIMAL (10,2)) AS Default_Rate
FROM Loan_Type AS lt
JOIN Loan AS l
ON l.Loan_Type_ID=lt.Loan_Type_ID
GROUP BY lt.Loan_Type
ORDER BY Default_Rate;

---Task 4  → What is the employment status risk summary?---
SELECT
c.Employment_Status,
COUNT(l.Loan_ID) AS Total_Loan,
SUM(l.Default_Flag) AS Default_Loan,
CAST(SUM(l.Default_Flag)*100.0/COUNT(l.Loan_ID) AS DECIMAL (10,2)) AS Default_Loan_Percentage,
AVG(c.Credit_Score) AS Avg_Credit_Score,
SUM( 
	CASE 
		WHEN l.Default_Flag=1 THEN l.Loan_Amount
		ELSE 0
	END)AS Default_Loan_Amount
FROM Customers AS c
JOIN Loan AS l
ON c.Customer_ID=l.Customer_ID
GROUP BY c.Employment_Status

---Task 5  → Who are the top 10 high-risk customers?---
SELECT TOP 10
c.Customer_ID,
c.Customer_Name,
C.Credit_Score,
SUM(l.Default_Flag) AS Default_Loan,
COUNT(l.Loan_ID) AS No_of_Loan,
CASE
	WHEN C.Credit_Score<=600 OR SUM(l.Default_Flag)>=1  THEN 'High_Risk' 
	ELSE 'No_Risk'
	END AS High_Risk_Customers
FROM Customers AS c
JOIN Loan AS l
ON c.Customer_ID=l.Customer_ID
GROUP BY c.Customer_ID,C.Credit_Score,c.Customer_Name
HAVING c.Credit_Score<600 OR SUM(l.Default_Flag)>=1
ORDER BY SUM(l.Default_Flag)DESC,c.Credit_Score ASC

---Task 6  → Which customers have the highest default exposure?---
SELECT TOP 10
c.Customer_ID,
c.Customer_Name,
SUM(Loan_Amount)AS Loan_Exposure,
SUM(CASE
		WHEN l.Default_Flag=1 THEN l.Loan_Amount
		ELSE 0
	END) AS Default_Loan
FROM Customers AS c
JOIN Loan AS l
ON c.Customer_ID=l.Customer_ID
GROUP BY c.Customer_ID,c.Customer_Name
HAVING SUM(
    CASE
        WHEN l.Default_Flag = 1 THEN l.Loan_Amount
        ELSE 0
    END
) > 0
ORDER BY Default_Loan DESC;

---Task 7  → Create a final customer-level Credit Risk Dashboard Dataset.---
DROP VIEW dbo.vw_Customer_Credit_Risk_Dashboard
SELECT *
FROM dbo.vw_Customer_Credit_Risk_Dashboard



