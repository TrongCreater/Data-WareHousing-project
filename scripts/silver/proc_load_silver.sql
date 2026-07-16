/*
================================================
Stored Procedure: Load Silver Layer {Bronze -> Silver}
================================================
Script Purpose:
    This stored procedure loads data into the 'silver' schema from 'bronze'.
    It performs the following actions:
    - Truncates the silver tables before loading data.
    - Uses the 'INSERT INTO' command to load data from bronze to silver tables.

This stored procedure does not accept any parameters or return values.

Usage Example:
    EXEC silver.load_silver;
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Silver layer';
        PRINT '================================================';
    
        PRINT '------------------------------------------------';
        PRINT 'Loading olist Tables'
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_customers_dataset';
        TRUNCATE TABLE silver.olist_customers_dataset;
        PRINT '>> Inserting data into olist_customers_dataset';
        INSERT INTO silver.olist_customers_dataset
        (
            customer_id,
            customer_unique_id,
            customer_zip_code_prefix,
            customer_city,
            customer_state,
            state_name
        )
        SELECT
            TRIM(customer_id),
            TRIM(customer_unique_id),
            TRIM(customer_zip_code_prefix),
            TRIM(customer_city),
            TRIM(customer_state),
            CASE UPPER(TRIM(customer_state))
                WHEN 'AC' THEN 'Acre'
                WHEN 'AL' THEN 'Alagoas'
                WHEN 'AP' THEN 'Amapa'
                WHEN 'AM' THEN 'Amazonas'
                WHEN 'BA' THEN 'Bahia'
                WHEN 'CE' THEN 'Ceara'
                WHEN 'DF' THEN 'Distrito Federal'
                WHEN 'ES' THEN 'Espirito Santo'
                WHEN 'GO' THEN 'Goias'
                WHEN 'MA' THEN 'Maranhao'
                WHEN 'MT' THEN 'Mato Grosso'
                WHEN 'MS' THEN 'Mato Grosso do Sul'
                WHEN 'MG' THEN 'Minas Gerais'
                WHEN 'PA' THEN 'Para'
                WHEN 'PB' THEN 'Paraiba'
                WHEN 'PR' THEN 'Parana'
                WHEN 'PE' THEN 'Pernambuco'
                WHEN 'PI' THEN 'Piaui'
                WHEN 'RJ' THEN 'Rio de Janeiro'
                WHEN 'RN' THEN 'Rio Grande do Norte'
                WHEN 'RS' THEN 'Rio Grande do Sul'
                WHEN 'RO' THEN 'Rondonia'
                WHEN 'RR' THEN 'Roraima'
                WHEN 'SC' THEN 'Santa Catarina'
                WHEN 'SP' THEN 'Sao Paulo'
                WHEN 'SE' THEN 'Sergipe'
                WHEN 'TO' THEN 'Tocantins'
                ELSE 'Unknown'
            END AS state_name
        FROM bronze.olist_customers_dataset;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------'


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_order_items_dataset';
        TRUNCATE TABLE silver.olist_order_items_dataset;
        PRINT '>> Inserting data into olist_order_items_dataset';
        INSERT INTO silver.olist_order_items_dataset
        (
            order_id,
            order_item_id,
            product_id,
            seller_id,
            shipping_limit_date,
            price,
            freight_value
        )
        SELECT
            TRIM(order_id),
            order_item_id,
            TRIM(product_id),
            TRIM(seller_id),
            shipping_limit_date,
            price,
            freight_value
        FROM bronze.olist_order_items_dataset
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------'



        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_order_payments_dataset';
        TRUNCATE TABLE silver.olist_order_payments_dataset;
        PRINT '>> Inserting data into olist_order_payments_dataset';
        INSERT INTO silver.olist_order_payments_dataset
        (
            order_id,
            payment_sequential,
            payment_type,
            payment_installments,
            payment_value
        )
        SELECT
            TRIM(order_id),
            payment_sequential,
            LOWER(TRIM(payment_type)),
            payment_installments,
            payment_value
        FROM bronze.olist_order_payments_dataset
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------'



        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_order_reviews_dataset';
        TRUNCATE TABLE silver.olist_order_reviews_dataset;
        PRINT '>> Inserting data into olist_order_reviews_dataset';
        INSERT INTO silver.olist_order_reviews_dataset
        (
            review_id,
            order_id,
            review_score,
            review_comment_title,
            review_comment_message,
            review_creation_date
        )
        SELECT
            TRIM(review_id),
            TRIM(order_id),
            review_score,
            NULLIF(
                TRIM(review_comment_title),
                ''
            ) AS review_comment_title,
            NULLIF(
                TRIM(review_comment_message),
                ''
            ) AS review_comment_message,
            review_creation_date
        FROM bronze.olist_order_reviews_dataset
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------'


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_orders_dataset';
        TRUNCATE TABLE silver.olist_orders_dataset;
        PRINT '>> Inserting data into olist_orders_dataset';
        INSERT INTO silver.olist_orders_dataset
        (
            order_id,
            customer_id,
            order_status,
            order_purchase_timestamp,
            order_approved_at,
            order_delivered_carrier_date,
            order_delivered_customer_date,
            order_estimated_delivery_date
        )
        SELECT
            TRIM(order_id),
            TRIM(customer_id),
            LOWER(TRIM(order_status)),
            order_purchase_timestamp,
            order_approved_at,
            order_delivered_carrier_date,
            order_delivered_customer_date,
            order_estimated_delivery_date
        FROM bronze.olist_orders_dataset
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------'


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_product_category_name_translation';
        TRUNCATE TABLE silver.olist_product_category_name_translation;
        PRINT '>> Inserting data into olist_product_category_name_translation';
        INSERT INTO silver.olist_product_category_name_translation
        (
            product_category_name,
            product_category_name_english
        )
        SELECT
            TRIM(product_category_name),
            TRIM(product_category_name_english)
        FROM bronze.olist_product_category_name_translation
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------'


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_products_dataset';
        TRUNCATE TABLE silver.olist_products_dataset;
        PRINT '>> Inserting data into olist_products_dataset';
        INSERT INTO silver.olist_products_dataset
        (
            product_id,
            product_category_name,
            product_name_lenght,
            product_description_lenght,
            product_photos_qty,
            product_weight_g,
            product_length_cm,
            product_height_cm,
            product_width_cm
        )
        SELECT
            TRIM(product_id),
            LOWER(TRIM(product_category_name)),
            product_name_lenght,
            product_description_lenght,
            product_photos_qty,
            product_weight_g,
            product_length_cm,
            product_height_cm,
            product_width_cm
        FROM bronze.olist_products_dataset
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------'



        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_sellers_dataset';
        TRUNCATE TABLE silver.olist_sellers_dataset;
        PRINT '>> Inserting data into olist_sellers_dataset';
        INSERT INTO silver.olist_sellers_dataset
        (
            seller_id,
            seller_zip_code_prefix,
            seller_city,
            seller_state,
            state_name
        )
        SELECT
            TRIM(seller_id),
            seller_zip_code_prefix,
            TRIM(seller_city),
            UPPER(TRIM(seller_state)),
            CASE UPPER(TRIM(seller_state))
                WHEN 'AC' THEN 'Acre'
                WHEN 'AL' THEN 'Alagoas'
                WHEN 'AP' THEN 'Amapa'
                WHEN 'AM' THEN 'Amazonas'
                WHEN 'BA' THEN 'Bahia'
                WHEN 'CE' THEN 'Ceara'
                WHEN 'DF' THEN 'Distrito Federal'
                WHEN 'ES' THEN 'Espirito Santo'
                WHEN 'GO' THEN 'Goias'
                WHEN 'MA' THEN 'Maranhao'
                WHEN 'MT' THEN 'Mato Grosso'
                WHEN 'MS' THEN 'Mato Grosso do Sul'
                WHEN 'MG' THEN 'Minas Gerais'
                WHEN 'PA' THEN 'Para'
                WHEN 'PB' THEN 'Paraiba'
                WHEN 'PR' THEN 'Parana'
                WHEN 'PE' THEN 'Pernambuco'
                WHEN 'PI' THEN 'Piaui'
                WHEN 'RJ' THEN 'Rio de Janeiro'
                WHEN 'RN' THEN 'Rio Grande do Norte'
                WHEN 'RS' THEN 'Rio Grande do Sul'
                WHEN 'RO' THEN 'Rondonia'
                WHEN 'RR' THEN 'Roraima'
                WHEN 'SC' THEN 'Santa Catarina'
                WHEN 'SP' THEN 'Sao Paulo'
                WHEN 'SE' THEN 'Sergipe'
                WHEN 'TO' THEN 'Tocantins'
                ELSE 'Unknown'
            END AS state_name
        FROM bronze.olist_sellers_dataset
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------';

        SET @batch_end_time = GETDATE();
        PRINT '==============='
        PRINT 'Loading Bronze Layer is Completed';
        PRINT ' -Total Load Duration: ' + CAST (DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '==============='
    END TRY
    BEGIN CATCH
        PRINT '======================================'
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '======================================'
    END CATCH
END
