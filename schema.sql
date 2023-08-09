CREATE DATABASE catalog;

CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE labels (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    published_date DATE NOT NULL,
    archived BOOLEAN NOT NULL,
    genre_id INT,
    author_id INT,
    label_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (label_id) REFERENCES labels(id)
);

CREATE TABLE music_albums (
    id SERIAL PRIMARY KEY,
    on_spotify BOOLEAN NOT NULL,
    item_id INT,
    FOREIGN KEY (item_id) REFERENCES items(id)
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    multiplayer VARCHAR(100) NOT NULL,
    last_played_at DATE NOT NULL
);

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher VARCHAR(255),
    cover_state VARCHAR(255),
    label_id INT,
    genre_id INT,
    author_id INT,
    published_date DATE,
    FOREIGN KEY (label_id) REFERENCES labels(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);
