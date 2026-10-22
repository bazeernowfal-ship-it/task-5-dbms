CREATE DATABASE IF NOT EXISTS ecommerce2;
USE ecommerce2;

-- Create Orders table first
CREATE TABLE IF NOT EXISTS Orders (
    Order_ID INT PRIMARY KEY
);

-- Insert sample Orders
INSERT IGNORE INTO Orders (Order_ID) VALUES
(5001),
(5002),
(5003),
(5004),
(5005);

-- Create Payment table
CREATE TABLE IF NOT EXISTS Payment (
    Payment_ID VARCHAR(10) PRIMARY KEY,
    Order_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Mode VARCHAR(30) NOT NULL,
    Payment_Status VARCHAR(20) NOT NULL,
    Transaction_Amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    CHECK (Payment_Mode IN
        ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Cash on Delivery')),

    CHECK (Payment_Status IN
        ('Success', 'Failed', 'Pending')),

    CHECK (Transaction_Amount > 0),

    UNIQUE (Order_ID)
);

-- Insert Payment data
INSERT INTO Payment VALUES
('P101', 5001, '2026-10-01', 'UPI', 'Success', 2500.00),
('P102', 5002, '2026-10-02', 'Credit Card', 'Failed', 4500.00),
('P103', 5003, '2026-10-03', 'Debit Card', 'Success', 3200.00),
('P104', 5004, '2026-10-04', 'Net Banking', 'Pending', 1800.00),
('P105', 5005, '2026-10-05', 'Cash on Delivery', 'Success', 2750.00);

-- Display all payments
SELECT * FROM Payment;

-- Successful payments
SELECT * FROM Payment
WHERE Payment_Status = 'Success';

-- Failed payments
SELECT * FROM Payment
WHERE Payment_Status = 'Failed';

-- Pending payments
SELECT * FROM Payment
WHERE Payment_Status = 'Pending';

-- Payment status report
SELECT Payment_Status, COUNT(*) AS Total_Transactions
FROM Payment
GROUP BY Payment_Status;

-- Update example
UPDATE Payment
SET Payment_Status = 'Success'
WHERE Payment_ID = 'P104';

-- Show updated table
SELECT * FROM Payment;