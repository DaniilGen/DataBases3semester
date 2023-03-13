
-- №1
SELECT * from bd_employees where phone_number ~ '^\d+$' ;

-- №2
SELECT last_name||' '||first_name as ФИО,bd_departments.street  from bd_employees 
JOIN bd_departments ON bd_employees.department_id = bd_departments.id
where bd_departments.street ~* '[^a-z\s]' ;

-- №3
SELECT last_name, regexp_replace(phone_number,'^\+7','8') from bd_employees ;

-- №4
CREATE role polina;
GRANT ALL ON bd_departments to polina;
SET role polina;

CREATE role polina;
GRANT SELECT ON bd_employees to polina;
SET role polina;

CREATE role polina;
REVOKE UPDATE , DELETE ON bd_departments FROM polina;
SET role polina;

DROP OWNED BY polina;
DROP role polina;

-- №5
SELECT * from bd_employees where (REGEXP_COUNT(last_name, '[^eyuoai\W\d_]',1,'i')/
								  REGEXP_COUNT(last_name, '[eyuoai]',1,'i'))=2;

-- №6


SELECT last_name,phone_number, (REGEXP_COUNT(phone_number, '1',1)*1+
				   REGEXP_COUNT(phone_number, '2',1)*2+
				   REGEXP_COUNT(phone_number, '3',1)*3+
				   REGEXP_COUNT(phone_number, '4',1)*4+
				   REGEXP_COUNT(phone_number, '5',1)*5+
				   REGEXP_COUNT(phone_number, '6',1)*6+
				   REGEXP_COUNT(phone_number, '7',1)*7+
				   REGEXP_COUNT(phone_number, '8',1)*8+
				   REGEXP_COUNT(phone_number, '9',1)*9) 
from bd_employees;		

DROP VIEW dep_staff_counts;

-- №7
CREATE VIEW dep_staff_counts AS
	SELECT department d1, count(*)
	FROM staff GROUP BY d1;
	
SELECT * from dep_staff_counts;

-- SELECT * FROM staff;
SELECT * from bd_employees;

