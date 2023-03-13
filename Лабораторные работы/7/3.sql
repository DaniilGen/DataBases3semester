CREATE OR REPLACE PROCEDURE account_operation(new_id integer, new_sum numeric) AS $$
BEGIN
  UPDATE people SET amount=amount+new_sum where people.id = new_id;
  INSERT INTO people_log VALUES (new_id, now(), new_sum);
END
$$ LANGUAGE plpgsql;

call account_operation(5, 1000);

select * from people;