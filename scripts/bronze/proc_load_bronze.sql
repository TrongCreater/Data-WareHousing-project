/*
================================================
Stored Procedure: Load Bronze Layer {Source -> Bronze}
================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the 'BULK INSERT' command to load data from csv to bronze tables.

This stored procedure does not accept any parameters or return values.

Usage Example:
    EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Bronze layer';
        PRINT '================================================';
    
        PRINT '------------------------------------------------';
        PRINT 'Loading olist Tables'
        PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_customers_dataset';
        TRUNCATE TABLE bronze.olist_customers_dataset;
        PRINT '>> Inserting data into olist_customers_dataset';
        BULK INSERT bronze.olist_customers_dataset
        FROM 'C:\Users\Ngoc Trong\Downloads\archive\olist_customers_dataset.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------'

    
        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_order_items_dataset';
        TRUNCATE TABLE bronze.olist_order_items_dataset;
        PRINT '>> Inserting data into olist_order_items_dataset';
        BULK INSERT bronze.olist_order_items_dataset
        FROM 'C:\Users\Ngoc Trong\Downloads\archive\olist_order_items_dataset.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------';


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_order_payments_dataset';
        TRUNCATE TABLE bronze.olist_order_payments_dataset;
        PRINT '>> Inserting data into olist_order_payments_dataset';
        BULK INSERT bronze.olist_order_payments_dataset
        FROM 'C:\Users\Ngoc Trong\Downloads\archive\olist_order_payments_dataset.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------';


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_order_reviews_dataset';
        TRUNCATE TABLE bronze.olist_order_reviews_dataset;
        PRINT '>> Inserting data into olist_order_reviews_dataset';
        BULK INSERT bronze.olist_order_reviews_dataset
        FROM 'C:\Users\Ngoc Trong\Downloads\archive\olist_order_reviews_dataset_clean.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------';


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_orders_dataset';
        TRUNCATE TABLE bronze.olist_orders_dataset;
        PRINT '>> Inserting data into olist_orders_dataset';
        BULK INSERT bronze.olist_orders_dataset
        FROM 'C:\Users\Ngoc Trong\Downloads\archive\olist_orders_dataset.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------';


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_product_category_name_translation';
        TRUNCATE TABLE bronze.olist_product_category_name_translation;
        PRINT '>> Inserting data into olist_product_category_name_translation';
        BULK INSERT bronze.olist_product_category_name_translation
        FROM 'C:\Users\Ngoc Trong\Downloads\archive\olist_product_category_name_translation.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------';


        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_products_dataset';
        TRUNCATE TABLE bronze.olist_products_dataset;
        PRINT '>> Inserting data into olist_products_dataset';
        BULK INSERT bronze.olist_products_dataset
        FROM 'C:\Users\Ngoc Trong\Downloads\archive\olist_products_dataset.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '------------';



        SET @start_time = GETDATE();
        PRINT '>> Trungcating Table: olist_sellers_dataset';
        TRUNCATE TABLE bronze.olist_sellers_dataset;
        PRINT '>> Inserting data into olist_sellers_dataset';
        BULK INSERT bronze.olist_sellers_dataset
        FROM 'C:\Users\Ngoc Trong\Downloads\archive\olist_sellers_dataset.csv'
        WITH
        (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK
        );
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
