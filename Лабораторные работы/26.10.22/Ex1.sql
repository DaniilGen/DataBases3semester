SELECT first_name, last_name, jobs.job_title FROM employees JOIN jobs ON jobs.job_id = employees.job_id
WHERE jobs.job_title='Programmer';