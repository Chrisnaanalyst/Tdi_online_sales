# Tdi_online_sales

![](tdi_image.jpg)

# Online Sales Analysis

## 📌 Project Overview
This project analyzes an e-commerce dataset using SQL to extract insights on revenue trends, customer behavior, payment methods, returns, and profitability.

## 📊 Dataset Description
The dataset contains 49,782 records and 17 columns, including information about sales, customers, product details, and shipping. 
Here's a summary of the columns:
- `InvoiceNo` - Transaction ID
- `InvoiceDate` - Date of transaction
- `CustomerID` - Unique identifier for customers
- `Description` - Product details
- `Quantity` - Number of items sold/returned
- `UnitPrice` - Price per unit
- `Discount` - Discounts applied
- `Country` - Customer location
- `ReturnStatus` - Indicates if the product was returned
- `PaymentMethod` - Method used for payment
- `ShippingCost` - Cost of shipping
- `ShipmentProvider` - Delivery service used

## 🛠 SQL Queries
The project covers:
1. **Sales Analysis** (Total revenue, best-selling products, revenue trends)
2. **Customer Insights** (Top customers, retention rate, country-based insights)
3. **Payment Method Analysis** (Revenue & discount distribution)
4. **Returns Management** (Products with high return rates)
5. **Operational Efficiency** (Shipping costs, order priority distribution)
6. **Promotions & Discounts** (Impact of discounts, correlation with returns)
7. **Profitability Analysis** (Gross margin estimates)
8. **Regional Performance** (Sales comparison across countries)



## 🔍 Sample Query
Here's an example SQL query to find the **best-selling products**:
```sql
SELECT description, SUM(quantity) AS "Total Sold"
FROM online_sales
WHERE quantity > 0
GROUP BY description
ORDER BY SUM(quantity) DESC
LIMIT 10;

💡 How to Use This Analysis

Load the dataset TDI online_sales_dataset (1).csv into a relational database (e.g., MySQL, PostgreSQL, or SQL Server).

Run the SQL queries provided in this project to generate insights.

Modify the queries to fit specific business needs or datasets.

Visualize the results using tools like Power BI, Tableau, or Python for deeper insights.

📝 File Information

TDI_Project.sql - Contains all SQL queries used in this analysis.

README.md - This documentation file to guide users on project usage.

✨ Contributions

Feel free to fork this repository and add improvements or modifications! If you find any errors or have suggestions,
please open an issue or submit a pull request.

📂 SQL File

The full set of SQL queries used for this analysis has been included in the TDI_Project.sql file.
You can access and modify it to fit your specific analysis needs.
