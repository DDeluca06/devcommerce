-- If the DB exists, remove it, create it and use it.
DROP DATABASE IF EXISTS incentive;
CREATE DATABASE IF NOT EXISTS incentive;
USE incentive;

CREATE TABLE customers(
    customerid INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    regdate DATE,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    address VARCHAR(90) UNIQUE NOT NULL,
    city VARCHAR(58) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip VARCHAR(9) NOT NULL
);

CREATE TABLE products(
    productid INT AUTO_INCREMENT UNIQUE PRIMARY KEY NOT NULL,
    productname VARCHAR(20) UNIQUE NOT NULL,
    productdesc TEXT NOT NULL,
    productprice DECIMAL(7,2) NOT NULL,
    productquantity INT NOT NULL,
    productdate DATE NOT NULL
);

CREATE TABLE orders (
    orderid INT AUTO_INCREMENT PRIMARY KEY,
    customerid INT,
    orderdate DATE NOT NULL DEFAULT CURRENT_DATE,
    orderstatus ENUM('Pending', 'Shipping', 'Delivered', 'Cancelled') NOT NULL,
    ordertotal DECIMAL(7,2),
    FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_product DECIMAL(7, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(orderid) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(productid) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Creating Indexes
CREATE INDEX idx_customer_id ON orders(customerid);
CREATE INDEX idx_order_id ON order_items(order_id);
CREATE INDEX idx_product_id ON order_items(product_id);

# INSERTING DATA
-- Insert data into customers table
INSERT INTO customers (regdate, first_name, last_name, email, phone, address, city, state, zip)
VALUES
('2023-01-15', 'John', 'Doe', 'johndoe@example.com', '1234567890', '123 Main St', 'Springfield', 'IL', '62701'),
('2023-02-20', 'Jane', 'Smith', 'janesmith@example.com', '2345678901', '456 Elm St', 'Chicago', 'IL', '60601'),
('2023-03-10', 'Alice', 'Johnson', 'alicej@example.com', '3456789012', '789 Oak St', 'Peoria', 'IL', '61614'),
('2023-04-05', 'Bob', 'Brown', 'bobbrown@example.com', '4567890123', '321 Pine St', 'Evanston', 'IL', '60201'),
('2023-05-18', 'Eve', 'Davis', 'eved@example.com', '5678901234', '654 Maple St', 'Naperville', 'IL', '60540');

-- Insert data into products table
INSERT INTO products (productname, productdesc, productprice, productquantity, productdate)
VALUES
('Laptop', 'High performance laptop', 999.99, 50, '2023-01-01'),
('Mouse', 'Wireless mouse', 29.99, 150, '2023-02-01'),
('Keyboard', 'Mechanical keyboard', 79.99, 100, '2023-03-01'),
('Monitor', '24-inch monitor', 199.99, 70, '2023-04-01'),
('Chair', 'Ergonomic office chair', 149.99, 80, '2023-05-01');

-- Insert data into orders table
INSERT INTO orders (customerid, orderdate, orderstatus, ordertotal)
VALUES
(1, '2023-06-01', 'Pending', 1299.97),
(2, '2023-06-02', 'Shipping', 229.97),
(3, '2023-06-03', 'Delivered', 979.96),
(4, '2023-06-04', 'Cancelled', 299.98),
(5, '2023-06-05', 'Pending', 499.97);

-- Insert data into order_items table
INSERT INTO order_items (order_id, product_id, quantity, price_per_product)
VALUES
(1, 1, 1, 999.99),
(1, 3, 2, 79.99),
(2, 2, 3, 29.99),
(2, 4, 1, 199.99),
(3, 1, 1, 999.99),
(3, 5, 2, 149.99),
(4, 2, 1, 29.99),
(4, 3, 1, 79.99),
(5, 4, 1, 199.99),
(5, 5, 2, 149.99);
# INSERT COMPLETE

# SELECT AND JOINS
-- Get order details with customer info. Joining Customer & Orders.
SELECT 
    customers.customerid,
    customers.first_name,
    customers.last_name,
    orders.orderid,
    orders.orderdate,
    orders.orderstatus
FROM customers
JOIN orders ON customers.customerid = orders.customerid;

-- Order Line Items
SELECT 
    od.order_detail_id,
    o.orderid,
    o.customerid,
    o.orderdate,
    p.productname,
    od.quantity,
    od.price_per_product,
    (od.quantity * od.price_per_product) AS line_total
FROM order_details AS od
JOIN orders AS o ON od.order_id = o.orderid
JOIN products AS p ON od.product_id = p.productid;


-- Total Revenue
SELECT 
    customers.customerid, 
    customers.first_name, 
    customers.last_name, 
    SUM(order_details.price_per_product * order_details.quantity) AS total_revenue
FROM 
    customers
INNER JOIN 
    orders ON customers.customerid = orders.customerid
INNER JOIN 
    order_items ON orders.orderid = order_items.order_id
GROUP BY 
    customers.customerid, customers.first_name, customers.last_name;

-- Calculation for Total Revenue
SELECT 
    SUM(od.quantity * od.price_per_product) AS total_revenue
FROM order_details AS od;

-- Average Order Value
SELECT 
    AVG(o.ordertotal) AS average_order_value
FROM orders AS o;

-- Number of Orders Per Customer
SELECT 
    o.customerid,
    COUNT(o.orderid) AS number_of_orders
FROM orders AS o
GROUP BY o.customerid;
