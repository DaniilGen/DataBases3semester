-- №1
CREATE TABLE people(
	id integer PRIMARY KEY,
	first_name varchar,
	last_name varchar,
	birthday date,
	amount numeric
);

CREATE TABLE people_log(
	person_id integer REFERENCES people (id),
	operation_date timestamp,
	sum numeric
);

INSERT INTO people VALUES
(1,'Владислав','Горин','19.10.2003',400),
(2,'Олег','Невздоров','13.02.2002',2333),
(3,'Юлия','Аркадьева','23.05.1995',2303),
(4,'Олеся','Мосина','28.08.1999',1202),
(5,'Петр','Рокин','10.04.2001',244);

INSERT INTO people_log VALUES
(3,'21.12.2022 16:39',2340),
(1,'18.04.2022 13:30',29220),
(2,'10.01.2021 19:00',25000),
(4,'17.10.2022 14:00',5000),
(4,'30.10.2022 14:00',5000),
(1,'02.04.2022 09:00',15000),
(5,'20.11.2022 13:00', -2000),
(2,'13.12.2022 11:00', -4200),
(1,'15.10.2022 12:00', -1000),
(3,'10.11.2022 10:00', -500);

-- №2
create or replace procedure statement_of_acount (begin_date date, end_date date) as $$
declare
	attr people_log%ROWTYPE;
	pos_sum CURSOR FOR SELECT * FROM people_log WHERE sum>=0 ORDER BY sum DESC LIMIT 3 ;
	neg_sum CURSOR FOR SELECT * FROM people_log WHERE sum<0 ORDER BY sum DESC LIMIT 3;
	all_op CURSOR FOR SELECT * FROM people_log;
	kol int;
	num numeric;
begin
	kol:=0;
	OPEN pos_sum;
	LOOP
	FETCH pos_sum INTO attr;
	IF NOT FOUND THEN EXIT;
	END IF;
	IF (begin_date, end_date) OVERLAPS (attr.operation_date, attr.operation_date) THEN
	kol:=kol+1;
	RAISE INFO 'Операция с положительной суммой : % %',
	attr.operation_date,
	attr.sum;
	END IF;
	END LOOP;
	CLOSE pos_sum;
	IF (kol=0) THEN RAISE INFO 'Операций с положительной суммой в данный промежуток нет';
	END IF;
	
	kol:=0;
	OPEN neg_sum;
	LOOP
	FETCH neg_sum INTO attr;
	IF NOT FOUND THEN EXIT;
	END IF;
	IF (begin_date, end_date) OVERLAPS (attr.operation_date, attr.operation_date) THEN
	kol:=kol+1;
	RAISE INFO 'Операция с отрицательной суммой : % %',
	attr.operation_date,
	attr.sum;
	END IF;
	END LOOP;
	CLOSE neg_sum;
	IF (kol=0) THEN RAISE INFO 'Операций с отрицательной суммой в данный промежуток нет';
	END IF;
	
	kol:=0;
	num:=0;
	OPEN all_op;
	LOOP
	FETCH all_op INTO attr;
	IF NOT FOUND THEN EXIT;
	END IF;
	IF (begin_date, end_date) OVERLAPS (attr.operation_date, attr.operation_date) THEN
	kol:=kol+1;
	num:=num+attr.sum;
	END IF;
	END LOOP;
	
	IF (kol>0) THEN
	RAISE INFO 'Общее число операций % и среднее значение суммы %',
	kol,
	trunc(num/kol,2);
	ELSE 
	RAISE INFO 'Операций в данный промежуток времени нет';
	END IF;
end 
$$ language plpgsql;

call statement_of_acount('01-01-2022','31-12-2022');

-- №3
CREATE OR REPLACE PROCEDURE account_operation(new_id integer, new_sum numeric) AS $$
BEGIN
  UPDATE people SET amount=amount+new_sum where people.id = new_id;
  INSERT INTO people_log VALUES (new_id, now(), new_sum);
END
$$ LANGUAGE plpgsql;

call account_operation(5, 1000);

select * from people;
