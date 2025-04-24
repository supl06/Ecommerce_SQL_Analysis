# 🛒 Ecommerce SQL Data Analysis

This project involves creating a relational database for an ecommerce platform and performing SQL-based data analysis tasks. It uses **MySQL** to store, manage, and query structured data to gain business insights.

---

## 📁 Project Structure

- `task3_queries.sql` — SQL script containing all the queries for analysis.
- `README.md` — Project documentation.

---

## 🧱 Database Design

The ecommerce database contains the following tables:

- **customers** — customer details
- **products** — product inventory
- **orders** — orders placed by customers
- **order_items** — items included in each order

---

## 🎯 Objective

Use SQL to perform the following data analysis tasks:

- ✅ Basic queries using `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`
- ✅ `JOIN` operations (INNER, LEFT, RIGHT)
- ✅ Subqueries
- ✅ Aggregate functions (`SUM`, `AVG`)
- ✅ Views for summary analysis
- ✅ Index creation for query optimization

---

## 💡 Example Queries

```sql
-- Find customers from Mumbai
SELECT * FROM customers WHERE city = 'Mumbai';

-- Total spending by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;
