AWS Lambda – RDS – SES Email Automation Project

Project Overview
This project implements an end-to-end serverless data automation pipeline using AWS Lambda, Amazon RDS (PostgreSQL), Amazon SES, and API Gateway. The objective of the project is to automatically fetch relational data from a PostgreSQL database, convert it into a CSV report, and send it as an email attachment using Amazon SES.

The Lambda function is exposed via an API Gateway endpoint, making the solution fully serverless, scalable, and accessible through an HTTP invoke URL.

This project was developed as a team assignment and deployed successfully on AWS.

Problem Statement
Manually generating reports from a database and sending them via email is time-consuming and error-prone. The goal of this project is to automate the following process:

• Fetch data from multiple relational tables
• Generate a structured CSV report
• Send the report automatically via email
• Expose the workflow using a secure API endpoint

Architecture Overview
The system follows a serverless architecture:

Client sends a request to API Gateway
API Gateway triggers AWS Lambda
Lambda connects to Amazon RDS (PostgreSQL)
Lambda executes SQL joins and fetches data
Data is converted into CSV format
CSV is sent as an email attachment via Amazon SES

This design eliminates the need for servers and enables easy scalability.

Technologies Used

AWS Lambda (Python 3.9 runtime)
Amazon RDS – PostgreSQL
Amazon SES – Simple Email Service
Amazon API Gateway
IAM Roles and Policies
Python (boto3, psycopg2)
pgAdmin for database management
Git and GitHub for version control

Project Folder Structure

AWS-LAMBDA-RDS-SES-PROJECT
• lambda

lambda_function.py (main Lambda logic)

• sql

creation.sql (table creation scripts)

insertion.sql (sample data insertion)

select.sql (SQL query used for CSV report)

• results

Api_message.png (API Gateway success response)

Lambda_output.png (Lambda execution logs)

Mail.jpeg (email received with CSV attachment)

• README.md
• .gitignore

Database Design

The database consists of three tables:

SYS_STATE
Stores state master information such as state name and code.

OPT_PARTY
Stores party/customer details such as first name, last name, phone number, and identifier.

OPT_ADDRESS
Stores address details and links each party to a state using foreign keys.

A JOIN query across these tables is used to generate the final report containing:

• First Name
• Last Name
• Phone Number
• City
• State

Lambda Function Workflow

API Gateway triggers the Lambda function

Lambda reads database and SES configuration from environment variables

Lambda establishes a secure connection to PostgreSQL RDS

Executes the SQL JOIN query

Converts the result set into CSV format

Attaches the CSV to an email

Sends the email using Amazon SES

Returns a success response to API Gateway

Environment Variables Used

The following environment variables are configured in AWS Lambda:

DB_HOST
DB_NAME
DB_USER
DB_PASSWORD
DB_PORT
EMAIL_FROM
EMAIL_TO
SES_REGION

All sensitive information is stored securely as environment variables and not hardcoded.

Deployment Details

Lambda Runtime: Python
AWS Services: Lambda, RDS, SES, API Gateway
Email Service: SES (Sandbox mode with verified sender and receiver)

API Gateway Invoke URL:
https://cxesxuhwi4.execute-api.us-east-2.amazonaws.com/prod

Team Roles and Responsibilities

Although each team member implemented the project independently for learning purposes, the project was structured and presented as a 3-member team project with clearly defined roles.

Member 1 – AWS Infrastructure and IAM
Responsible for setting up IAM roles and permissions, configuring Amazon RDS, setting up SES email verification, and managing AWS regions and security configurations.

Member 2 – Database Design and SQL Logic
Responsible for designing the database schema, writing table creation scripts, inserting sample data, writing optimized SQL JOIN queries, and validating query output.

Member 3 – Lambda Development and API Integration
Responsible for developing the Lambda function in Python, integrating RDS and SES using boto3 and psycopg2, generating CSV output, attaching it to emails, and deploying the API Gateway endpoint.

All team members coordinated through shared schema definitions, consistent naming conventions, and regular testing to ensure the final output matched across implementations.

Results and Output

• API Gateway returns a successful HTTP response
• Lambda executes without errors
• Email is successfully sent with CSV attachment
• Email may appear in spam folder depending on mail client

Execution screenshots and output evidence are included in the results folder.

Future Enhancements

• Move SES from sandbox to production
• Store generated CSV files in Amazon S3
• Schedule automatic execution using EventBridge
• Add pagination for large datasets
• Use AWS Secrets Manager instead of environment variables
• Add CloudWatch alarms and structured logging

Conclusion

This project demonstrates practical hands-on experience with serverless architecture, secure database integration, automated reporting, and AWS service orchestration. It reflects real-world use cases and is fully deployable, extensible, and interview-ready.