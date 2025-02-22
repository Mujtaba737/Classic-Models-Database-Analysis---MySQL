-- 1. Prepare a list of offices sorted by country, state, city.

SELECT country, state, city, officeCode
FROM offices
ORDER BY country, state, city;


-- 2. How many employees are there in the company?

SELECT COUNT(*) AS count_of_employees
FROM employees;


-- 3. What is the total of payments received?

SELECT SUM(amount) AS total_of_payments
FROM payments;


-- 4. List the product lines that contain 'Cars'.

SELECT * 
FROM productlines
WHERE productLine LIKE '%Cars%';


-- 5.  Report total payments for October 28, 2004.

SELECT SUM(amount) AS total_payment
FROM payments
WHERE paymentDate = '2004-10-28';


-- 6. Report those payments greater than $100,000.

SELECT *
FROM payments
WHERE amount > 100000;


-- 7. List the products in each product line.

SELECT productLine,productName
FROM products
ORDER BY productLine;


-- 8. How many products in each product line?

SELECT productLine, COUNT(productName) AS count_of_products
FROM products
GROUP BY productLine;


-- 9. What is the minimum payment received?

SELECT MIN(amount) AS minimum_payment
FROM payments;


-- 10. List all payments greater than twice the average payment.

SELECT *
FROM payments
WHERE amount > (SELECT 2*AVG(amount) FROM payments);


-- 11. What is the average percentage markup of the MSRP on buyPrice?

SELECT AVG((MSRP-buyPrice)/MSRP)*100 AS 'Average Percentage Markup'
FROM products;


-- 12. How many distinct products does ClassicModels sell?

SELECT COUNT(DISTINCT(productName)) AS distinct_products
FROM products;


-- 13. Report the name and city of customers who don't have sales representatives?

SELECT customerName, city
FROM customers
WHERE salesRepEmployeeNumber IS NULL;


-- 14. What are the names of executives with VP or Manager in their title? 
-- Use the CONCAT function to combine the employee's first name and 
-- last name into a single field for reporting.

SELECT CONCAT(firstName, ' ', lastName) AS FullName, jobTitle
FROM employees
WHERE (jobTitle LIKE '%VP%') OR (jobTitle LIKE '%Manager%');


-- 15. Which orders have a value greater than $5,000?

SELECT orderNumber, SUM(quantityOrdered*priceEach) AS TotalOrderValue
FROM orderdetails
GROUP BY orderNumber
HAVING SUM(quantityOrdered*priceEach) > 5000;