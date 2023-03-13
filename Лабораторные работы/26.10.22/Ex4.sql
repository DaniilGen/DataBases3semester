SET DateStyle TO German;
SELECT emp1.last_name Фамилия_Р, date(emp1.hire_date) Дата_Р, emp2.last_name Фамилия_M, date(emp2.hire_date) Дата_M
FROM employees as emp1 
JOIN employees as emp2 ON emp1.manager_id = emp2.employee_id
WHERE emp1.hire_date<emp2.hire_date;