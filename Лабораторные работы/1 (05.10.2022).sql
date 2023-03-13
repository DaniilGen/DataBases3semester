CREATE TABLE countries(
id NUMERIC(3) PRIMARY KEY,
name VARCHAR(64) NOT NULL
);
CREATE TABLE shedule(
id INTEGER PRIMARY KEY,
time_arrival TIMESTAMP without time zone NOT NULL,
time_departure TIMESTAMP without time zone NOT NULL,
arrival VARCHAR(2000) NOT NULL ,
departure VARCHAR(2000) NOT NULL DEFAULT 'Москва',
type VARCHAR(9) NOT NULL,
CHECK (type IN ('Скорый','Фирменный','Обычный')),
stop_number INTEGER NOT NULL,
CHECK (stop_number>0),
id_country NUMERIC(3)  REFERENCES countries(id) NOT NULL
);