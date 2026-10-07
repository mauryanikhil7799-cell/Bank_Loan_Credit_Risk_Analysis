/* 
Purpose
--- This Query will help us to check all the data we insert is imported correctly----
*/

USE Bank_Loan_Credit_Risk_Analysis;
GO
---Task-1 Did all records get imported?---
SELECT 'Branches' AS Table_Name,
COUNT(*) AS Row_Count FROM Branches
UNION ALL
SELECT 'Customers',
COUNT(*) FROM Customers
UNION ALL
SELECT 'Loan',
COUNT(*) FROM Loan
UNION ALL
SELECT 'Loan_Type',
COUNT(*) FROM Loan_Type
UNION ALL
SELECT 'Payments',
COUNT(*) FROM Payments;

---Task-2 Does every Primary Key ID uniquely identify one record?---
SELECT
Loan_ID,
COUNT(*) AS Duplicate_Count
FROM Loan
GROUP BY Loan_ID
HAVING COUNT(*)>1;

SELECT
Customer_ID,
COUNT(*) AS Duplicate_Count
FROM Customers
GROUP BY Customer_ID
HAVING COUNT(*)>1

SELECT
Branch_ID,
COUNT(*) AS Duplicate_Count
FROM Branches
GROUP BY Branch_ID
HAVING COUNT(*)>1

SELECT
Loan_Type_ID,
COUNT(*) AS Duplicate_Count
FROM Loan_Type
GROUP BY Loan_Type_ID
HAVING COUNT(*)>1

SELECT
Payment_ID,
COUNT(*) AS Duplicate_Count
FROM Payments
GROUP BY Payment_ID
HAVING COUNT(*)>1

---Task-3 Write a query to check Null Values in the imported data---
SELECT*
FROM Branches
WHERE Branch_ID IS NULL
	  OR Branch_Name IS NULL
	  OR State IS NULL

SELECT*
FROM Customers
WHERE Customer_ID IS NULL
	OR Customer_Name IS NULL 
	OR Age IS NULL
	OR State IS NULL
	OR Employment_Status IS NULL
	OR Education IS NULL
	OR Annual_Income IS NULL
	OR Credit_Score IS NULL

SELECT*
FROM Loan_Type
WHERE Loan_Type_ID IS NULL
	  OR Loan_Type IS NULL
	  OR Security_Type IS NULL
	  OR Base_Interest_Rate IS NULL

SELECT*
FROM Loan
WHERE Loan_ID IS NULL
OR Customer_ID  IS NULL
OR Branch_ID IS NULL
OR Loan_Type_ID IS NULL
OR Loan_Amount IS NULL
OR Interest_Rate IS NULL
OR Loan_Term_Months IS NULL
OR Disbursement_Date IS NULL
OR DPD	 IS NULL
OR Loan_Status IS NULL
OR Default_Flag IS NULL


SELECT*
FROM Payments
WHERE Payment_ID IS NULL
OR	Loan_ID IS NULL
OR	Payment_Date IS NULL
OR	Payment_Amount IS NULL
OR	Payment_Method IS NULL

---Task-4 Check for Invalid Values
SELECT*
FROM Branches
--- Comment All value seems Good---
Select*
FROM Customers
WHERE Age<18
	OR Age>100
	OR Annual_Income<0
	OR Credit_Score<300
	OR Credit_Score>900
--- Comment All value seems Good---
SELECT*
FROM Loan
WHERE Interest_Rate<1
	OR Loan_Amount<0
	OR Loan_Term_Months<0
	OR DPD<0
--- Comment All value seems Good---
SELECT*
FROM Loan
WHERE Disbursement_Date>GETDATE()
--- Comment All value seems Good---

SELECT*
FROM Loan_Type
--- Comment All value seems Good---
SELECT* 
FROM Payments
--- Comment All value seems Good---
	

---Task-5 Does every loan has a valid customer
SELECT*
FROM Loan AS l
LEFT JOIN Customers AS C
ON L.Customer_ID=C.Customer_ID
WHERE C.Customer_ID IS NULL

---Task-6 Write an query to check is there any Payment before loan disbursement---
SELECT
	P.Payment_ID,
	p.Loan_ID,
	l.Disbursement_Date,
	p.Payment_Date,
	p.Payment_Amount
FROM Payments AS p
JOIN Loan AS l
ON p.Loan_ID =l.Loan_ID
WHERE p.Payment_Date<l.Disbursement_Date
