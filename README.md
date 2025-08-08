#  SQL Practice – Joins, Window Functions & CTEs

This repository contains a series of **SQL practice queries** focused on three key areas of intermediate SQL:

- ✅ Joins (INNER, LEFT)
- ✅ Window Functions (ROW_NUMBER, RANK, DENSE_RANK, SUM OVER, etc.)
- ✅ Common Table Expressions (CTEs, including multi-CTEs)

---

##  Dataset Assumptions

The queries are written assuming a basic sales schema with the following tables:

- `customers(id, name, city)`
- `products(product_id, product_name, category)`
- `sales(sale_id, customer_id, product_id, amount, sale_date)`

---

##  Topics Covered

| Sno | Category           | Description                                      |
|---|--------------------|--------------------------------------------------|
| 1 | **Joins**          | Combining customer, sales, and product data     |
| 2 | **Window Functions** | Ranking, cumulative sums, row numbering       |
| 3 | **CTEs**           | Modular queries, reuse logic, improve readability |
| 4 | **Aggregation**    | Total purchases, revenue per category           |
| 5 | **Filters**        | WHERE vs HAVING usage                           |
| 6 | **Combined Use**   | Multi-CTEs + joins + window functions           |

---

##  Sample Practice Tasks

- Find total revenue by product category  
- Rank customers by spending within each city  
- Get latest purchase per customer  
- Identify customers with more than 1 purchase  
- Calculate running totals per customer  
- Rank products by revenue with ties using DENSE_RANK()

---

##  Tools Used

- MySQL   


---

##  Notes

- Focused on **real interview-style questions**  
- Great for improving logic building in SQL  
- Beginner to Intermediate level

---

##  How to Use

You can open the `.sql` file and run each block individually in your SQL environment.  
Feel free to customize the queries or schema for your own practice.


