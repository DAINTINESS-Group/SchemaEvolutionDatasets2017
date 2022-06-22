	CREATE TABLE dbo.custom_Metadata(
		ContentId uniqueidentifier NOT NULL,
		ContentTypeId uniqueidentifier NOT NULL,
		DataKey nvarchar(64) NOT NULL,
		DataValue nvarchar(max) NOT NULL
)