if SCHEMA_ID('Fedex') is null
exec ('Create Schema Fedex')
go

IF   EXISTS (SELECT 1
           FROM sys.tables t
                JOIN sys.schemas s ON t.schema_id = s.schema_id
           WHERE s.[name] = N'Fedex'
             AND t.name = N'Invoices'
             AND t.type = 'U')
ALTER TABLE [Fedex].[Invoices] DROP CONSTRAINT if exists  [DF_Invoices_DateIn]
GO

/****** Object:  Table [Fedex].[Invoices]    Script Date: 2/12/2020 8:01:05 PM ******/
DROP TABLE if exists  [Fedex].[Invoices]
GO

/****** Object:  Table [Fedex].[Invoices]    Script Date: 2/12/2020 8:01:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF not  EXISTS (SELECT 1
           FROM sys.tables t
                JOIN sys.schemas s ON t.schema_id = s.schema_id
           WHERE s.[name] = N'Fedex'
             AND t.name = N'Invoices'
             AND t.type = 'U')
CREATE TABLE [Fedex].[Invoices](
	[BillToAccountNumber] [varchar](50) NULL,
	[InvoiceDate] [varchar](50) NULL,
	[InvoiceNumber] [varchar](50) NULL,
	[StoreID] [varchar](50) NULL,
	[OriginalAmountDue] [money] NULL,
	[CurrentBalance] [money] NULL,
	[Payor] [varchar](50) NULL,
	[GroundTrackingIDPrefix] [varchar](50) NULL,
	[ExpressOrGroundTrackingID] [varchar](50) NULL,
	[TransportationChargeAmount] [money] NULL,
	[NetChargeAmount] [money] NULL,
	[ServiceType] [varchar](50) NULL,
	[GroundService] [varchar](50) NULL,
	[ShipmentDate] [varchar](50) NULL,
	[PODDeliveryDate] [varchar](50) NULL,
	[PODDeliveryTime] [varchar](50) NULL,
	[PODServiceAreaCode] [varchar](50) NULL,
	[PODSignatureDescription] [varchar](50) NULL,
	[ActualWeightAmount] [numeric](7, 2) NULL,
	[ActualWeightUnits] [nvarchar](50) NULL,
	[RatedWeightAmount] [int] NULL,
	[RatedWeightUnits] [varchar](50) NULL,
	[NumberofPieces] [int] NULL,
	[BundleNumber] [varchar](50) NULL,
	[MeterNumber] [varchar](50) NULL,
	[TDMasterTrackingID] [varchar](50) NULL,
	[ServicePackaging] [varchar](50) NULL,
	[DimLength] [int] NULL,
	[DimWidth] [int] NULL,
	[DimHeight] [int] NULL,
	[DimDivisor] [int] NULL,
	[DimUnit] [varchar](50) NULL,
	[RecipientName] [varchar](50) NULL,
	[RecipientCompany] [varchar](50) NULL,
	[RecipientAddressLine1] [varchar](50) NULL,
	[RecipientAddressLine2] [varchar](50) NULL,
	[RecipientCity] [varchar](50) NULL,
	[RecipientState] [varchar](50) NULL,
	[RecipientZipCode] [varchar](50) NULL,
	[RecipientCountryTerritory] [varchar](50) NULL,
	[ShipperCompany] [varchar](50) NULL,
	[ShipperName] [varchar](50) NULL,
	[ShipperAddressLine1] [varchar](50) NULL,
	[ShipperAddressLine2] [varchar](50) NULL,
	[ShipperCity] [varchar](50) NULL,
	[ShipperState] [varchar](50) NULL,
	[ShipperZipCode] [varchar](50) NULL,
	[ShipperCountryTerritory] [varchar](50) NULL,
	[OriginalCustomerReference] [varchar](50) NULL,
	[OriginalRef2] [varchar](50) NULL,
	[OriginalRef3PONumber] [varchar](50) NULL,
	[OriginalDepartmentReferenceDescription] [varchar](50) NULL,
	[UpdatedCustomerReference] [varchar](50) NULL,
	[UpdatedRef2] [varchar](50) NULL,
	[UpdatedRef3PONumber] [varchar](50) NULL,
	[UpdatedDepartmentReferenceDescription] [varchar](50) NULL,
	[RMA] [varchar](50) NULL,
	[OriginalRecipientAddressLine1] [varchar](50) NULL,
	[OriginalRecipientAddressLine2] [varchar](50) NULL,
	[OriginalRecipientCity] [varchar](50) NULL,
	[OriginalRecipientState] [varchar](50) NULL,
	[OriginalRecipientZipCode] [varchar](50) NULL,
	[OriginalRecipientCountryTerritory] [varchar](50) NULL,
	[ZoneCode] [varchar](50) NULL,
	[CostAllocation] [varchar](50) NULL,
	[AlternateAddressLine1] [varchar](50) NULL,
	[AlternateAddressLine2] [varchar](50) NULL,
	[AlternateCity] [varchar](50) NULL,
	[AlternateStateProvince] [varchar](50) NULL,
	[AlternateZipCode] [varchar](50) NULL,
	[AlternateCountryTerritoryCode] [varchar](50) NULL,
	[CrossRefTrackingIDPrefix] [varchar](50) NULL,
	[CrossRefTrackingID] [varchar](50) NULL,
	[EntryDate] [varchar](50) NULL,
	[EntryNumber] [varchar](50) NULL,
	[CustomsValue] [varchar](50) NULL,
	[CustomsValueCurrencyCode] [varchar](50) NULL,
	[DeclaredValue] [varchar](50) NULL,
	[DeclaredValueCurrencyCode] [varchar](50) NULL,
	[CommodityDescription1] [varchar](50) NULL,
	[CommodityCountryTerritoryCode1] [varchar](50) NULL,
	[CommodityDescription2] [varchar](50) NULL,
	[CommodityCountryTerritoryCode2] [varchar](50) NULL,
	[CommodityDescription3] [varchar](50) NULL,
	[CommodityCountryTerritoryCode3] [varchar](50) NULL,
	[CommodityDescription4] [varchar](50) NULL,
	[CommodityCountryTerritoryCode4] [varchar](50) NULL,
	[CurrencyConversionDate] [varchar](50) NULL,
	[CurrencyConversionRate] [varchar](50) NULL,
	[MultiweightNumber] [varchar](50) NULL,
	[MultiweightTotalMultiweightUnits] [varchar](50) NULL,
	[MultiweightTotalMultiweightWeight] [varchar](50) NULL,
	[MultiweightTotalShipmentChargeAmount] [varchar](50) NULL,
	[MultiweightTotalShipmentWeight] [varchar](50) NULL,
	[GroundTrackingIDAddressCorrectionDiscountChargeAmount] [varchar](50) NULL,
	[GroundTrackingIDAddressCorrectionGrossChargeAmount] [varchar](50) NULL,
	[RatedMethod] [varchar](50) NULL,
	[SortHub] [varchar](50) NULL,
	[EstimatedWeight] [varchar](50) NULL,
	[EstimatedWeightUnit] [varchar](50) NULL,
	[PostalClass] [varchar](50) NULL,
	[ProcessCategory] [varchar](50) NULL,
	[PackageSize] [varchar](50) NULL,
	[DeliveryConfirmation] [varchar](50) NULL,
	[TenderedDate] [varchar](50) NULL,
	[TrackingIDChargeDescription1] [varchar](50) NULL,
	[TrackingIDChargeAmount1] [money] NULL,
	[TrackingIDChargeDescription2] [varchar](50) NULL,
	[TrackingIDChargeAmount2] [money] NULL,
	[TrackingIDChargeDescription3] [varchar](50) NULL,
	[TrackingIDChargeAmount3] [money] NULL,
	[TrackingIDChargeDescription4] [varchar](50) NULL,
	[TrackingIDChargeAmount4] [money] NULL,
	[TrackingIDChargeDescription5] [varchar](50) NULL,
	[TrackingIDChargeAmount5] [money] NULL,
	[TrackingIDChargeDescription6] [varchar](50) NULL,
	[TrackingIDChargeAmount6] [money] NULL,
	[TrackingIDChargeDescription7] [varchar](50) NULL,
	[TrackingIDChargeAmount7] [money] NULL,
	[TrackingIDChargeDescription8] [varchar](50) NULL,
	[TrackingIDChargeAmount8] [money] NULL,
	[TrackingIDChargeDescription9] [varchar](50) NULL,
	[TrackingIDChargeAmount9] [money] NULL,
	[TrackingIDChargeDescription10] [varchar](50) NULL,
	[TrackingIDChargeAmount10] [money] NULL,
	[TrackingIDChargeDescription11] [varchar](50) NULL,
	[TrackingIDChargeAmount11] [money] NULL,
	[TrackingIDChargeDescription12] [varchar](50) NULL,
	[TrackingIDChargeAmount12] [money] NULL,
	[TrackingIDChargeDescription13] [varchar](50) NULL,
	[TrackingIDChargeAmount13] [money] NULL,
	[TrackingIDChargeDescription14] [varchar](50) NULL,
	[TrackingIDChargeAmount14] [money] NULL,
	[TrackingIDChargeDescription15] [varchar](50) NULL,
	[TrackingIDChargeAmount15] [money] NULL,
	[TrackingIDChargeDescription16] [varchar](50) NULL,
	[TrackingIDChargeAmount16] [money] NULL,
	[TrackingIDChargeDescription17] [varchar](50) NULL,
	[TrackingIDChargeAmount17] [money] NULL,
	[TrackingIDChargeDescription18] [varchar](50) NULL,
	[TrackingIDChargeAmount18] [money] NULL,
	[TrackingIDChargeDescription19] [varchar](50) NULL,
	[TrackingIDChargeAmount19] [money] NULL,
	[TrackingIDChargeDescription20] [varchar](50) NULL,
	[TrackingIDChargeAmount20] [money] NULL,
	[TrackingIDChargeDescription21] [varchar](50) NULL,
	[TrackingIDChargeAmount21] [money] NULL,
	[TrackingIDChargeDescription22] [varchar](50) NULL,
	[TrackingIDChargeAmount22] [money] NULL,
	[TrackingIDChargeDescription23] [varchar](50) NULL,
	[TrackingIDChargeAmount23] [money] NULL,
	[TrackingIDChargeDescription24] [varchar](50) NULL,
	[TrackingIDChargeAmount24] [money] NULL,
	[TrackingIDChargeDescription25] [varchar](50) NULL,
	[TrackingIDChargeAmount25] [money] NULL,
	[ShipmentNotes] [varchar](50) NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateIn] [datetime] NOT NULL,
 CONSTRAINT [PK_Invoices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Fedex].[Invoices] ADD  CONSTRAINT [DF_Invoices_DateIn]  DEFAULT (getutcdate()) FOR [DateIn]
GO


