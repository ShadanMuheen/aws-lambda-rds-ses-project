SELECT
    p.pty_firstname,
    p.pty_lastname,
    p.pty_phone,
    a.add_city,
    s.stt_name
FROM opt_party p
JOIN opt_address a ON p.pty_id = a.add_partyid
JOIN sys_state s ON a.add_state = s.stt_id
ORDER BY p.pty_firstname;