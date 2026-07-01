# 📚 DBMS Workshop - LJU

> A comprehensive collection of DBMS workshop exercises completed during my Master of Computer Applications (MCA) at Lok Jagruti University (LJU). This repository demonstrates database design, SQL queries, JOIN operations, aggregate functions, and an Order Management System implemented using MySQL.

---

## 📌 Project Information

| Property | Details |
|----------|----------|
| **Project Name** | Order Management System |
| **Subject** | Database Management System (DBMS) |
| **Workshop** | DBMS Workshop |
| **Database** | MySQL |
| **Language** | SQL |
| **Course** | Master of Computer Applications (MCA) |
| **University** | Lok Jagruti University (LJU) |
| **Author** | Mohmadhusen Khimani |

---

# 📖 Problem Statement

An online shopping company wants to develop an **Order Management System** to manage customers, products, and customer orders.

The system stores information about:

- 👤 Customers
- 📦 Products
- 🛒 Orders

The database is designed using relational tables with primary and foreign key relationships.

---

# 🗂 Database Schema

## Customer

| Column | Description |
|---------|-------------|
| CustomerID | Unique Customer ID |
| CustomerName | Customer Name |
| Email | Email Address |
| Phone | Phone Number |
| City | City |

---

## Product

| Column | Description |
|---------|-------------|
| ProductID | Unique Product ID |
| ProductName | Product Name |
| Category | Product Category |
| Price | Product Price |

---

## Orders

| Column | Description |
|---------|-------------|
| OrderID | Unique Order ID |
| CustomerID | Customer Reference |
| ProductID | Product Reference |
| Quantity | Quantity Purchased |
| OrderDate | Order Date |
| TotalAmount | Total Purchase Amount |

---

# 📂 Repository Structure

```
DBMS-Workshop-LJU/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── SQL/
│   └── DBMS_Workshop_Order_Management_System.sql
│
├── Documentation/
│   └── Workshop_Question.pdf
│
└── Screenshots/
    ├── Q1_Output.png
    ├── Q2_Output.png
    ├── ...
    └── Q10_Output.png
```

---

# 🛠 Features

- Database Creation
- Table Creation
- Data Insertion
- Primary Keys
- Foreign Keys
- SQL SELECT Queries
- INNER JOIN
- Aggregate Functions
- GROUP BY
- ORDER BY
- Invoice Generation
- Sales Reports

---

# 📋 SQL Queries Included

### Q1
Display the list of all customers.

### Q2
Display the names of all available products.

### Q3
Display the total number of products purchased by each customer.

### Q4
Display the quantity of each product purchased by a particular customer.

### Q5
Generate a customer invoice showing:

- Customer Name
- Product Name
- Product Price
- Quantity Purchased
- Total Amount
- Order Date

### Q6
Display customers who purchased products worth more than ₹5,000.

### Q7
Display the customer name along with the product name purchased.

### Q8
Display the total sales amount.

### Q9
Display the most expensive product.

### Q10
Display the total number of orders placed by each customer.

---

# 💻 Technologies Used

- MySQL
- SQL
- Relational Database Management System (RDBMS)

---

# 🎯 Learning Outcomes

After completing this workshop, I learned:

- Creating databases and tables
- Designing relational database schemas
- Using Primary Keys and Foreign Keys
- Writing SQL queries
- Performing JOIN operations
- Using Aggregate Functions
- Generating reports using SQL
- Retrieving and filtering data efficiently

---

# 🚀 How to Run

1. Open MySQL Workbench (or any MySQL client).
2. Create a new SQL file.
3. Copy the contents of `DBMS_Workshop_Order_Management_System.sql`.
4. Execute the script.
5. Run each query to view the required outputs.

---

# 📜 License

This repository is created for educational purposes as part of the MCA DBMS Workshop at Lok Jagruti University.

---

## 👨‍💻 Author

**Mohmadhusen Khimani**

🎓 Master of Computer Applications (MCA)  
🏫 Lok Jagruti University (LJU)

---

⭐ If you found this repository useful, consider giving it a star!
