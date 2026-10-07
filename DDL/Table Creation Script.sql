/*
Purpose
---To Create table for the dataset Bank_Loan_Credit_Risk_Analysis---

Warning
---This script will drop all the tables and create them again---
*/

--- Drop all tables ---
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Loan_Type;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Branches;
GO


--- Create Branches ---
CREATE TABLE Branches(
    Branch_ID VARCHAR(50) PRIMARY KEY,
    Branch_Name VARCHAR(50),
    State VARCHAR(50)
);


--- Create Customers ---
CREATE TABLE Customers(
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Age INT,
    State VARCHAR(50),
    Employment_Status VARCHAR(50),
    Education VARCHAR(50),
    Annual_Income DECIMAL(15,2),
    Credit_Score INT
);


--- Create Loan_Type ---
CREATE TABLE Loan_Type(
    Loan_Type_ID VARCHAR(50) PRIMARY KEY,
    Loan_Type VARCHAR(50),
    Security_Type VARCHAR(50),
    Base_Interest_Rate DECIMAL(5,2)
);


--- Create Loan ---
CREATE TABLE Loan(
    Loan_ID VARCHAR(50) PRIMARY KEY,
    Customer_ID VARCHAR(50),
    Branch_ID VARCHAR(50),
    Loan_Type_ID VARCHAR(50),
    Loan_Amount DECIMAL(15,2),
    Interest_Rate DECIMAL(5,2),
    Loan_Term_Months INT,
    Disbursement_Date DATE,
    DPD INT,
    Loan_Status VARCHAR(50),
    Default_Flag INT,

    FOREIGN KEY(Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY(Branch_ID) REFERENCES Branches(Branch_ID),
    FOREIGN KEY(Loan_Type_ID) REFERENCES Loan_Type(Loan_Type_ID)
);


--- Create Payments ---
CREATE TABLE Payments(
    Payment_ID VARCHAR(50) PRIMARY KEY,
    Loan_ID VARCHAR(50),
    Payment_Date DATE,
    Payment_Amount DECIMAL(15,2),
    Payment_Method VARCHAR(50),

    FOREIGN KEY(Loan_ID) REFERENCES Loan(Loan_ID)
);