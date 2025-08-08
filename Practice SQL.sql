use sj;
select * from customers;
select * from sales;
select * from products;

-- Find each customer and their total spending.Only return customers who spent more than ₹3000.

with total_spend as (Select customer_id,sum(Amount) as Total_Amount from sales
group by customer_id)
Select c.id,c.name,cs.total_amount from customers c
join total_spend cs on cs.customer_id=c.id
where total_amount >3000;

-- Show each customer’s purchase history with a row number (1 for most recent).

with running_spens as ( Select *,row_number() over(partition by customer_id order by sale_date desc) as an from  sales)
select * from running_spens
where an=1;

--  List all purchases with running total of amount per customer.

Select c.name,s.amount,s.sale_date,
sum(s.amount) over(partition by s.customer_id order by s.sale_date)as nm from customers c
join sales s on s.customer_id=c.id;

-- Task: List each city and the total revenue generated from customers in that city.

With total_revenue as(select c.city,s.amount  from sales s
join  customers c on s.customer_id=c.id)
select city,sum(amount) as city_revenue from total_revenue
group by city;
 
 -- Task: For each customer, assign a purchase rank based on the sale date (1 = earliest).
with an as ( select customer_id,amount, 
 rank() over(partition by customer_id order by sale_Date) as rn from sales)
 select * from an
order by customer_id,rn;

-- Task: Show the running total (cumulative sum) of spending for each customer, sorted by date.

Select c.name,sum(s.amount)
over(partition by customer_id order by sale_Date) As RS from sales s
join customers c on c.id=s.customer_id;

-- Task: Find all customers who purchased a ‘Mobile’ product and spent more than ₹1000 in total.

With purchased as (Select c. id,c.name,p.category,s. amount from sales s
join products p on s.product_id=p.product_id
join customers c on c.id=s.customer_id
where category ='mobile' )
Select id, name,category,sum(amount) as PA  from purchased
group by id;

-- Task: Find the latest purchase (most recent) for each customer and show the product name.

with latest_purchase as (Select c.id,c.name,p.product_name,s.amount,s.sale_date,
row_number () over (partition by c.id order by s.sale_date desc) as Rn from sales s
join customers c on c.id=s.customer_id
join products p on p.product_id=s.product_id)
select id,name,product_name,sale_date from latest_purchase
where rn >1;

-- Rank products by total revenue, and display ties using DENSE_RANK.

 with revenue as (Select p.product_name, sum(s.amount) As sm from sales s
join products p on p. product_id=s.product_id
group by product_name)
select product_name, sm ,
dense_rank()over(order by sm desc) as DR from revenue;

-- Task: First CTE: calculate total spending per customer.
-- Second CTE: latest purchase per customer.
-- Final: join both and show customer name, total spent, latest product.
   
 with total_spending as (select customer_id,sum(amount) as total_amount from sales
 group by customer_id),
 
 latest_purchase as (select customer_id,product_id,sale_date,
row_number() over(partition by customer_id order by sale_date desc)as pc from sales)

select c.name as customer_name,ts.total_amount,p.product_name as latest_product from total_spending ts
join latest_purchase lp on lp.customer_id=ts.customer_id and lp.pc=1
join customers c on ts.customer_id=c.id
join products p on p.product_id=lp.product_id;   

--   List customers who made more than 1 purchase and show how many purchases they made.->

Select c.id,c.name,count(s.product_id) as Total_purchase from customers c
join sales s on c.id=s.customer_id
group by c.id
having count(s.product_id)>1;

-- Find which product category brought in the most total revenue.
Select p.category,sum(s.amount) as Total_revenue from sales s
join products p on s.product_id=p.product_id
group by category
order by total_revenue desc
limit 1;
--  For each city, rank customers by total sales using RANK().
with Ts as  (Select c.city,c.name,sum(s.amount) As total_sales from customers c
 join sales s on c.id=s.customer_id
 group by c.id) 
select city,name,total_sales, rank()over(partition by city order by total_sales)as RN from Ts






