DROP TABLE assignment;
DROP TABLE animal;
DROP TABLE staff;
DROP TABLE enclosure;

CREATE TABLE enclosure(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closedForMaintenance boolean
);

CREATE TABLE animal(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INT REFERENCES enclosure(id)
);

CREATE TABLE staff(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employeeNumber INT
);

CREATE TABLE assignment(
    id SERIAL PRIMARY KEY,
    employeeId INT REFERENCES staff(id),
    enclosureId INT REFERENCES enclosure(id),
    day VARCHAR(255)
);

INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('Bird enclosure', 25, FALSE);
INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('Big cat enclosure', 10, TRUE);
INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('Dog enclosure', 15, FALSE);
INSERT INTO enclosure (name, capacity, closedForMaintenance) VALUES ('Fish enclosure', 40, TRUE);

INSERT INTO animal (name, type, age, enclosure_id) VALUES ('Birdy', 'Seagull', 2, 1);
INSERT INTO animal (name, type, age, enclosure_id) VALUES ('Birdie', 'Pidgeon', 5, 1);
INSERT INTO animal (name, type, age, enclosure_id) VALUES ('Tony', 'Tiger', 20, 2);
INSERT INTO animal (name, type, age, enclosure_id) VALUES ('Mike', 'Lion', 7, 2);
INSERT INTO animal (name, type, age, enclosure_id) VALUES ('Goldie', 'Golden Retreiver', 3, 3);
INSERT INTO animal (name, type, age, enclosure_id) VALUES ('John', 'Poodle', 1, 3);
INSERT INTO animal (name, type, age, enclosure_id) VALUES ('Jaws', 'Shark', 4, 4);
INSERT INTO animal (name, type, age, enclosure_id) VALUES ('Mega', 'Whale', 20, 4);

INSERT INTO staff (name, employeeNumber) VALUES ('Michael', 12345);
INSERT INTO staff (name, employeeNumber) VALUES ('Andy', 54321);
INSERT INTO staff (name, employeeNumber) VALUES ('Jess', 123);
INSERT INTO staff (name, employeeNumber) VALUES ('Penelope', 321);

INSERT INTO assignment (employeeId, enclosureId, day) VALUES (1, 1, 'Monday');
INSERT INTO assignment (employeeId, enclosureId, day) VALUES (2, 4, 'Tuesday');
INSERT INTO assignment (employeeId, enclosureId, day) VALUES (3, 2, 'Friday');
INSERT INTO assignment (employeeId, enclosureId, day) VALUES (4, 3, 'Thursday');


-- MVP 1
SELECT animal.name, enclosure.name FROM animal
INNER JOIN enclosure
ON animal.enclosure_id = enclosure.id
WHERE enclosure.id = 1;



-- MVP 2
SELECT staff.name, enclosure.name, assignment.day FROM staff
INNER JOIN assignment
ON staff.id = assignment.employeeId
INNER JOIN enclosure 
ON enclosure.id = assignment.enclosureId
WHERE enclosure.id = 3;


-- EXTENSION 1 
SELECT staff.name, enclosure.name, assignment.day, enclosure.closedForMaintenance FROM staff
INNER JOIN assignment
ON staff.id = assignment.employeeId
INNER JOIN enclosure 
ON enclosure.id = assignment.enclosureId
WHERE enclosure.closedForMaintenance = true;


-- EXTENSION 2
SELECT animal.name, animal.type, animal.age, enclosure.name FROM animal
INNER JOIN enclosure 
ON animal.enclosure_id = enclosure.id
ORDER BY animal.age DESC, animal.name;


-- EXTENSION 3 
SELECT COUNT(DISTINCT animal.type), assignment.enclosureId, assignment.employeeId FROM animal
INNER JOIN enclosure
ON animal.enclosure_id = enclosure.id
INNER JOIN assignment
ON assignment.enclosureId = enclosure.id
INNER JOIN staff
ON staff.id = assignment.employeeId
WHERE assignment.employeeId = 4
GROUP BY assignment.enclosureId, assignment.employeeId;


-- EXTENSION 4
SELECT COUNT (DISTINCT staff.name), enclosure.name FROM staff 
INNER JOIN assignment
on assignment.employeeId = staff.id
INNER JOIN enclosure
ON enclosure.id = assignment.enclosureId
WHERE enclosure.id = 4
GROUP BY enclosure.name;



-- EXTENSION 5
SELECT * from enclosure
INNER JOIN animal
ON animal.enclosure_id = enclosure.id
WHERE animal.enclosure_id IN (SELECT animal.enclosure_id 
FROM animal 
WHERE animal.name = 'Tony');



