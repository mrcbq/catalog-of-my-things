CREATE DATABASE catalog;

CREATE TABLE items (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
    published_date DATE,
    archived BOOLEAN,
    author_id INT
);

CREATE TABLE authors (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    item_id INT
);

CREATE TABLE games (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
    multiplayer VARCHAR(100) NOT NULL ,
    last_played_at DATE NOT NULL
);

ALTER TABLE items ADD FOREIGN KEY(author_id) REFERENCES authors(id);
ALTER TABLE authors ADD FOREIGN KEY(item_id) REFERENCES items(id);