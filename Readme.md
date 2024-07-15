# E-Commerce Database Project

## Overview

This project involves the design and implementation of an E-commerce database. The database schema is designed to handle various aspects of an e-commerce platform, including customer inquiries, orders, shipments, reviews, products, stock management, and return requests. The Entity-Relationship Diagram (ERD) is provided to illustrate the structure and relationships within the database.

## ERD (Entity-Relationship Diagram)

![ERD](https://github.com/satishparaddi/E-Commerce-Management/blob/main/DMDD_P3_Final_ERD.jpg)

## Database Entities and Relationships

### Entities

1. **Customer**
   - `CustomerId` (PK)
   - `CustomerName`
   - `CustomerPhoneNumber`
   - `CustomerEmail`

2. **Inquiry**
   - `InquiryId` (PK)
   - `InquiryReason`
   - `InquiryDate`
   - `InquiryStatus`
   - `CustomerId` (FK)

3. **Order**
   - `OrderId` (PK)
   - `OrderDate`
   - `OrderTotalPrice`
   - `CustomerId` (FK)

4. **OrderItem**
   - `OrderItemId` (PK)
   - `OrderItemQuantity`
   - `OrderItemTotalPrice`
   - `OrderId` (FK)
   - `StockId` (FK)

5. **Shipment**
   - `ShipmentId` (PK)
   - `ShipmentDate`
   - `ShipmentStatus`
   - `TrackingNumber`
   - `PriceOfShipment`
   - `ShipmentAddressId` (FK)
   - `OrderId` (FK)

6. **ShipmentAddress**
   - `ShipmentAddressId` (PK)
   - `RecipientName`
   - `Address` (Street, City, State, PostalCode)
   - `CustomerId` (FK)

7. **Review**
   - `ReviewId` (PK)
   - `ReviewDescription`
   - `ReviewRating`
   - `CustomerId` (FK)
   - `ProductId` (FK)

8. **ReturnRequest**
   - `ReturnRequestId` (PK)
   - `ReturnRequestDate`
   - `ReturnRequestReason`
   - `OrderItemId` (FK)

9. **Product**
   - `ProductId` (PK)
   - `ProductName`
   - `ProductDescription`
   - `ProductSellingPrice`
   - `ProductCatalogId` (FK)

10. **ProductCatalog**
    - `ProductCatalogId` (PK)
    - `ProductType`

11. **Stock**
    - `StockId` (PK)
    - `Quantity`
    - `Price`
    - `ProductId` (FK)
    - `RetailerId` (FK)

12. **Retailer**
    - `RetailerId` (PK)
    - `RetailerName`
    - `RetailerAddress`
    - `RetailerPhoneNumber`

### Relationships

- A **Customer** can make multiple **Inquiries** and place multiple **Orders**.
- An **Order** consists of multiple **OrderItems**.
- An **OrderItem** is associated with a **Stock** item.
- A **Shipment** is linked to an **Order** and a **ShipmentAddress**.
- A **Customer** provides **Reviews** for **Products**.
- **Products** belong to a **ProductCatalog** and are tracked in **Stock**.
- **Stock** items are maintained by **Retailers**.
- **ReturnRequests** are created for **OrderItems**.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/e-commerce-database.git
   cd e-commerce-database
