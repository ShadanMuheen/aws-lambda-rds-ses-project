import os
import psycopg2
import csv
import io
import boto3
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

def lambda_handler(event, context):
    # ---------- Environment Variables ----------
    DB_HOST = os.environ['DB_HOST']
    DB_NAME = os.environ['DB_NAME']
    DB_USER = os.environ['DB_USER']
    DB_PASSWORD = os.environ['DB_PASSWORD']
    DB_PORT = os.environ.get('DB_PORT', '5432')

    EMAIL_FROM = os.environ['EMAIL_FROM'].strip()
    EMAIL_TO = os.environ['EMAIL_TO'].strip()
    SES_REGION = os.environ['SES_REGION']

    # ---------- Connect to PostgreSQL ----------
    conn = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        port=DB_PORT
    )

    cursor = conn.cursor()

    query = """
        SELECT 
            p.pty_firstname,
            p.pty_lastname,
            a.add_line1,
            a.add_city,
            s.stt_name,
            a.add_zip
        FROM opt_party p
        JOIN opt_address a ON p.pty_id = a.add_partyid
        JOIN sys_state s ON a.add_state = s.stt_id
        ORDER BY p.pty_firstname;
    """

    cursor.execute(query)
    rows = cursor.fetchall()

    cursor.close()
    conn.close()

    # ---------- Create CSV in Memory ----------
    csv_buffer = io.StringIO()
    writer = csv.writer(csv_buffer)

    writer.writerow([
        "FirstName",
        "LastName",
        "Address",
        "City",
        "State",
        "ZipCode"
    ])

    for row in rows:
        writer.writerow(row)

    csv_content = csv_buffer.getvalue()
    csv_buffer.close()

    # ---------- Build Email with Attachment ----------
    msg = MIMEMultipart()
    msg['Subject'] = "Party Address Details (CSV Attachment)"
    msg['From'] = EMAIL_FROM
    msg['To'] = EMAIL_TO

    body = MIMEText(
        "Please find attached the party address details in CSV format.",
        'plain'
    )
    msg.attach(body)

    attachment = MIMEApplication(csv_content)
    attachment.add_header(
        'Content-Disposition',
        'attachment',
        filename='party_address_details.csv'
    )
    msg.attach(attachment)

    # ---------- Send Email ----------
    ses = boto3.client('ses', region_name=SES_REGION)

    ses.send_raw_email(
        Source=EMAIL_FROM,
        Destinations=[EMAIL_TO],
        RawMessage={'Data': msg.as_string()}
    )

    return {
        'statusCode': 200,
        'body': 'CSV attachment email sent successfully'
    }
