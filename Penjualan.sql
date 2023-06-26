#DATA BASE PENJUALAN

# open database penjualan
select *  from PENJUALAN.clean_data


# 1. What is the best sales by product sub category
select
	product_sub_category,
	sum(sales) as penjualan
from 
	PENJUALAN.clean_data cd
group by
	product_sub_category
order by
	sum(sales) desc
	
	
#Mengetahui persen jualan
select product_sub_category, penjualanbarang
from (select
	product_sub_category,
	sum(sales) as penjualanBarang,
	(select sum(sales)  from PENJUALAN.clean_data cd1) as TotalPenjualan
from 
	PENJUALAN.clean_data cd
group by
	product_sub_category
order by
	sum(sales) desc)
		

# 2. What is the best sales by product category
select
	product_category ,
	sum(sales) as penjualan
from 
	PENJUALAN.clean_data cd
group by
	product_category 
order by
	sum(sales) desc

# 3. what was the best year for sales in a spesific year ? how much was earned that year?
select
	distinct year(order_date),
	sum(sales) as REVENUE,
	count(order_id) as FREQUENCY
from 
	PENJUALAN.clean_data cd  
group by 
	year(order_date) 
order by 
	2 desc
	
# 4. what was the best month for sales in a spesific month ? how much was earned that month?	
select
	distinct month(order_date),
	sum(sales) as REVENUE,
	count(order_id) as FREQUENCY
from 
	PENJUALAN.clean_data cd  
where
	year(order_date)= 2009#GANTI TAHUN UNTUK MENDAPAT LAPORAN TAHUNAN UNTUK TIAP BULAN
group by 
	month(order_date) 
order by 
	2 desc
	
# 5. what was the most product for sales in march 2009 ?
select
	product_category ,
	sum(sales) as REVENUE,
	count(order_id) as FREQUENCY
from 
	PENJUALAN.clean_data cd  
where
	year(order_date)= 2009 and month(order_date) = 3 #GANTI
group by 
	product_category 
order by 
	2 desc
	
	
# 6. what was the most product sub category  for sales in march 2009 ?
select
	product_sub_category  ,
	sum(sales) as REVENUE,
	count(order_id) as FREQUENCY
from 
	PENJUALAN.clean_data cd  
where
	year(order_date)= 2009 and month(order_date) = 3 #GANTI
group by 
	product_sub_category 
order by 
	2 desc
	

# 7. what was the most product sub category  for sales ?	
select
	product_sub_category  ,
	sum(sales) as REVENUE,
	count(order_id) as FREQUENCY
from 
	PENJUALAN.clean_data cd  
group by 
	product_sub_category 
order by 
	2 desc
	
# 8. what was the most product sub category  for frequency ?	
select
	product_sub_category  ,
	sum(sales) as REVENUE,
	count(order_id) as FREQUENCY
from 
	PENJUALAN.clean_data cd  
group by 
	product_sub_category 
order by 
	3 desc

# 9. what was the most customer  for frequency ?	
select
	customer,
	sum(sales) as REVENUE,
	count(order_id) as FREQUENCY
from 
	PENJUALAN.clean_data cd  
group by 
	customer  
order by 
	3 desc 
limit 10

				# Mengetahui jenis dan jumlah yang di beli oleh customer
				select 
					customer,
					product_sub_category,
					count(product_sub_category) as "Jumlah"
				from PENJUALAN.clean_data cd 
				where customer = "Maria Bertelson" # Ganti nama
				group by product_sub_category 
				order by 3 desc  


# 10. How many quantity sold by year
select
	distinct year(order_date),
	sum(order_quantity)
from 
	PENJUALAN.clean_data cd  
group by 
	year(order_date)
order by 
	2 desc

# 11. How many quantity sold by month
select
	distinct month(order_date) as "Bulan",
	sum(order_quantity) as "Jumlah_Barang"
from 
	PENJUALAN.clean_data cd 
where 
	year(order_date) = 2012 #ganti tahun untuk mendapat laporan di tahun itu.
group by 
	month(order_date) 
order by 
	2 desc
	
				#Mengetahui jenis dan jumlah product sub categori pada tahun dan bulan tertentu. 
				select 
					product_sub_category,
					count(product_sub_category) as "Jumlah"
				from 
					PENJUALAN.clean_data cd 
				where 
					year(order_date) = 2012 and month(order_date)= 10
				group by 
					product_sub_category
				order by 
					2 desc


#12. STATUS ORDER 2009 - 2012.
select distinct order_status,
	count(order_status)
from penjualan.clean_data cd 
group by order_status 


select *  from PENJUALAN.clean_data cd

#13. Nama dengan discount terbanyak (Berdasarkan Persentase)
select 
	distinct customer,
	sum(discount_value) TotalDiscount ,
	sum(sales) TotalSales,
	(sum(sales)- sum(discount_value)) as Monetary,
	(sum(discount_value)/ sum(sales))*100 as Percentage
from penjualan.clean_data cd
group by customer
order by 5 desc


select *  from PENJUALAN.clean_data

#13. CTE FUNCTION WITH RANK ()
select customer, 
sales, 
product_category,
AVG(SALES) over (partition by customer) as AVGCS,
MIN(SALES) over (partition by customer) as MINCS,
MAX(SALES) over (partition by customer) as MAXCS,
RANK() OVER(order by sales) as RANKALL,
RANK() OVER(partition by product_category order by sales DESC)as RANKPARTITION
from penjualan.clean_data cd


#14. CTE FUNCTION
with CTE AS (
select customer, 
sales, 
product_category,
AVG(SALES) over (partition by customer) as AVGCS,
MIN(SALES) over (partition by customer) as MINCS,
MAX(SALES) over (partition by customer) as MAXCS,
RANK() OVER(order by sales) as RANKALL,
RANK() OVER(partition by product_category order by sales DESC)as RANKPARTITION
from penjualan.clean_data cd)
select CUSTOMER, SALES, product_category, RANKPARTITION
from CTE
where RANKPARTITION < 6













