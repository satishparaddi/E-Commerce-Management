Use ecommerce;
-- Customer Data
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('John Doe', '1234567890', 'john@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('Alice Smith', '9876543210', 'alice@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('Bob Johnson', '5555555555', 'bob@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('Emma Thompson', '7777777777', 'emma@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('Oliver Davis', '3333333333', 'oliver@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('Sophia Wilson', '4444444444', 'sophia@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('William Lee', '6666666666', 'william@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('Ava Garcia', '2222222222', 'ava@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('James Brown', '8888888888', 'james@example.com');
INSERT INTO customer (customer_name, customer_phone, customer_email) VALUES ('Charlotte Martinez', '9999999999', 'charlotte@example.com');

-- Product Catalog
INSERT INTO product_catalog (product_type) VALUES ('Electronics');
INSERT INTO product_catalog (product_type) VALUES ('Clothing');
INSERT INTO product_catalog (product_type) VALUES ('Furniture');
INSERT INTO product_catalog (product_type) VALUES ('Books');
INSERT INTO product_catalog (product_type) VALUES ('Toys');
INSERT INTO product_catalog (product_type) VALUES ('Appliances');
INSERT INTO product_catalog (product_type) VALUES ('Sports Equipment');
INSERT INTO product_catalog (product_type) VALUES ('Jewelry');
INSERT INTO product_catalog (product_type) VALUES ('Beauty Products');
INSERT INTO product_catalog (product_type) VALUES ('Food');


-- Retailer
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Best Electronics', '123 Main St, City', '555-1234');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Fashion Hub', '456 Oak Ave, Town', '555-5678');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Home Essentials', '789 Elm St, Village', '555-9876');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Book Emporium', '101 Pine St, County', '555-4321');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Toy World', '246 Maple Rd, City', '555-8765');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Appliance Depot', '369 Birch St, Town', '555-3456');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Sports Haven', '777 Cedar Ave, Village', '555-6543');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Jewel Palace', '888 Pine Rd, County', '555-7890');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Beauty Emporium', '999 Oak Rd, City', '555-2109');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Fresh Mart', '111 Elm St, Town', '555-1098');
INSERT INTO retailer (retailer_name, retailer_address, retailer_phone_no) VALUES ('Costco', '456 High St, Town', '555-5678');



-- Shipment Address 
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('John Doe', '123 Oak St', 'City1', 'State1', 12345, 1000);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('Alice Smith', '456 Maple Ave', 'City2', 'State2', 23456, 1001);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('Bob Johnson', '789 Elm Rd', 'City3', 'State3', 34567, 1002);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('Emma Thompson', '101 Pine Ln', 'City4', 'State4', 45678, 1003);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('Oliver Davis', '246 Cedar Blvd', 'City5', 'State5', 56789, 1004);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('Sophia Wilson', '369 Birch Ct', 'City6', 'State6', 67890, 1005);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('William Lee', '777 Elm St', 'City7', 'State7', 78901, 1006);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('Ava Garcia', '888 Pine Rd', 'City8', 'State8', 89012, 1007);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('James Brown', '999 Oak Ave', 'City9', 'State9', 90123, 1008);
INSERT INTO [shipment_address] (recepient_name, street, city, [state], postal_code, customer_id) VALUES ('Charlotte Martinez', '111 Main St', 'City10', 'State10', 01234, 1009);


-- Product
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('Lenove IdeaPad', 'Powerful laptop with high-resolution display', 1200.00, 1400);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('Iphone 14', 'Latest smartphone with advanced features', 800.00, 1400);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('Sony Camera', 'High-quality camera for professional photography', 500.00, 1400);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('H&M relaxed fit shirt', 'Comfortable and stylish shirt for men', 35.99, 1401);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('Summer Wear Pyjamas', 'Light and elegant dress perfect for summer', 49.99, 1401);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('Modern Sectional Sofa', 'Spacious and comfortable sectional sofa', 899.99, 1402);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('Wooden Dining Table Set', 'Elegant wooden dining table with chairs', 699.99, 1402);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('The Great Gatsby', 'Classic novel by F. Scott Fitzgerald', 12.99, 1403);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('The Power of Habit', 'Book on habit formation and productivity', 15.99, 1403);
INSERT INTO product (product_name, product_description, product_selling_price, product_catalog_id) VALUES ('Organic Pasta', 'High-quality organic pasta made from durum wheat', 5.99, 1409);


