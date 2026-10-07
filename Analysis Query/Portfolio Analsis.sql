/*  
Createing an Analysis Layer
Porpose
--- Answering Porfolio Answer----
*/

USE Bank_Loan_Credit_Risk_Analysis

---Task-1 Write a query to get the Total Number of Customers---
SELECT
COUNT(Customer_ID) AS Total_Customers
FROM Customers;
---Task-2 Write a query to get the Total Number of Loan---
SELECT
COUNT(Loan_ID) AS Total_Loan
FROM Loan;
---Task-3 Write a query to get the Total Loan_Amount---
SELECT
SUM(Loan_Amount) AS Total_Loan_Amount
FROM Loan;
---Task-4 Write a query to get the Avg Loan_Amount---
SELECT
SUM(Loan_Amount)/COUNT(Loan_id) AS Avg_Loan_amount
FROM Loan;
---Task-5 Write a query to get the Total Payment---
SELECT
COUNT(Payment_ID) AS Total_Payment
FROM Payments;
---Task-6 Write a query to get the Avg Payment_Amount---
SELECT
SUM(Payment_Amount)/COUNT(Payment_ID) AS Avg_Payment
FROM Payments;
---Task-7 Write a query to get the Avg Payment_Amount per customer---
SELECT
SUM(p.Payment_Amount)/COUNT(DISTINCT c.Customer_ID) Avg_Pay_Per_Customer
FROM Payments AS p
LEFT JOIN Loan AS l
ON p.Loan_ID=l.Loan_ID
LEFT JOIN Customers AS c
ON l.Customer_ID=c.Customer_ID;
---Task-8 Write a query to get the Avg Interest Rate---
SELECT
AVG(Base_Interest_Rate)AS Avg_Interest_Rate
FROM Loan_Type
---Task-9 Write a query to get the Avg Loan term---
SELECT
AVG	(Loan_term_Months) AS Avg_Loan_Term
FROM Loan