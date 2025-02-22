-- 1. Find products containing the name 'Ford'.

SELECT productName
FROM products
WHERE productName REGEXP('Ford');


-- 2. List products ending in 'ship'.

SELECT productName
FROM products
WHERE productName REGEXP('ship$');


-- 3. Report the number of customers in Denmark, Norway, and Sweden.

SELECT country, COUNT(*) AS 'No. of Customers'
FROM customers
WHERE country IN ('Denmark','Norway','Sweden')
GROUP BY country;


-- 4. What are the products with a product code in the range S700_1000 to S700_1499?

SELECT productCode, productName
FROM products
WHERE LEFT(productCode,4) LIKE 'S700' AND (RIGHT(productCode,4) BETWEEN 1000 AND 1499)
ORDER BY productCode;


-- 5. Which customers have a digit in their name?

SELECT customerName
FROM customers
WHERE REGEXP_LIKE(customerName,'\\d');


-- 6. List the names of employees called Dianne or Diane

SELECT CONCAT(lastName, ' ', firstName) AS Name
FROM employees	
WHERE firstName REGEXP 'Dianne|Diane' OR lastName REGEXP 'Dianne|Diane';


-- 7.  List the products containing ship or boat in their product name.

SELECT productName
FROM products
WHERE productName REGEXP 'ship|boat';


-- 8. List the products with a product code beginning with S700.

SELECT productCode
FROM products
WHERE productCode REGEXP '^S700';


-- 9. List the names of employees called Larry or Barry

SELECT CONCAT(lastName, ' ', firstName) AS Name
FROM employees
WHERE firstName REGEXP 'Larry|Barry' OR lastName REGEXP 'Larry|Barry';


-- 10. List the names of employees with non-alphabetic characters in their names.

SELECT CONCAT(lastName, ' ', firstName) AS Name
FROM employees
WHERE CONCAT(lastName, ' ', firstName) NOT REGEXP '[a-z]|[A-Z]';


-- 11. List the vendors whose name ends in Diecast

SELECT productVendor
FROM products
WHERE productVendor REGEXP 'Diecast$';