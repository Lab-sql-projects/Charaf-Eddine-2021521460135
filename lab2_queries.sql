-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Insert sample data into Customers table
INSERT INTO Customers (customer_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert sample data into Orders table
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES
(1, 1, '2025-04-01', 'Shipped'),
(2, 2, '2025-04-02', 'Pending'),
(3, 3, '2025-04-03', 'Cancelled');

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Insert sample data into Products table
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Laptop', 799.99),
(2, 'Smartphone', 599.99),
(3, 'Headphones', 149.99);

-- Create Order_Items table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert sample data into Order_Items table
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1);

-- -----------------------------------
-- 1. INNER JOIN Query:
-- Show customers and their orders
SELECT Customers.name, Orders.order_id, Orders.order_date
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id;

-- -----------------------------------
-- 2. LEFT JOIN Query:
-- Show all customers with their orders (if any)
SELECT Customers.name, Orders.order_id, Orders.order_date
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id;

-- -----------------------------------
-- 3. UPDATE Query:
-- Update the status of order 2 to 'Shipped'
UPDATE Orders
SET status = 'Shipped'
WHERE order_id = 2;

-- -----------------------------------
-- 4. DELETE Query:
-- Delete orders with the status 'Cancelled'
DELETE FROM Orders
WHERE status = 'Cancelled';

-- -----------------------------------
-- 5. Aggregation Query with GROUP BY and HAVING Clause:
-- Calculate total order value for each customer, filter only customers with total value > 100
SELECT Customers.name, SUM(Products.price * Order_Items.quantity) AS total_order_value
FROM Order_Items
INNER JOIN Products ON Order_Items.product_id = Products.product_id
INNER JOIN Orders ON Order_Items.order_id = Orders.order_id
INNER JOIN Customers ON Orders.customer_id = Customers.customer_id
GROUP BY Customers.name
HAVING SUM(Products.price * Order_Items.quantity) > 100;

-- -----------------------------------
-- 6. Subquery in WHERE Clause:
-- Find customers who placed orders with total value greater than 500
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT Orders.customer_id
    FROM Order_Items
    INNER JOIN Products ON Order_Items.product_id = Products.product_id
    INNER JOIN Orders ON Order_Items.order_id = Orders.order_id
    GROUP BY Orders.customer_id
    HAVING SUM(Products.price * Order_Items.quantity) > 500
);
