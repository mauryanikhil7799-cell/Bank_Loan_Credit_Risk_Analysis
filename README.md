# Bank Loan Credit Risk Analysis | SQL Server

## Project Overview
This project analyzes a bank's loan portfolio using Microsoft SQL Server to understand loan distribution, customer credit profiles, loan performance, and default risk.

The objective is to transform structured financial data into meaningful insights that can support credit risk monitoring and lending decisions.

## Business Objectives
- Analyze total loan disbursement and loan portfolio distribution.
- Compare loan performance across loan types.
- Identify customers with multiple loans and default exposure.
- Evaluate credit score segments and customer risk profiles.
- Analyze payment patterns and validate payment records.

## Tools & Technologies
- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)
- Excel / CSV datasets

## Database Tables
- `Branches` — branch information
- `Customers` — customer details and credit scores
- `Loan_Type` — loan category information
- `Loan` — loan details, amounts, and default indicators
- `Payments` — payment transaction records

## SQL Concepts Demonstrated
- INNER JOIN and other joins
- GROUP BY and aggregate functions
- Subqueries and Common Table Expressions (CTEs)
- Window functions, including RANK()
- CASE expressions
- Date-based analysis
- Data validation and quality checks

## Key Analysis Areas
1. Loan Portfolio Analysis
2. Loan Type Risk Summary
3. Customer Credit Risk Analysis
4. High Loan Exposure Analysis
5. Payment Analysis and Validation

## Business Value
The analysis demonstrates how SQL can be used to summarize lending activity, investigate default exposure, identify portfolio patterns, and support data-driven risk monitoring.

## Repository Structure
- `scripts/` — SQL database setup, table creation, data loading, validation, and analysis scripts
- `Datasets/` — source datasets, where permitted

*Update this structure to match the actual files in your repository.*

## How to Run
1. Open the SQL scripts in SQL Server Management Studio.
2. Create or select the required database.
3. Execute the database and table creation scripts.
4. Load the datasets using the appropriate file paths.
5. Run the validation and analytical queries.

## Disclaimer
This is a portfolio project for learning and analytical demonstration. Findings depend on the supplied dataset and do not represent actual bank customer information or lending recommendations.
