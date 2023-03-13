SELECT job_id as Должность, trunc(max(salary)) as "Максимальная зарплата", trunc(min(salary)) as "Минимальная зарплата",
trunc(avg(salary),2) as "Средняя зарплата" FROM employees GROUP BY job_id;