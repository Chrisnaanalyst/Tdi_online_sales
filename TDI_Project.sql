create database project;
use project;
select * from online_sales;

Alter table online_sales
modify column InvoiceDate date;



DESC online_sales;

# 1 Sales Analysis
select round(sum(quantity * unitprice * (1-discount))) As "Total Revenue"
	from online_sales;
    
#Best selling products
select description, sum(quantity) AS "Total sold"
	from online_sales
	where quantity > 0
	group by description
	order by sum(quantity) DESC
	limit 10;
    

#Revenue trends over time 
select date_format(InvoiceDate, '%M-%Y') 
	As Month,
	round(sum(Quantity * UnitPrice * (1- Discount)), 0) AS 'Total Revenue'
	from online_sales
	group by Month
	order by sum(Quantity * UnitPrice * (1- Discount)) Asc;

#Country with the highest quantity of item sold
select country, sum(quantity) as totalquantity
	from online_sales
    where quantity > 0
	group by country
	order by sum(quantity) desc;
    
#Category by Revenue
select Category, 
	round(sum(quantity * unitprice * (1-discount)),0) As "Total Revenue"
	from online_sales
	group by Category 
	order by sum(quantity * unitprice * (1-discount)) desc ;
    
# 2. Customer Insights
# Total number of Customers
select distinct count(CustomerID) 'No of Customers'
	From online_sales
	where CustomerID IS NOT NULL AND
    trim(CustomerId) <> '';
    
#Top customers by spending 
select CAST(CAST( CustomerID AS unsigned) 
	AS CHAR) AS CustomerID,
	round(sum(Quantity * UnitPrice * (1- Discount)), 0) AS 'Total Spending'
    from online_sales
    where CustomerID is not null AND
    trim(CustomerId) <> ''
    group by CustomerID
    order by round(sum(Quantity * UnitPrice * (1- Discount)), 0) Desc
    limit 10;
    
# Customer Retention Rate
# This essentially measures the customer retention or
# frequency of purchase over time.
select cast(cast(customerID As unsigned)
	AS Char) AS customerID,
	count( distinct
    date_format(InvoiceDate, '%y-%m')) as 'Months Purchased'
    from online_sales
    where customerID is not null And
    trim(customerID) <> ''
    group by customerID
    order by count(distinct 
    date_format(InvoiceDate, '%y-%m')) desc;

#Revenue and customer analysis by Country 
select country,
	count(distinct customerID) AS
    'unique customers',
		round(sum(Quantity * UnitPrice * (1- Discount)),0) 
        As 'Total Revenue'
        from online_sales
        group by country
        order by round(sum(Quantity * UnitPrice * (1- Discount)),0) desc;
    
# 3.Payment Method Distribution
# Total Revenue by payment method
    select PaymentMethod, 
		round(sum(Quantity * UnitPrice * (1- Discount)), 0) AS 'Total Revenue'
        from online_sales
        group by PaymentMethod
        order by round(sum(Quantity * UnitPrice * (1- Discount)), 0) desc;
        
	# Total Discounts by payment method
        select paymentmethod, round(sum(discount),2) 'Total Discount'
			from online_sales
			group by paymentmethod
			order by sum(discount) Desc;
            
            
# 4. Returns Management
   # Products with the highest return rates
   select
		Description,
        sum(CASE WHEN ReturnStatus ='Returned'
        Then ABS(Quantity) Else 0 END) AS
        'Total Returns',
			sum(Quantity) As 'Total Quantity',
            (sum(CASE WHEN ReturnStatus ='Returned'
			Then ABS(Quantity) Else 0 END ) * 1.0 /
            sum(Quantity)) AS 'Return Rate'
            from online_sales
            group by Description
            Having sum(Quantity)
            order by (sum(CASE WHEN ReturnStatus ='Returned'
			Then ABS(Quantity)  Else 0 END ) * 1.0 /
            sum(Quantity))
            limit 10;
            
            
      # Return by Category    
      select Category, 
		sum(case when ReturnStatus = 'Returned' 
        then ABS(Quantity) else 0 End) As 'Total Returns',
        count(distinct case when 
        ReturnStatus = 'Returned' then
        InvoiceNo else null end) as 
        'Total Return Orders'
        from online_sales
        group by Category
        order by sum(case when ReturnStatus = 'Returned'
        then ABS(Quantity) else 0 End) desc;
        
#5.  Opertional Efficiency
    #Shipping Costs by Provider
    select
		ShipmentProvider,
       cast(Sum(ShippingCost) AS decimal(10,2)) AS
	'Total Shipping Cost',
			count(*) AS 'Total Orders'
	 from online_sales
     where ShippingCost is not null
     group by ShipmentProvider
     order by Sum(ShippingCost) Desc;
     
    #Order priority Distribution
    select
		OrderPriority,
        count(*) AS TotalOrders
	from online_sales
    group by OrderPriority
    order by count(*) desc;
    

# 5. Promotions and Discounts
  # Impact of Discounts on Sales
  select 
	Discount,
    count(*) As TotalOrders, 
    sum(Quantity * UnitPrice) AS 
TotalRevenueBeforeDiscount,
	round(sum(Quantity * UnitPrice * (1- 
    Discount)),0) As 
TotalRevenueAfterDiscount
from online_sales
group by Discount
order by Discount Desc;


# To Cap  Discounts
update online_sales
set Discount = 1
where Discount > 1;

#To prevent similar issues in the future.
Alter Table online_sales
Add constraint chk_discount check
(Discount >= 0 And Discount <= 1);


# correlaton between discounts and returns
select
	Discount,
    count(distinct InvoiceNo) As TotalOrders,
    count(distinct case 
			when ReturnStatus = 
'Returned' then InvoiceNo end) As TotalReturnedOrders,
			round(count(distinct case
					when  ReturnStatus = 
'Returned' then InvoiceNo end) * 100.0/ count(distinct
InvoiceNo), 2) As ReturnRate
from
		online_sales
group by
		Discount
order by
		Discount desc;
        
# 6. Profitability
#Profit Margins by Product

select
	Description,
    round(sum(Quantity * UnitPrice * (1- Discount)), 0) -
    round(sum(ShippingCost)) As GrossMarginEstimate,
		round(sum(Quantity * UnitPrice)) As
	Revenue
    from online_sales
    group by Description
    order by round(sum(Quantity * UnitPrice * (1- Discount)), 0) -
    round(sum(ShippingCost)) Desc
    limit 10;
    
# 7. Regional Performance
   # Compare sales accross Regions
   select Country,
		round(sum(Quantity * UnitPrice * (1- Discount)), 0) 
	As 'Total Revenue'
    from online_sales
    group by Country
    order by round(sum(Quantity * UnitPrice * (1- Discount)), 0) Desc;
		
    
    
        
        
    

		

    
    
    
 
 
 

 
 
     

        
        