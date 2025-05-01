with sales as (
select invoice_date, product, state, price_per_unit, units_sold from tables.adidas_us_sales
where product = (
select product from tables.adidas_us_sales 
group by product
order by sum(units_sold) desc
limit 1
)
)
select * from sales;

with sales as (
select invoice_date, units_sold from tables.adidas_us_sales
where product = (
select product from tables.adidas_us_sales 
group by product
order by sum(units_sold) desc
limit 1
) and price_per_unit >=40 and price_per_unit <= 45
)
select monthname(invoice_date)as month, year(invoice_date) as year, sum(units_sold) from sales
group by monthname(invoice_date), year(invoice_date)
order by year(invoice_date) asc ,monthname(invoice_date) asc;

with sales as (
select invoice_date,state, units_sold from tables.adidas_us_sales
where product = (
select product from tables.adidas_us_sales 
group by product
order by sum(units_sold) desc
limit 1
) and price_per_unit >=40 and price_per_unit <= 45
)
select month(invoice_date)as month, year(invoice_date) as year,state, sum(units_sold) from sales
where month(invoice_date) >= 6 and month(invoice_date) <=9
group by state, month(invoice_date), year(invoice_date)
order by year(invoice_date) asc ,month(invoice_date) asc;