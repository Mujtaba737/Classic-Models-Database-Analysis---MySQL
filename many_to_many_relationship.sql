-- 1. List products sold by order date.

SELECT orderDate, GROUP_CONCAT(productName) AS products
FROM orders
INNER JOIN orderdetails USING(orderNumber)
INNER JOIN products USING(productCode)
GROUP BY orderDate
ORDER BY orderDate;


-- 2. List the order dates in descending order for orders for the 1940 Ford Pickup Truck.

SELECT orderDate
FROM orders
INNER JOIN orderdetails USING(orderNumber)
INNER JOIN products USING(productCode)
WHERE productName = "1940 Ford Pickup Truck"
ORDER BY orderDate DESC;


-- 3. List the names of customers and their corresponding order number where
--    a particular order from that customer has a value greater than $25,000?

SELECT customerName, orderNumber, SUM(quantityOrdered*priceEach) AS Value
FROM customers
INNER JOIN orders USING(customerNumber)
INNER JOIN orderdetails USING(orderNumber)
GROUP BY customerName, orderNumber
HAVING SUM(quantityOrdered*priceEach) > 25000;


-- 5. List the names of products sold at less than 80% of the MSRP.

SELECT DISTINCT productName
FROM products
INNER JOIN orderdetails USING(productCode)
WHERE (priceEach/MSRP)*100 < 80;


-- 6. Reports those products that have been sold with a markup of 100% or more 
-- (i.e.,  the priceEach is at least twice the buyPrice)

SELECT productName, buyPrice, priceEach
FROM orderdetails
INNER JOIN products USING(productCode)
WHERE priceEach >= 2*buyPrice;


-- 7. List the products ordered on a Monday.

SELECT DISTINCT productName
FROM orders
INNER JOIN orderdetails USING(orderNumber)
INNER JOIN products USING(productCode)
WHERE DAYNAME(orderDate) = "Monday";


-- 8. What is the quantity on hand for products listed on 'On Hold' orders?

SELECT productCode, productName, quantityInStock
FROM orders
INNER JOIN orderdetails USING(orderNumber)
INNER JOIN products USING(productCode)
WHERE status = "On Hold";

