SELECT
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';
  
  SELECT
    COUNT(DISTINCT CustomerID) AS total_customers
FROM ecommerce_analysis.ecommerce_sales
WHERE TRIM(CAST(CustomerID AS CHAR)) <> ''
  AND Quantity > 0
  AND UnitPrice > 0;
  
  SELECT
    ROUND(SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo), 2)
        AS average_order_value
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';
  
  SELECT
    YEAR(STR_TO_DATE(InvoiceDate, '%d-%m-%y %H:%i')) AS sales_year,
    ROUND(SUM(Quantity * UnitPrice), 2) AS yearly_revenue
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
GROUP BY sales_year
ORDER BY sales_year;

SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue,
    ROUND(
        SUM(Quantity * UnitPrice) * 100 /
        (
            SELECT SUM(Quantity * UnitPrice)
            FROM ecommerce_analysis.ecommerce_sales
            WHERE Quantity > 0 AND UnitPrice > 0
        ),
        2
    ) AS revenue_percentage
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    DATE_FORMAT(
        STR_TO_DATE(InvoiceDate, '%d-%m-%y %H:%i'),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS monthly_revenue
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
GROUP BY sales_month
ORDER BY monthly_revenue DESC
LIMIT 1;

SELECT
    Country,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%'
GROUP BY Country
ORDER BY total_orders DESC
LIMIT 10;

SELECT
    StockCode,
    MAX(Description) AS product_name,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
  AND StockCode NOT LIKE 'POST%'
GROUP BY StockCode
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    StockCode,
    MAX(Description) AS product_name,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
  AND StockCode NOT LIKE 'POST%'
  AND StockCode <> 'DOT'
GROUP BY StockCode
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    Country,
    YEAR(STR_TO_DATE(InvoiceDate, '%d-%m-%y %H:%i')) AS sales_year,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM ecommerce_analysis.ecommerce_sales
WHERE Quantity > 0
  AND UnitPrice > 0
GROUP BY Country, sales_year
ORDER BY total_revenue DESC
LIMIT 10;