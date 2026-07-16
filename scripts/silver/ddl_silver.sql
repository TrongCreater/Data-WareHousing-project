/*
================================================================================
DDL Script: Create silver Tables
================================================================================
Script Purpose:
	This script create tables in the 'silver' schema, dropping existing tables
	if they already exist.
	Run this scripts to re-define the DDL structure of 'silver' Tables
================================================================================
*/

IF OBJECT_ID('silver.olist_order_reviews_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_reviews_dataset;
CREATE TABLE silver.olist_order_reviews_dataset (
	review_id					CHAR(32),
	order_id					CHAR(32),
	review_score				TINYINT,
	review_comment_title		NVARCHAR(255),
	review_comment_message		NVARCHAR(MAX),
	review_creation_date		DATE,
	dwh_create_date				DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.olist_orders_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_orders_dataset;
CREATE TABLE silver.olist_orders_dataset (
	order_id							CHAR(32),
	customer_id							CHAR(32),
	order_status						VARCHAR(20),
	order_purchase_timestamp			DATETIME,
	order_approved_at					DATETIME,
	order_delivered_carrier_date		DATETIME,
	order_delivered_customer_date		DATETIME,
	order_estimated_delivery_date		DATE,
	dwh_create_date				DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.olist_products_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_products_dataset;
CREATE TABLE silver.olist_products_dataset(
	product_id							CHAR(32),
	product_category_name				NVARCHAR(100),
	product_name_lenght					TINYINT,
	product_description_lenght			INT,
	product_photos_qty					TINYINT,
	product_weight_g					INT,
	product_length_cm					TINYINT,
	product_height_cm					TINYINT,
	product_width_cm					TINYINT,
	dwh_create_date				DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.olist_sellers_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_sellers_dataset;
CREATE TABLE silver.olist_sellers_dataset(
	seller_id							CHAR(32),
	seller_zip_code_prefix				VARCHAR(10),
	seller_city							NVARCHAR(100),
	seller_state						CHAR(2),
	state_name							NVARCHAR(100),
	dwh_create_date				DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.olist_product_category_name_translation', 'U') IS NOT NULL
	DROP TABLE silver.olist_product_category_name_translation;
CREATE TABLE silver.olist_product_category_name_translation(
	product_category_name				NVARCHAR(100),
	product_category_name_english		NVARCHAR(100),
	dwh_create_date				DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.olist_customers_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_customers_dataset;
CREATE TABLE silver.olist_customers_dataset(
	customer_id						CHAR(32),
	customer_unique_id				CHAR(32),
	customer_zip_code_prefix		VARCHAR(10),
	customer_city					NVARCHAR(100),
	customer_state					CHAR(2),
	state_name						NVARCHAR(100),
	dwh_create_date				DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.olist_order_items_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_items_dataset;
CREATE TABLE silver.olist_order_items_dataset(
	order_id							CHAR(32),
	order_item_id						CHAR(2),
	product_id							CHAR(32),
	seller_id							CHAR(32),
	shipping_limit_date					DATETIME,
	price								DECIMAL(10,2),
	freight_value						DECIMAL(10,2),
	dwh_create_date				DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.olist_order_payments_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_payments_dataset;
CREATE TABLE silver.olist_order_payments_dataset(
	order_id							CHAR(32),
	payment_sequential					CHAR(2),
	payment_type						VARCHAR(50),
	payment_installments				TINYINT,
	payment_value						DECIMAL(10,2),
	dwh_create_date				DATETIME2 DEFAULT GETDATE()
);
