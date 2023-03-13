SELECT first_name, last_name, departments.department_name, countries.country_name FROM employees 
JOIN departments ON departments.department_id = employees.department_id
JOIN locations ON locations.location_id = departments.location_id
JOIN countries ON countries.country_id = locations.country_id
WHERE countries.country_name='United States of America' AND departments.department_name IN ('Shipping','Finance');
