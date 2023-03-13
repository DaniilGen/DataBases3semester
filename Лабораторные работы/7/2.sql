create or replace procedure statement_of_acount (begin_date date, end_date date) as $$
declare
	attr people_log%ROWTYPE;
	pos_sum CURSOR FOR SELECT * FROM people_log WHERE sum>=0 ORDER BY sum DESC LIMIT 3 ;
	neg_sum CURSOR FOR SELECT * FROM people_log WHERE sum<0 ORDER BY sum LIMIT 3;
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