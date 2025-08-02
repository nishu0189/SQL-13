# SQL-13

# SQL-13

This repository contains advanced SQL practice queries focused on **Data Manipulation**, **Permissions**, and **Transaction Control** using T-SQL (SQL Server).

---

## 🔍 Topics Covered

### 1. **UPDATE Queries**
- Updating values using `WHERE` clause.
- Using `INNER JOIN` to update from another table.
- Handling issues when updating with subqueries.

### 2. **ALTER & Column Management**
- Adding new columns like `dept_N` to the `emp` table.
- Populating data using joins from `dept`.

### 3. **DELETE & TRUNCATE**
- Difference between `DELETE` and `TRUNCATE`.
- Conditional deletion using subqueries.

### 4. **EXISTS / NOT EXISTS**
- Filtering data using `EXISTS` and `NOT EXISTS`.
- Performance considerations in row-based databases.

### 5. **Backup Tables**
- Creating backup copies using `SELECT INTO`.
- Inserting dummy or test data into backups.

### 6. **Permissions (DCL - Data Control Language)**
- `GRANT`, `REVOKE`, and role-based access control.
- Use of `guest` and `public` users.
- Granting schema-level access.
- `WITH GRANT OPTION` usage.

### 7. **Transaction Control (TCL)**
- `BEGIN TRAN`, `ROLLBACK`, `COMMIT`, and `SAVE TRAN`.
- Savepoints for partial rollbacks.
- Auto-commit behavior of DDL vs manual commit in DML.

---

## 🛠 SQL Features Practiced
- Subqueries
- Joins (INNER)
- DDL, DML, DCL, TCL commands
- Role creation and permission handling
- Backup and recovery logic
- Error handling with transactions

---

## 📂 Files
- `SQLQuery13.sql`: Contains all queries and notes explained above.

---

## 💡 Notes
- Uses Microsoft SQL Server syntax.
- Best suited for practicing real-time scenarios in enterprise SQL databases.

---

## 🔐 Security Warning
Avoid granting write permissions (`INSERT`, `DELETE`, `UPDATE`) to `guest` or `public` in production databases to prevent unauthorized modifications.

---

