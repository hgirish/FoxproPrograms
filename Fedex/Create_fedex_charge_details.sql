
if SCHEMA_ID('Fedex') is null
exec ('Create Schema Fedex')
go

IF   EXISTS (SELECT 1
           FROM sys.tables t
                JOIN sys.schemas s ON t.schema_id = s.schema_id
           WHERE s.[name] = N'Fedex'
             AND t.name = N'ChargeDetails'
             AND t.type = 'U')
ALTER TABLE [Fedex].[ChargeDetails] DROP CONSTRAINT if exists  [DF_ChargeDetails_DateIn]
GO

/****** Object:  Table [Fedex].[ChargeDetails]    Script Date: 2/12/2020 8:01:49 PM ******/
DROP TABLE if exists  [Fedex].[ChargeDetails]
GO

/****** Object:  Table [Fedex].[ChargeDetails]    Script Date: 2/12/2020 8:01:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF not  EXISTS (SELECT 1
           FROM sys.tables t
                JOIN sys.schemas s ON t.schema_id = s.schema_id
           WHERE s.[name] = N'Fedex'
             AND t.name = N'ChargeDetails'
             AND t.type = 'U')
CREATE TABLE [Fedex].[ChargeDetails](
	[InvoiceNumber] [varchar](20) NULL,
	[Tracking] [varchar](20) NULL,
	[ChargeType] [varchar](50) NULL,
	[Amount] [money] NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateIn] [datetime] NOT NULL,
 CONSTRAINT [PK_ChargeDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Fedex].[ChargeDetails] ADD  CONSTRAINT [DF_ChargeDetails_DateIn]  DEFAULT (getdate()) FOR [DateIn]
GO


