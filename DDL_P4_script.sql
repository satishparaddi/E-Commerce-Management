Create database ecommerce;
Use ecommerce;

-- Tables
CREATE TABLE customer (
    customer_id INT PRIMARY KEY IDENTITY(1000,1),
    customer_name VARCHAR(100),
	customer_phone VARCHAR(15),
	customer_email VARCHAR(255)
);

CREATE TABLE inquiry (
    inquiry_id INT PRIMARY KEY IDENTITY(1100,1),
    inquiry_reason VARCHAR(255),
	inquiry_date DATE,
	inquiry_status VARCHAR(100) DEFAULT 'Open',
	customer_id INT,
	CONSTRAINT InquiryStatusConstraint CHECK (inquiry_status IN ('Open', 'Resolved')),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE [order] (
    order_id INT PRIMARY KEY IDENTITY(1200,1),
    order_date DATE,
	order_total_price DECIMAL(10,2),
	customer_id INT,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE [shipment_address] (
    shipment_address_id INT PRIMARY KEY IDENTITY(1300,1),
    recepient_name VARCHAR(100),
	street VARCHAR(255),
	city VARCHAR(100),
	[state]  VARCHAR(100),
	postal_code INT,
	customer_id INT,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE product_catalog(
    product_catalog_id INT PRIMARY KEY IDENTITY(1400,1),
    product_type VARCHAR(255)
);

CREATE TABLE product(
product_id INT PRIMARY KEY IDENTITY(1500,1),
product_name VARCHAR(255),
product_description VARCHAR(255),
product_selling_price DECIMAL(10,2),
product_catalog_id INT
FOREIGN KEY (product_catalog_id) REFERENCES product_catalog(product_catalog_id)
);

CREATE TABLE retailer(
retailer_id INT PRIMARY KEY IDENTITY(1600,1),
retailer_name VARCHAR(150),
retailer_address VARCHAR(255),
retailer_phone_no VARCHAR(15)
);

CREATE TABLE stock(
stock_id INT PRIMARY KEY IDENTITY(1700,1),
quantity INT,
price DECIMAL(10,2),
product_id INT,
retailer_id INT
FOREIGN KEY (product_id) REFERENCES product(product_id),
FOREIGN KEY (retailer_id) REFERENCES retailer(retailer_id)
);

CREATE TABLE order_item(
order_item_id INT PRIMARY KEY IDENTITY(1800,1),
order_item_quantity INT,
order_item_totalprice DECIMAL(10,2),
order_id INT,
stock_id INT,
CONSTRAINT CHK_PositiveQuantity CHECK (order_item_quantity > 0),
FOREIGN KEY (order_id) REFERENCES [order](order_id),
FOREIGN KEY (stock_id) REFERENCES stock(stock_id)
);

CREATE TABLE return_request(
return_request_id INT PRIMARY KEY IDENTITY(1900,1),
return_req_date DATE,
return_req_status VARCHAR(100) DEFAULT 'Raised',
return_req_reason VARCHAR(255),
order_item_id INT UNIQUE,
CONSTRAINT StatusConstraint_1 CHECK (return_req_status IN ('Raised', 'Processed')),
FOREIGN KEY (order_item_id) REFERENCES [order_item](order_item_id)
);

CREATE TABLE shipment(
shipment_id INT PRIMARY KEY IDENTITY(2000,1),
shipment_date DATE,
shipment_status VARCHAR(100) DEFAULT 'Shipped',
tracking_number VARCHAR(50),
price_of_shipment DECIMAL(10,2),
shipment_address_id INT,
order_id INT UNIQUE,
CONSTRAINT StatusConstraint CHECK (shipment_status IN ('Shipped', 'In Transit', 'Delivered')),
CONSTRAINT CheckDate CHECK (shipment_date > GETDATE()),
FOREIGN KEY (order_id) REFERENCES [order](order_id),
FOREIGN KEY (shipment_address_id) REFERENCES [shipment_address](shipment_address_id)
);

CREATE TABLE review(
review_id INT PRIMARY KEY IDENTITY(2100,1),
review_description VARCHAR(255),
review_rating TINYINT,
customer_id INT,
product_id INT,
CONSTRAINT CheckRating Check (review_rating >= 1 AND review_rating <=5),
FOREIGN KEY (customer_id) REFERENCES [customer](customer_id),
FOREIGN KEY (product_id) REFERENCES [product](product_id)
);

CREATE TABLE returned_order_item(
order_item_id INT PRIMARY KEY,
order_item_quantity INT,
order_item_totalprice DECIMAL(10,2),
order_id INT,
stock_id INT,
FOREIGN KEY (order_id) REFERENCES [order](order_id),
FOREIGN KEY (stock_id) REFERENCES stock(stock_id));



-- Non-clustered indexes

CREATE NONCLUSTERED INDEX IX_OrderId
ON [order] (order_id);


CREATE NONCLUSTERED INDEX IX_StockId
ON [stock] (stock_id)

CREATE NONCLUSTERED INDEX IX_ProductId
ON [product] (product_id)



-- Column Data Encryption

ALTER TABLE customer
ADD email_enc VARBINARY(MAX);
select * from customer

ALTER TABLE customer
ADD phone_enc VARBINARY(MAX);
select * from customer

UPDATE customer
SET phone_enc = ENCRYPTBYPASSPHRASE('Pass', customer_phone);

UPDATE customer
SET email_enc = ENCRYPTBYPASSPHRASE('Pass', customer_email);



-- User Defined Functions

/** Calcuates the order item total price using the selling price of the product and quantity ordered*/
CREATE FUNCTION CalculateOrderItemTotalPrice 
(
	@order_quantity int,
	@stock_id int
) 
RETURNS DECIMAL(10,2)
AS
BEGIN
	DECLARE @price DECIMAL(10,2)

	SELECT @price = product_selling_price FROM product WHERE product_id = (SELECT product_id FROM stock WHERE stock_id = @stock_id)

	RETURN @order_quantity * @price
END


/** Gives the shipment price*/
CREATE FUNCTION CalculateShipmentPrice
(
	@price DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @shipment_price DECIMAL(10,2);

    IF @price <= 50
        SET @shipment_price = 5.00
    ELSE IF @price <= 100
        SET @shipment_price = 7.50
    ELSE
        SET @shipment_price = 10.00

    RETURN @shipment_price;
END



-- Procedures

/** Order created by a customer */
CREATE PROCEDURE CreateOrder @customer_id int
AS
BEGIN
	INSERT INTO [order](order_date, order_total_price, customer_id)
	VALUES (GETDATE(), 0, @customer_id)
END


/** Based on the ordered quantity, quantity available in stock is updated along with total price updates on both order and order item*/
CREATE PROCEDURE UpdateStockAndTotalPriceOfOrder @available_item_quantity_in_stock int, @order_item_quantity TINYINT, 
											     @order_item_id int,  @stock_id int, @order_id int
AS
BEGIN
	DECLARE @order_item_total_price DECIMAL(10,2)

	-- Updating the availability count of the stock
	UPDATE stock SET quantity = @available_item_quantity_in_stock - @order_item_quantity WHERE stock_id = @stock_id

	-- Calculating the order item's total price based on the quantity ordered
	SET @order_item_total_price = dbo.CalculateOrderItemTotalPrice(@order_item_quantity, @stock_id)
	
	-- Updating the order item's total price
	UPDATE order_item SET order_item_totalprice = @order_item_total_price WHERE order_item_id = @order_item_id

	-- Updating the order's total price
	UPDATE [order] SET order_total_price = order_total_price + @order_item_total_price where order_id = @order_id

END


/** Creates a Shipment for the Order by the Retailer*/
CREATE PROCEDURE CreateShipmentForOrder @order_id int, @shipment_address_id int
AS
BEGIN
	DECLARE @total_price DECIMAL(10,2)

	SELECT @total_price = order_total_price FROM [order] where order_id = @order_id
	INSERT INTO shipment(shipment_date, price_of_shipment, shipment_address_id, order_id) 
	values (GETDATE() + 5, dbo.CalculateShipmentPrice(@total_price), @shipment_address_id, @order_id)
END



/** Shows the Delivery status of a shipment */
CREATE PROCEDURE GetShipmentDeliveryStatus @order_id int, @status varchar(100) OUTPUT
AS
BEGIN
	SELECT @status = CASE 
						WHEN shipment_status <> 'Delivered' AND shipment_date < CONVERT(DATE, GETDATE()) THEN 'Sorry for the delay. We are investigating on the cause for the delay'
						WHEN shipment_status = 'Shipped' OR shipment_status = 'In transit' THEN 'Your order will be delivered on ' + CAST(shipment_date AS VARCHAR(20))
						WHEN shipment_status = 'Delivered' THEN 'Your Order has been delivered'
					 END
	from shipment WHERE order_id = @order_id
END


/** Initiate a Return request for an order_item */
CREATE PROCEDURE InitiateAReturnRequest @order_item_id INT, @reason VARCHAR(500) 
AS
BEGIN
	Insert INTO return_request(return_req_date, return_req_reason, order_item_id) 
	values (GETDATE(), @reason, @order_item_id) 
END


/** Processes the returns request, and updates the quantity in stock 
	Does nothing, if request is already processed*/
CREATE PROCEDURE ProcessReturnAndUpdateStock
    @return_request_id INT
AS
BEGIN
    DECLARE @stock_id INT, 
            @quantity_to_add INT,
			@status VARCHAR(50);

	SELECT @status = return_req_status FROM return_request where return_request_id = @return_request_id;

	IF @status <> 'Processed'
	BEGIN
		-- Get the stock_id and quantity to add from the return request
		SELECT @stock_id = o.stock_id, @quantity_to_add = o.order_item_quantity
		FROM return_request r
		JOIN order_item o ON r.order_item_id = o.order_item_id
		WHERE r.return_request_id = @return_request_id;

		-- Update the stock quantity
		UPDATE stock 
		SET quantity = quantity + @quantity_to_add
		WHERE stock_id = @stock_id;

		-- Process the return request (you might update the status or perform other actions)
		UPDATE return_request
		SET return_req_status = 'Processed'
		WHERE return_request_id = @return_request_id;
	END
	ELSE 
	BEGIN
		PRINT 'Return Request is already Processed'
	END
END;


/** Initiate An Inquiry */
CREATE PROCEDURE InitiateAnInquiryRequest @customer_id int, @reason varchar(500)
AS
BEGIN
	INSERT INTO inquiry (inquiry_reason, inquiry_date, customer_id) values (@reason, GETDATE(), @customer_id)
END


/** Check Stock availability at particular retailer for a particular product */
CREATE PROCEDURE CheckStockAvailibility @retailer_id int, @product_id int, @available_quantity int OUTPUT
AS
BEGIN
	SELECT @available_quantity = quantity from stock WHERE retailer_id = @retailer_id AND product_id = @product_id
END


/**Updates the inventory quantity*/
CREATE PROCEDURE AddStockQuantity @retailer_id INT, @product_id INT, @quantity INT, @status VARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE @stock_id INT

	SELECT @stock_id = stock_id FROM stock WHERE retailer_id = @retailer_id AND product_id = @product_id
    IF @stock_id IS NOT NULL
    BEGIN
        -- Update the stock quantity for the product by the retailer
		IF @quantity > 0
		BEGIN
			UPDATE stock
			SET quantity = quantity + @quantity
			WHERE stock_id = @stock_id

			SET @status = 'Stock quantity updated successfully'
		END
		ELSE
		BEGIN
			SET @status = 'Quantity should be greater than zero'
		END
    END
    ELSE
    BEGIN
        SET @status = 'Inputted Retailer Id and Product Id combinataion does not exist in the Stock'
    END
END;


/** Adds a product to the inventory along with the details like retailer, price, quantity*/
CREATE PROCEDURE AddProducToStock @retailer_id INT, @product_id INT, @price DECIMAL(10,2), @quantity INT
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM stock WHERE retailer_id = @retailer_id AND product_id = @product_id)
	BEGIN
		INSERT INTO stock(quantity, price, retailer_id, product_id) VALUES (@quantity, @price, @retailer_id, @product_id)
		PRINT 'Product added to Stock'
	END
	ELSE
	BEGIN
		PRINT 'ProductId and RetailerId combination already exists'
	END
END




-- Triggers
/** Triggered right after an order item is inserted. It check the stock availability and updates the order item and order accordingly 
	1) If ordered quantity is less than stock, updates the order item price
	2) If ordered quantity is more than stock, ordered quanity is adjusted and order item price is updated
	3) If stock is empty, inserted row is deleted with an error message thrown
*/
CREATE TRIGGER CheckStockAvailabilityBeforeOrderingAndUpdatePricing
ON order_item
AFTER INSERT
AS
BEGIN
    DECLARE @order_item_quantity INT
	DECLARE @order_item_id INT
	DECLARE @order_id INT
	DECLARE @stock_id INT
	DECLARE @available_item_quantity_in_stock INT
	DECLARE @shipment_id INT


	-- Get the required column values from the inserted row
    SELECT @order_item_id = order_item_id, @order_item_quantity = order_item_quantity, @order_id = order_id, @stock_id = stock_id FROM inserted

	SELECT @shipment_id = shipment_id FROM shipment WHERE order_id = @order_id;

	IF @shipment_id IS NOT NULL
	BEGIN
		RAISERROR ('Order Item can not be added, as a shipment is already created', 16, 1)
		PRINT 'Shipment ID: ' + CAST(@shipment_id AS VARCHAR(10)); 
		ROLLBACK TRANSACTION 
	END

	-- Get the actual available stock of the product
	SELECT @available_item_quantity_in_stock = quantity FROM stock WHERE stock_id = @stock_id

	-- Check is stock is available
	IF @available_item_quantity_in_stock > 0 
	BEGIN
		IF @order_item_quantity <= @available_item_quantity_in_stock
		BEGIN
			PRINT 'Order item has been added'

			EXEC UpdateStockAndTotalPriceOfOrder @available_item_quantity_in_stock = @available_item_quantity_in_stock, 
											     @order_item_quantity = @order_item_quantity,
												 @order_item_id = @order_item_id,  @stock_id = @stock_id, @order_id = @order_id
		END
		ELSE IF @order_item_quantity > @available_item_quantity_in_stock
		BEGIN
			PRINT 'Quantity of Order item has be updated as per the stock availability'

			UPDATE order_item SET order_item_quantity = @available_item_quantity_in_stock where order_item_id = @order_item_id;
			
			SET @order_item_quantity = @available_item_quantity_in_stock 

			EXEC UpdateStockAndTotalPriceOfOrder @available_item_quantity_in_stock = @available_item_quantity_in_stock, 
												 @order_item_quantity = @order_item_quantity,
												 @order_item_id = @order_item_id,  @stock_id = @stock_id, @order_id = @order_id

		END
	END
	ELSE
	BEGIN
		RAISERROR ('Stock is empty, hence dropping your order item', 16, 1)
		ROLLBACK TRANSACTION
	END

END



/** Genereates tracking number for the shipment */
CREATE TRIGGER GenerateTrackingNumber
ON shipment
AFTER INSERT
AS
BEGIN
    UPDATE s
    SET s.tracking_number = CONCAT('TN', FORMAT(s.shipment_id, '000000')) -- Example: TN000001, TN000002, ...
    FROM inserted i
    JOIN shipment s ON i.shipment_id = s.shipment_id;
END;



/**Triggered once the return request is processed which add the returned order item details to returned_order_item table
   and updates the order price*/
CREATE TRIGGER ProcessedReturnedTrigger
ON return_request
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(return_req_status)
    BEGIN
        DECLARE @order_item_id INT, @order_item_quantity INT, @order_item_total_price DECIMAL(10,2), @order_id INT, @stock_id INT;

        SELECT @order_item_id = i.order_item_id,
               @order_item_quantity = oi.order_item_quantity,
               @order_item_total_price = oi.order_item_totalprice,
               @order_id = oi.order_id,
               @stock_id = oi.stock_id
        FROM inserted i
        INNER JOIN deleted d ON i.return_request_id = d.return_request_id
        INNER JOIN order_item oi ON i.order_item_id = oi.order_item_id
        WHERE i.return_req_status = 'Processed';


        IF (@order_item_id IS NOT NULL)
        BEGIN
            -- Insert the processed order item into the returned_order_item table
            INSERT INTO returned_order_item (order_item_id, order_item_quantity, order_item_totalprice, order_id, stock_id)
            VALUES (@order_item_id, @order_item_quantity, @order_item_total_price, @order_id, @stock_id);

			-- Reduce the total price of the related order
            UPDATE [order] SET order_total_price = order_total_price - @order_item_total_price
            WHERE order_id = @order_id;

        END;
    END;
END;


/** Checks whether the price of the stock inserted or updated is not greater than the selling price of the product */
CREATE TRIGGER CheckStockPrice
ON stock
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT i.stock_id
        FROM inserted i
        INNER JOIN product p ON i.product_id = p.product_id
        WHERE i.price > p.product_selling_price
    )
    BEGIN
        RAISERROR('Stock price cannot be greater than the selling price of the product.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;



-- Views
CREATE VIEW CustomerTotalOrdersSummary AS
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_total_price) AS total_order_price
FROM
    customer c
JOIN
    [order] o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.customer_name, c.customer_phone, c.customer_email;



CREATE VIEW CustomerOrderSummary AS
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, p.product_name, pc.product_type, p.product_selling_price, oi.order_item_quantity, sh.shipment_date, sh.shipment_status
FROM 
customer c
JOIN [order] o ON c.customer_id = o.customer_id
JOIN shipment sh ON o.order_id = sh.order_id
JOIN order_item oi ON o.order_id = oi.order_id
JOIN stock s ON oi.stock_id = s.stock_id
JOIN product p ON p.product_id = s.product_id
JOIN product_catalog pc ON p.product_catalog_id = pc.product_catalog_id



CREATE VIEW StockSummary AS
SELECT
    r.retailer_id,
    r.retailer_name,
    r.retailer_address,
    s.quantity,
    p.product_id,
    p.product_name
FROM
    retailer r
JOIN
    stock s ON r.retailer_id = s.retailer_id
JOIN
    product p ON s.product_id = p.product_id;


CREATE VIEW product_order_count AS
SELECT
    p.product_id,
    p.product_name,
    COUNT(oi.order_id) AS order_count
FROM
    product p
LEFT JOIN
    stock s ON p.product_id = s.product_id
LEFT JOIN
    order_item oi ON s.stock_id = oi.stock_id
GROUP BY
    p.product_id, p.product_name;



CREATE VIEW product_profit_percentage AS
SELECT
    p.product_id,
    p.product_name,
    s.price AS retailer_price,
    p.product_selling_price,
    CONVERT(DECIMAL(10, 2), (p.product_selling_price - s.price) / s.price * 100) AS profit_percentage
FROM
    product p
JOIN
    stock s ON p.product_id = s.product_id
JOIN
	retailer r ON r.retailer_id = s.retailer_id;


