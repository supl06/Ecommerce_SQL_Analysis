Microsoft Windows [Version 10.0.26100.3775]
(c) Microsoft Corporation. All rights reserved.

C:\Users\Supriya Lokhande>mysql -u root -p
Enter password: ****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 16
Server version: 8.0.40 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE ecommerce;
Query OK, 1 row affected (0.01 sec)

mysql> USE ecommerce;
Database changed
mysql> CREATE TABLE customers (
    ->     customer_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     email VARCHAR(100),
    ->     city VARCHAR(50),
    ->     signup_date DATE
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE products (
    ->     product_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     product_name VARCHAR(100),
    ->     category VARCHAR(50),
    ->     price DECIMAL(10,2),
    ->     stock INT
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE orders (
    ->     order_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     customer_id INT,
    ->     order_date DATE,
    ->     total_amount DECIMAL(10,2),
    ->     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE order_items (
    ->     item_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     order_id INT,
    ->     product_id INT,
    ->     quantity INT,
    ->     price DECIMAL(10,2),
    ->     FOREIGN KEY (order_id) REFERENCES orders(order_id),
    ->     FOREIGN KEY (product_id) REFERENCES products(product_id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO customers (name, email, city, signup_date) VALUES
    -> ('Aisha Mehta', 'aisha@example.com', 'Mumbai', '2024-01-10'),
    -> ('Rahul Desai', 'rahul@example.com', 'Pune', '2024-02-15'),
    -> ('Neha Sharma', 'neha@example.com', 'Delhi', '2024-03-01');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO products (product_name, category, price, stock) VALUES
    -> ('Bluetooth Speaker', 'Electronics', 2999.99, 50),
    -> ('Running Shoes', 'Footwear', 3999.00, 30),
    -> ('Backpack', 'Accessories', 1499.00, 100);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO orders (customer_id, order_date, total_amount) VALUES
    -> (1, '2024-04-01', 7498.99),
    -> (2, '2024-04-05', 3999.00),
    -> (3, '2024-04-10', 1499.00);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
    -> (1, 1, 1, 2999.99),
    -> (1, 2, 1, 3999.00),
    -> (2, 2, 1, 3999.00),
    -> (3, 3, 1, 1499.00);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM customers WHERE city = 'Mumbai';
+-------------+-------------+-------------------+--------+-------------+
| customer_id | name        | email             | city   | signup_date |
+-------------+-------------+-------------------+--------+-------------+
|           1 | Aisha Mehta | aisha@example.com | Mumbai | 2024-01-10  |
+-------------+-------------+-------------------+--------+-------------+
1 row in set (0.00 sec)

mysql> SELECT customer_id, SUM(total_amount) AS total_spent
    -> FROM orders
    -> GROUP BY customer_id
    -> ORDER BY total_spent DESC;
+-------------+-------------+
| customer_id | total_spent |
+-------------+-------------+
|           1 |     7498.99 |
|           2 |     3999.00 |
|           3 |     1499.00 |
+-------------+-------------+
3 rows in set (0.02 sec)

mysql> SELECT o.order_id, c.name, o.order_date, o.total_amount
    -> FROM orders o
    -> INNER JOIN customers c ON o.customer_id = c.customer_id;
+----------+-------------+------------+--------------+
| order_id | name        | order_date | total_amount |
+----------+-------------+------------+--------------+
|        1 | Aisha Mehta | 2024-04-01 |      7498.99 |
|        2 | Rahul Desai | 2024-04-05 |      3999.00 |
|        3 | Neha Sharma | 2024-04-10 |      1499.00 |
+----------+-------------+------------+--------------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM customers
    -> WHERE customer_id IN (
    ->   SELECT customer_id
    ->   FROM orders
    ->   GROUP BY customer_id
    ->   HAVING SUM(total_amount) > (
    ->     SELECT AVG(total_amount) FROM orders
    ->   )
    -> );
+-------------+-------------+-------------------+--------+-------------+
| customer_id | name        | email             | city   | signup_date |
+-------------+-------------+-------------------+--------+-------------+
|           1 | Aisha Mehta | aisha@example.com | Mumbai | 2024-01-10  |
+-------------+-------------+-------------------+--------+-------------+
1 row in set (0.01 sec)

mysql> SELECT AVG(total_amount) AS avg_order_value FROM orders;
+-----------------+
| avg_order_value |
+-----------------+
|     4332.330000 |
+-----------------+
1 row in set (0.00 sec)

mysql> CREATE VIEW customer_order_summary AS
    -> SELECT c.name, c.city, SUM(o.total_amount) AS total_spent
    -> FROM customers c
    -> JOIN orders o ON c.customer_id = o.customer_id
    -> GROUP BY c.customer_id;
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> CREATE INDEX idx_customer_id ON orders(customer_id);
Query OK, 0 rows affected (0.08 sec)
Records: 0  Duplicates: 0  Warnings: 0
