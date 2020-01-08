SELECT DISTINCT i.* FROM invoice AS i
INNER JOIN invoice_line AS il
ON i.invoice_id = il.invoice_id
WHERE il.unit_price > 0.99;

SELECT i.invoice_date, c.first_name, c.last_name, i.total FROM invoice AS i
INNER JOIN customer AS c
ON c.customer_id = i.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name FROM customer AS c
INNER JOIN employee AS e
ON c.support_rep_id = e.employee_id;

SELECT al.title, ar.name FROM album AS al
INNER JOIN artist AS ar
ON al.artist_id = ar.artist_id;

SELECT pt.track_id FROM playlist_track AS pt
INNER JOIN playlist AS p
ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

SELECT t.name FROM track AS t
INNER JOIN playlist_track AS pt
ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5;

SELECT t.name, p.name FROM track AS t
INNER JOIN playlist_track AS pt
ON t.track_id = pt.track_id
INNER JOIN playlist AS p
ON pt.playlist_id = p.playlist_id;

SELECT t.name, a.title FROM track AS t
INNER JOIN album AS a
ON t.album_id = a.album_id
INNER JOIN genre AS g
ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk';

SELECT t.name, g.name, a.title, ar.name
FROM playlist AS p
INNER JOIN playlist_track AS pt
ON p.playlist_id = pt.playlist_id
INNER JOIN track AS t
ON pt.track_id = t.track_id
INNER JOIN genre AS g
ON g.genre_id = t.genre_id
INNER JOIN album AS a
ON a.album_id = t.album_id
INNER JOIN artist AS ar
ON a.artist_id = ar.artist_id
WHERE p.name = 'Music';

SELECT * FROM invoice
WHERE invoice_id IN (
  SELECT DISTINCT invoice_id FROM invoice_line
  WHERE unit_price > 0.99
);

SELECT * FROM playlist_track
WHERE playlist_id IN (
  SELECT DISTINCT playlist_id FROM playlist
  WHERE name = 'Music'
);

SELECT * FROM track
WHERE genre_id IN (
  SELECT genre_id FROM genre
  WHERE name = 'Comedy'
);

SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
  WHERE title = 'Fireball'
);

SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
  WHERE artist_id IN (
    SELECT artist_id FROM artist
    WHERE name = 'Queen'
  )
);

UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE composer IS NULL AND genre_id IN (
  SELECT genre_id FROM genre
  WHERE name = 'Metal'
);

SELECT COUNT(t.track_id), g.name FROM track AS t
INNER JOIN genre AS g
ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT(t.track_id), g.name FROM track AS t
INNER JOIN genre AS g
ON t.genre_id = g.genre_id
WHERE g.name IN ('Pop', 'Rock')
GROUP BY g.name;

SELECT COUNT(al.album_id), ar.name FROM album AS al
INNER JOIN artist AS ar
ON al.artist_id = ar.artist_id
GROUP BY ar.name;

SELECT DISTINCT composer FROM track;

SELECT DISTINCT billing_postal_code FROM invoice;

SELECT DISTINCT company FROM customer;

DELETE FROM practice_delete
WHERE type = 'bronze';

DELETE FROM practice_delete
WHERE type = 'silver';

DELETE FROM practice_delete
WHERE value = 150;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(60),
  email VARCHAR(100)
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  price INTEGER
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  product_id INTEGER REFERENCES products(id)
);

INSERT INTO users
(name, email)
VALUES
('Hank', 'beebop@rankhank.net'),
('Julie', 'iamjules@gmail.com'),
('Robbie', 'robbie@robbie.org');

INSERT INTO products
(name, price)
VALUES
('Foot Scrubber', 30),
('Computer', 1000),
('New Car', 23000);

INSERT INTO orders
(product_id)
VALUES
(1),
(2),
(3);

SELECT * FROM orders
WHERE id = 1;

SELECT * FROM orders;

SELECT SUM(p.price) FROM products AS p
INNER JOIN orders AS o
ON p.id = o.product_id
WHERE o.id = 1;

ALTER TABLE orders
ADD user_id INTEGER REFERENCES users(id);

UPDATE orders
SET user_id = 1
WHERE id = 1;

UPDATE orders
SET user_id = 3
WHERE id = 2;

UPDATE orders
SET user_id = 2
WHERE id = 3;

SELECT * FROM orders
NATURAL JOIN users
WHERE users.id = 1;

SELECT users.name, count(id) FROM orders
NATURAL JOIN users
GROUP BY users.id;

SELECT u.name, SUM(p.price) FROM products AS p
INNER JOIN orders AS o
ON o.product_id = p.id
INNER JOIN users AS u
ON u.id = o.user_id
GROUP BY u.id;