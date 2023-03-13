CREATE SEQUENCE staff_id_seq 
	start with 12
	cycle
	INCREMENT BY -8
	MAXVALUE 12
	CACHE 100;
	
INSERT INTO staff(id,name,department)
VAlUES(nextval('staff_id_seq'),'Ivan Makarenko','Director')
RETURNING *;

INSERT INTO staff(id,name,department)
SELECT nextval('staff_id_seq'), substr(employees.first_name,1,1) || substr(employees.last_name,1,1), 
departments.department_name FROM employees JOIN departments 
ON departments.department_id = employees.department_id
RETURNING *;

SELECT * From staff;

UPDATE staff set department = 'Innovations department' 
WHERE id in (12,4)
	returning *;
	
DELETE from staff WHERE name='KK'
	returning *;
	
-- with recursive remployees(employee_id, manager_id, job_title) as
--   (select employee_id, manager_id, (SELECT job_title from jobs 
-- 							WHERE employees.job_id=jobs.job_id AND employees.employee_id = 205 ) 
--      from employees where employee_id = 205
--    union all
--    select employees.employee_id, employees.manager_id , (SELECT job_title from jobs 
-- 		WHERE employees.job_id=jobs.job_id AND remployees.employee_id = employees.manager_id )
--      from employees join remployees on remployees.employee_id = employees.manager_id)
-- select job_title from remployees;
with recursive remployees(employee_id, manager_id, region_name) as
  (select employee_id, manager_id, (SELECT region_name from regions where region_id=
									(SELECT region_id from countries where country_id=
									(SELECT country_id from locations WHERE location_id=
									  (SELECT location_id from departments WHERE
									  departments.department_id=employees.department_id) ) )) 
     from employees where employee_id = 205
   union all
   select employees.employee_id, employees.manager_id , 
   (SELECT region_name from regions where region_id=
									(SELECT region_id from countries where country_id=
									(SELECT country_id from locations WHERE location_id=
									  (SELECT location_id from departments WHERE
									  departments.department_id=employees.department_id) ) ))
     from employees join remployees on remployees.employee_id = employees.manager_id)
select * from remployees;

select * from staff;

UPDATE staff set department = substr(department,1,2)
