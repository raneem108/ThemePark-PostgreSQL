# Theme Park Library Database

A PostgreSQL database project developed as part of my database coursework.

## About the Project

This project is a relational database system for managing a library's members, staff, books, categories, and loans.

The project focuses on designing a relational database and using SQL and PL/pgSQL to manage, query, and automate database operations.

## Database Structure

The database includes the following main tables:

* **Members** – stores library member information and membership status
* **Staff** – stores staff information and supervisor relationships
* **Categories** – stores book categories
* **Books** – stores book details, categories, prices, and available copies
* **Loans** – records book loans, due dates, returns, and fines

The database uses:

* Primary keys
* Foreign keys
* Unique constraints
* Check constraints
* Default values
* Self-referencing relationships

## SQL Features

The project includes examples of:

* `SELECT`, `INSERT`, `UPDATE`, and `DELETE`
* Filtering and sorting
* `DISTINCT`
* Aggregate functions
* `GROUP BY` and `HAVING`
* Subqueries
* `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`
* Self-joins
* Indexes
* Database users and permissions

## PL/pgSQL

The project also includes procedural PostgreSQL features such as:

* Anonymous `DO` blocks
* Variables using `%TYPE`
* `IF / ELSIF / ELSE`
* `FOR` loops
* `WHILE` loops
* `RECORD` variables
* Exception handling
* User-defined functions
* Triggers

Examples include calculating late fines, counting member loans, issuing loans while checking available copies, and automatically updating book availability when a book is returned.

## Technologies

* PostgreSQL
* SQL
* PL/pgSQL
* pgAdmin


## Author

Raneem Abujabal

Data Science and Artificial Intelligence Graduate
Yarmouk University
