DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS characters;
DROP TABLE IF EXISTS items;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  slot INT,
  flav TEXT
);

CREATE TABLE characters (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  race VARCHAR(255),
  class VARCHAR(255)
);

CREATE TABLE inventory (
  id SERIAL PRIMARY KEY,
  char_id INT REFERENCES characters(id),
  item_id INT REFERENCES items(id)
);
