/*
---Craeting  database named Bank_Loan_Credit_Risk_Analysis---

Script purpose
--- This script will create a new database named Bank_Loan_Credit_Risk_Analysis---
--- And if the database already exsits it will drop and create a new one---

Warning 
--- Do not run this script if the database already exsits---
---	it will drop all the data permanently---
*/

--- Use master database---

USE master;
GO

--- Drop the dataset and create a newone(If one exsits)---

---Query to drop the database---

IF DB_ID ('Bank_Loan_Credit_Risk_Analysis') IS NOT NULL
	BEGIN
		ALTER DATABASE Bank_Loan_Credit_Risk_Analysis
		SET SINGLE_USER
		WITH ROLLBACK IMMEDIATE;
		DROP DATABASE Bank_Loan_Credit_Risk_Analysis
	END;
GO

---Query to create the database---

CREATE DATABASE Bank_Loan_Credit_Risk_Analysis;

GO

---USE DATABASE Bank_Loan_Credit_Risk_Analysis---

USE Bank_Loan_Credit_Risk_Analysis
