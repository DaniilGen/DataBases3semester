SELECT first_name Имя, last_name Фамилия, job_id Должность, trunc(salary,0) Оклад 
FROM employees 
WHERE salary = (SELECT max_salary FROM jobs WHERE jobs.job_id = employees.job_id);