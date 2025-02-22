-- 1. Who is at the top of the organization (i.e.,  reports to no one)

SELECT lastName, firstName, jobTitle
FROM employees
WHERE reportsTo IS NULL;


-- 2. Who reports to William Patterson?

SELECT *
FROM employees
WHERE reportsTo = (SELECT employeeNumber
					FROM employees
					WHERE CONCAT(firstName, " ", lastName) = "William Patterson");

SELECT e2.employeeNumber, e2.firstName, e2.lastName
FROM employees e1
INNER JOIN employees e2
ON e1.employeeNumber = e2.reportsTo
WHERE CONCAT(e1.firstName, " ", e1.lastName) = "William Patterson";
                    

-- 3. List all the products purchased by Herkku Gifts

SELECT productName
FROM products
INNER JOIN orderdetails USING(productCode)
INNER JOIN orders USING(orderNumber)
WHERE customerNumber = (SELECT customerNumber
						FROM customers
						WHERE customerName = "Herkku Gifts");
                        
SELECT productName
FROM products
INNER JOIN orderdetails USING(productCode)
INNER JOIN orders USING(orderNumber)
INNER JOIN customers USING(customerNumber)
WHERE customerName = "Herkku Gifts";


-- 4. Compute the commission for each sales representative, assuming the commission
--    is 5% of the value of an order. Sort by employee last name and first name.

WITH salesRep AS (
	SELECT customerNumber, salesRepEmployeeNumber, employees.firstName, employees.lastName
	FROM customers
	INNER JOIN employees
	ON salesRepEmployeeNumber = employeeNumber)

SELECT salesRepEmployeeNumber, CONCAT(firstName, " ", lastName) AS Employee_Name, SUM(quantityOrdered*priceEach)*0.05 AS Commission
FROM salesRep
INNER JOIN orders USING(customerNumber)
INNER JOIN orderdetails USING(orderNumber)
GROUP BY salesRepEmployeeNumber
ORDER BY salesRep.lastName, salesRep.firstName;


-- 5. What is the difference in days between 
--    the most recent and oldest order date in the Orders file?

SELECT DATEDIFF(MAX(orderDate), MIN(orderDate)) AS diff_in_days
FROM orders;


-- 6. Compute the average time between order date and ship date
--    for each customer ordered by the largest difference.

SELECT customerName, ROUND(AVG(DATEDIFF(shippedDate,orderDate)),0) AS AvgTimeDiff_inDays
FROM orders
INNER JOIN customers USING(customerNumber)
GROUP BY customerNumber
ORDER BY AvgTimeDiff_inDays DESC;


-- 7. What is the value of orders shipped in August 2004?

SELECT SUM(quantityOrdered*priceEach) AS Value
FROM orders
INNER JOIN orderdetails USING(orderNumber)
WHERE YEAR(orderDate) = 2004 AND MONTH(orderDate) = 08;


-- 8. Compute the total value ordered, total amount paid, and their difference 
--    for each customer for orders placed in 2004 and payments received in 2004 

SELECT customerName, SUM(quantityOrdered*priceEach) AS TotalValueOrdered,
       SUM(amount) AS TotalAmount, SUM(quantityOrdered*priceEach) - SUM(amount) AS Diff
FROM customers
LEFT JOIN orders USING(customerNumber)
INNER JOIN orderdetails USING(orderNumber)
INNER JOIN payments USING(customerNumber)
WHERE YEAR(orderDate) = 2004 AND YEAR(paymentDate) = 2004
GROUP BY customers.customerNumber;


-- 9. List the employees who report to those employees who report to Diane Murphy. 
--    Use the CONCAT function to combine the employee's first name 
--    and last name into a single field for reporting.

SELECT CONCAT(firstName, " ", lastName) AS Full_Name
FROM employees
WHERE reportsTo  = (SELECT employeeNumber
										FROM employees
										WHERE CONCAT(firstName, " ", lastName) = "Diane Murphy");


-- 10. What is the percentage value of each product in inventory sorted by 
--     the highest percentage first (Hint: Create a view first).
                                        
SELECT productName, quantityInStock/(SELECT SUM(quantityInStock) FROM products)*100 AS percent
FROM products
ORDER BY percent DESC;


-- 13. What is the value of payments received in July 2004?

SELECT SUM(amount) AS Value
FROM payments
WHERE YEAR(paymentDate)=2004 AND MONTHNAME(paymentDate)='July';


-- 14. What is the ratio of the value of payments made to orders received for each month of 2004?
--     (i.e., divide the value of payments made by the orders received)?

WITH AmountandOrderByMonth AS(
	SELECT MONTH(orderDate) Month, SUM(amount) Total_Amount, COUNT(DISTINCT orderNumber) AS Total_Orders
	FROM orders
	INNER JOIN payments USING(customerNumber)
	WHERE YEAR(orderDate) = 2004
	GROUP BY Month
)

SELECT MONTH, Total_Amount/Total_Orders AS Ratio
FROM AmountandOrderByMonth;

SELECT COUNT(DISTINCT orderNumber)
FROM orders;

-- 15. What is the difference in the amount received for each month of 2004 compared to 2003?

WITH payment2003  AS (
SELECT MONTH(paymentDate) AS Month, SUM(amount) AS Amount
FROM payments
WHERE YEAR(paymentDate) = 2003
GROUP BY MONTH(paymentDate) 
ORDER BY MONTH(paymentDate)
),
payment2004 AS (SELECT MONTH(paymentDate) AS Month, SUM(amount) AS Amount
FROM payments
WHERE YEAR(paymentDate) = 2004
GROUP BY MONTH(paymentDate)
ORDER BY MONTH(paymentDate)
)

SELECT Month, payment2004.Amount AS payment2004, payment2003.Amount AS payment2003, (payment2004.Amount-payment2003.Amount) AS Difference
FROM payment2003
INNER JOIN payment2004 USING(Month);

-- 18. Basket of goods analysis: A common retail analytics task is to analyze each basket or order to learn what products are often purchased together.
-- Report the names of products that appear in the same order ten or more times.

SELECT *
FROM orderdetails;

-- 20. Compute the profit generated by each customer based on their orders. 
-- Also, show each customer's profit as a percentage of total profit.
--  Sort by profit descending.


-- 28. Find the customers without payments in 2003.

SELECT *
FROM customers
LEFT JOIN payments USING(customerNumber)
LEFT JOIN orders USING(customerNumber);