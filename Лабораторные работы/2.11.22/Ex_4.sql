INSERT INTO staff(id,name,department)
SELECT nextval('staff_id_seq'), substr(employees.first_name,1,1) || substr(employees.last_name,1,1), 
departments.department_name FROM employees JOIN departments 
ON departments.department_id = employees.department_id
RETURNING *;
