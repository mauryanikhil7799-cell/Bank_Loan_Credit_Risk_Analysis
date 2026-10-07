/*
Purpose 
--- This Script help to Insert Bulk data in the tbale we have created in thelast query---

Warning
--- This Script will Truclate the able and insert the data for the source if the data changes in the source it will effect the whole system---
*/

---Inserting data into Branches---
DELETE FROM Branches; 
BULK INSERT Branches
FROM 'C:\Users\Asus\Desktop\SQL Projects\Date 03 Oct 2026\Bank_Loan_Credit_Risk_Analysis\Branches.csv'
WITH(
	FORMAT ='CSV',
	FIRSTROW=2,
	FIELDQUOTE='"',
	TABLOCK
);

GO

---Inserting data into Customers---
DELETE FROM Customers;
BULK INSERT Customers
FROM 'C:\Users\Asus\Desktop\SQL Projects\Date 03 Oct 2026\Bank_Loan_Credit_Risk_Analysis\Customers.csv'
WITH(
	FORMAT ='CSV',
	FIRSTROW=2,
	FIELDQUOTE='"',
	TABLOCK
);

GO

---Inserting data into Loan_Type---
DELETE FROM Loan_Type; 
BULK INSERT Loan_Type
FROM 'C:\Users\Asus\Desktop\SQL Projects\Date 03 Oct 2026\Bank_Loan_Credit_Risk_Analysis\Loan_Types.csv'
WITH(
	FORMAT ='CSV',
	FIRSTROW=2,
	FIELDQUOTE='"',
	TABLOCK
);

GO

---Inserting data into Loan---
DELETE FROM Loan; 
BULK INSERT Loan
FROM 'C:\Users\Asus\Desktop\SQL Projects\Date 03 Oct 2026\Bank_Loan_Credit_Risk_Analysis\Loans.csv'
WITH(
	FORMAT ='CSV',
	FIRSTROW=2,
	FIELDQUOTE='"',
	TABLOCK
);

GO

---Inserting data into Payments---
DELETE FROM Payments; 
BULK INSERT Payments
FROM 'C:\Users\Asus\Desktop\SQL Projects\Date 03 Oct 2026\Bank_Loan_Credit_Risk_Analysis\Payments.csv'
WITH(
	FORMAT ='CSV',
	FIRSTROW=2,
	FIELDQUOTE='"',
	TABLOCK
);

GO