-- Stock
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (18, 1150.00, 1500, 1600);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (24, 690.00, 1501, 1600);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (10, 490.00, 1502, 1600);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (30, 1100.00, 1500, 1610);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (48, 450.00, 1502, 1610);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (20, 475.99, 1502, 1605);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (8, 30.99, 1503, 1601);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (15, 42.99, 1504, 1601);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (30, 39.99, 1504, 1610);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (12, 832.99, 1505, 1602);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (15, 670.39, 1506, 1602);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (23, 10, 1507, 1603);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (12, 14.59, 1508, 1603);
INSERT INTO stock (quantity, price, product_id, retailer_id) VALUES (27, 3.59, 1509, 1609);


-- Order
Exec CreateOrder 1000
Exec CreateOrder 1000
Exec CreateOrder 1000
Exec CreateOrder 1003
Exec CreateOrder 1005
Exec CreateOrder 1008
Exec CreateOrder 1003
Exec CreateOrder 1002
Exec CreateOrder 1008
Exec CreateOrder 1004


-- Order Item
insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1700, 1200);
insert into order_item(order_item_quantity, stock_id, order_id) values (2, 1711, 1200);


insert into order_item(order_item_quantity, stock_id, order_id) values (3, 1706, 1201);

insert into order_item(order_item_quantity, stock_id, order_id) values (2, 1704, 1202);
insert into order_item(order_item_quantity, stock_id, order_id) values (4, 1708, 1202);
insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1703, 1202);

insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1709, 1203);
insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1710, 1203);

insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1700, 1204);

insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1701, 1205);

insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1703, 1206);

insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1700, 1207);
insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1701, 1207);
insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1702, 1207);
insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1710, 1207);

insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1700, 1208);
insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1701, 1208);

insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1712, 1209);
insert into order_item(order_item_quantity, stock_id, order_id) values (1, 1713, 1209);
insert into order_item(order_item_quantity, stock_id, order_id) values (6, 1706, 1209);

select * from stock;

--Shipment
EXEC CreateShipmentForOrder 1200, 1300
EXEC CreateShipmentForOrder 1201, 1300
EXEC CreateShipmentForOrder 1202, 1300
EXEC CreateShipmentForOrder 1203, 1303
EXEC CreateShipmentForOrder 1204, 1305
EXEC CreateShipmentForOrder 1205, 1308
EXEC CreateShipmentForOrder 1206, 1303
EXEC CreateShipmentForOrder 1207, 1302
EXEC CreateShipmentForOrder 1208, 1308
EXEC CreateShipmentForOrder 1209, 1304



-- Return Request
EXEC InitiateAReturnRequest 1807, 'Changed my mind'
EXEC InitiateAReturnRequest 1808, 'Got better deal'
EXEC InitiateAReturnRequest 1809, 'Changed my mind'
EXEC InitiateAReturnRequest 1810, 'Received wrong item'
EXEC InitiateAReturnRequest 1811, 'Changed my mind'
EXEC InitiateAReturnRequest 1812, 'Changed my mind'
EXEC InitiateAReturnRequest 1813, 'Got good deal outside'
EXEC InitiateAReturnRequest 1814, 'Changed my mind'
EXEC InitiateAReturnRequest 1815, 'Received defective item'
EXEC InitiateAReturnRequest 1816, 'Changed my mind'


-- Review
INSERT INTO review (review_description, review_rating, customer_id, product_id)
VALUES ('Great product, highly recommended!', 5, 1000, 1501),
       ('Average quality, needs improvement', 3, 1000, 1503),
       ('Excellent service and fast delivery', 4, 1003, 1502),
       ('The product met my expectations', 4, 1004, 1504),
       ('Disappointed with the product performance', 2, 1005, 1502),
       ('Best purchase I made this year!', 5, 1006, 1506),
       ('Customer service was helpful', 4, 1007, 1500),
       ('Not worth the price, better alternatives available', 2, 1008, 1505),
       ('Highly dissatisfied, returning the item', 1, 1009, 1502),
       ('Decent product for the price', 3, 1010, 1500);


-- Inquiry
EXEC InitiateAnInquiryRequest 1000, 'Product availability'
EXEC InitiateAnInquiryRequest 1002, 'Shipping query'
EXEC InitiateAnInquiryRequest 1009, 'Product specifications'
EXEC InitiateAnInquiryRequest 1003, 'Order status update'
EXEC InitiateAnInquiryRequest 1005, 'Payment method clarification'
EXEC InitiateAnInquiryRequest 1005, 'Return policy information'
EXEC InitiateAnInquiryRequest 1007, 'Complaint regarding service'
EXEC InitiateAnInquiryRequest 1008, 'Product warranty details'
EXEC InitiateAnInquiryRequest 1002, 'Cancellation process'
EXEC InitiateAnInquiryRequest 1000, 'Refund status'
