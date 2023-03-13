SELECT first_name Имя, last_name Фамилия, salary Оклад, trunc(jobs.min_salary,0)
FROM employees JOIN jobs ON jobs.job_id = employees.job_id
WHERE salary<=1.2*trunc(jobs.min_salary,0);
