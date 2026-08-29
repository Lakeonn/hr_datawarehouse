
DROP TABLE IF EXISTS dwh.etl_run_log;
GO

CREATE TABLE dwh.etl_run_log (
    run_id INT IDENTITY(1,1) PRIMARY KEY,
    run_start DATETIME2 NOT NULL,
    run_end DATETIME2 NOT NULL,
    status VARCHAR(20) NOT NULL,
    error_message NVARCHAR(MAX) NULL
);
GO
