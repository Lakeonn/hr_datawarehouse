USE hr_datawarehouse;
GO

CREATE OR ALTER PROCEDURE dwh.master_load AS
BEGIN
    DECLARE @start_time DATETIME2 = SYSUTCDATETIME();
    DECLARE @end_time   DATETIME2;

    PRINT('Starting full DWH load at ' + CONVERT(VARCHAR(30), @start_time));

    BEGIN TRY
        -- Bronze load
        EXEC bronze.load_data_procedure;

        -- Silver load
        EXEC silver.load_data_procedure;

        -- Capture end time
        SET @end_time = SYSUTCDATETIME();

        -- Log success
        INSERT INTO dwh.etl_run_log (run_start, run_end, duration_seconds, status)
        VALUES (
            @start_time,
            @end_time,
            DATEDIFF(SECOND, @start_time, @end_time),
            'SUCCESS'
        );

        PRINT('DWH load completed successfully.');
    END TRY
    BEGIN CATCH
        -- Capture end time even on failure
        SET @end_time = SYSUTCDATETIME();

        -- Log failure
        INSERT INTO dwh.etl_run_log (run_start, run_end, duration_seconds, status, error_message)
        VALUES (
            @start_time,
            @end_time,
            DATEDIFF(SECOND, @start_time, @end_time),
            'FAILED',
            ERROR_MESSAGE()
        );

        PRINT('DWH load failed.');
        PRINT(ERROR_MESSAGE());

        -- Re-throw so you see the error
        THROW;
    END CATCH
END;
GO
