create database Olist_Store;
use olist_store;

# KPI 1
create table Weekend_vs_Weekday_Payment as
select Day,Round(sum(Payment_value)) as Payment_Value,
Concat(Round(sum(payment_value)*100.0/(select sum(payment_value) from order_payments)),'%') As Percentage 
from orders a join order_payments b on a.order_id=b.order_id group by Day;

select * from weekend_vs_weekday_payment;

# KPI 2
 create table Total_orders_Rvw_Score5_Credit_card as 
 select  review_score as Review_score,payment_type as Payment_type, count(*) as Total_orders from
 order_reviews a join order_payments b on a.order_id=b.order_id
 where review_score=5 and payment_type='credit_card';
 
 select * from Total_orders_Rvw_Score5_Credit_card;
 
# KPI 3
create table Avg_Delivery_Days_Pet_Shop as 
select round(avg(delivery_days)) as Avg_Delivery_Days,
category_name_english as Category_Name from 
orders a cross join products b where category_name_english='pet_shop';
 
select * from Avg_Delivery_Days_Pet_Shop;

# KPI 4 
create table Avg_Price_Payment_SaoPaulo as
with orderitemsAvg as 
(select round(avg(a.price)) as Average_Price 
from order_items a join orders b on a.order_id=b.order_id
join customers c on b.customer_id=c.customer_id 
where c.customer_city='sao paulo')

select customer_city ,(select Average_Price from orderitemsAvg) as Avg_Price,
round(avg(d.payment_value)) as Avg_Payment_value 
from order_payments d 
join orders b on d.order_id=b.order_id
join customers c on b.customer_id = c.customer_id
where c.customer_city ='sao paulo';

select * from Avg_Price_Payment_SaoPaulo;


#KPI 5
create table Rvw_Score_Vs_Avg_Delivery_Days as
select review_score,Round(avg(delivery_days)) as Avg_Delivery_Days from  
order_reviews a join orders b on a.order_id=b.order_id 
group by review_score order by Avg_Delivery_Days desc ;

select*from Rvw_Score_Vs_Avg_Delivery_Days;
