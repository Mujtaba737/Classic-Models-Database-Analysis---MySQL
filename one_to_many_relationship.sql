-- 1. Report the account representative for each customer.

SELECT c.customerName, CONCAT(e.firstName, ' ', e.lastName) AS Representative
FROM customers AS c
LEFT JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber;


-- 2. Report total payments for Atelier graphique.
SELECT customerName, SUM(amount) AS Total_Payment
FROM customers
INNER JOIN payments
USING(customerNumber)
WHERE customerName = 'Atelier graphique';


-- 3. Report the total payments by date

SELECT paymentDate, SUM(amount) AS Amount
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate;


-- 4. Report the products that have not been sold.

SELECT productName
FROM products
LEFT JOIN orderdetails
USING(productCode)
WHERE orderNumber IS NULL;


-- 5. List the amount paid by each customer.

SELECT customerName, SUM(amount) AS Total
FROM customers
LEFT JOIN payments 
USING(customerNumber)
GROUP BY customerNumber;


-- 6. How many orders have been placed by Herkku Gifts?

SELECT customerName, COUNT(orderNumber) AS Orders
FROM customers
INNER JOIN orders
USING(customerNumber)
WHERE customerName = 'Herkku Gifts';


-- 7. Who are the employees in Boston?

SELECT CONCAT(firstName, ' ', lastName) as Full_Name
FROM employees
INNER JOIN offices
USING(officeCode)
WHERE city = 'Boston';


-- 8. Report those payments greater than $100,000. Sort the report so the customer who made the highest payment appears first.

SELECT customerName, amount
FROM payments
INNER JOIN customers
USING(customerNumber)
WHERE amount > 100000
ORDER BY amount DESC;


-- 9. List the value of 'On Hold' orders.

SELECT SUM(quantityOrdered*priceEach) AS Value
FROM orders
INNER JOIN orderdetails
USING(orderNumber)
WHERE status = 'On Hold';


-- 10. Report the number of orders 'On Hold' for each customer.

SELECT c.customerName, COUNT(status) AS 'On Hold Orders'
FROM customers AS c
INNER JOIN orders
USING(customerNumber)
WHERE status = 'On Hold'
GROUP BY customerName;