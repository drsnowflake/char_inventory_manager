DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS characters;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS races;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS slots;

CREATE TABLE roles (
  id SERIAL PRIMARY KEY,
  role VARCHAR(255)
);

CREATE TABLE races (
  id SERIAL PRIMARY KEY,
  race VARCHAR(255)
);

CREATE TABLE slots (
  id SERIAL PRIMARY KEY,
  slot_name VARCHAR(255)
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name VARCHAR(255),
  slot INT REFERENCES slots(id),
  flav TEXT
);

CREATE TABLE characters (
  id SERIAL PRIMARY KEY,
  char_name VARCHAR(255),
  race_id INT REFERENCES races(id),
  role_id INT REFERENCES roles(id)
);

CREATE TABLE inventory (
  id SERIAL PRIMARY KEY,
  char_id INT REFERENCES characters(id),
  item_id INT REFERENCES items(id)
);


INSERT INTO slots (id, slot_name) VALUES ('-1', 'In Bag');
INSERT INTO roles (id, role) VALUES ('-1', 'TRASHPANDA');
INSERT INTO races (id, race) VALUES ('-1', 'VENDOR');
INSERT INTO characters (id, char_name, race_id, role_id) VALUES ('-1', 'Unassigned', '-1', '-1');
