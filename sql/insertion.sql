INSERT INTO sys_state VALUES
(gen_random_uuid(), 'California', 'CA'),
(gen_random_uuid(), 'New York', 'NY'),
(gen_random_uuid(), 'Texas', 'TX'),
(gen_random_uuid(), 'Florida', 'FL'),
(gen_random_uuid(), 'Illinois', 'IL');


INSERT INTO opt_address (
    add_id,
    add_line1,
    add_city,
    add_state,
    add_zip,
    add_partyid
) VALUES
(gen_random_uuid(),'101 Main St','Los Angeles',
 (SELECT stt_id FROM sys_state WHERE stt_code='CA'),
 '90001',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Alice')
),
(gen_random_uuid(),'202 Park Ave','New York',
 (SELECT stt_id FROM sys_state WHERE stt_code='NY'),
 '10001',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Bob')
),
(gen_random_uuid(),'303 Elm St','Dallas',
 (SELECT stt_id FROM sys_state WHERE stt_code='TX'),
 '75001',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Charlie')
),
(gen_random_uuid(),'404 Palm Rd','Miami',
 (SELECT stt_id FROM sys_state WHERE stt_code='FL'),
 '33101',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Deepa')
),
(gen_random_uuid(),'505 Lake Shore','Chicago',
 (SELECT stt_id FROM sys_state WHERE stt_code='IL'),
 '60601',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Ethan')
),
(gen_random_uuid(),'606 Sunset Blvd','San Diego',
 (SELECT stt_id FROM sys_state WHERE stt_code='CA'),
 '92101',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Farah')
),
(gen_random_uuid(),'707 Broadway','New York',
 (SELECT stt_id FROM sys_state WHERE stt_code='NY'),
 '10002',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='George')
),
(gen_random_uuid(),'808 Ring Rd','Houston',
 (SELECT stt_id FROM sys_state WHERE stt_code='TX'),
 '77002',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Hema')
),
(gen_random_uuid(),'909 Ocean Dr','Miami',
 (SELECT stt_id FROM sys_state WHERE stt_code='FL'),
 '33139',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Ivan')
),
(gen_random_uuid(),'111 River Rd','Springfield',
 (SELECT stt_id FROM sys_state WHERE stt_code='IL'),
 '62701',
 (SELECT pty_id FROM opt_party WHERE pty_firstname='Julia')
);
