Clear
lcAlias = 'curFedexInvoice'
lcChargeesAlias = 'curCharges'
If Not Used(lcAlias)
	MakeCursor(lcAlias)
	Select (lcAlias)
	lcCsv = Getfile('csv')
	If Empty(lcCsv) Or Not File(lcCsv)
		Return
	Endif
	Append From (lcCsv) Delimited
	Browse
Endif
If Not Used('curCharges')
	Create Cursor curCharges (InvoiceNumber c(20), Tracking c(20), ChargeType c(50), Amount N(7,2))
ENDIF
SELECT curFedexInvoice
SCAN 
AddToChargeTable()
SELECT curFedexInvoice

ENDSCAN
lnAnswer = Messagebox("Do you want to insert records in Sql database?",36)
If lnAnswer != 6
	?"User cancelled"
	Return

Endif
Delete For InvoiceNumber = 'Invoice Number'
lcInsertSql = GetInsertSql()

llError = .F.
llSuccess = .T.
Select (lcAlias)
COUNT ALL to lnCntInvoice
SCAN
Select (lcAlias)
lnRecno = RECNO()
*Try
	llExists = CheckIfRecordExist()
	If llExists
		? lnRecno, " of ", lnCntInvoice , " Record exists"
	Else
		Select (lcAlias)
		llSuccess =	InsertRecord()
		? lnRecno, " of ", lnCntInvoice,  " : added: ", llSuccess
	Endif
*Catch To loException
*	llError = .T.
*	Messagebox(loException.Message)

*Finally

*** disconnect sql connection
*Endtry
	Select (lcAlias)
	If llError
		Exit
	Endif
	If !llSuccess
		Exit
	Endif
ENDSCAN

SELECT curCharges
COUNT ALL to lnCntCharges 
SCAN 
Select (lcAlias)
lnRecno = RECNO()
llSuccess = InsertChargeRecord()

?lnRecno, " of " , lnCntCharges, " added: ", llSuccess

SELECT curCharges
ENDSCAN
Return

**************************************************
Function MakeCursor
Lparameters lcCursorName
Create Cursor (lcCursorName) (;
	BillToAccountNumber Varchar(20) Null, ;
	InvoiceDate Varchar(20) Null, ;
	InvoiceNumber Varchar(20) Null, ;
	StoreID Varchar(50) Null, ;
	OriginalAmountDue N(7,2) Null, ;
	CurrentBalance N(7,2) Null, ;
	Payor Varchar(20) Null, ;
	GroundTrackingIDPrefix Varchar(50) Null, ;
	ExpressOrGroundTrackingID Varchar(50) Null, ;
	TransportationChargeAmount N(7,2) Null, ;
	NetChargeAmount N(7,2) Null, ;
	ServiceType Varchar(50) Null, ;
	GroundService Varchar(50) Null, ;
	ShipmentDate Varchar(50) Null, ;
	PODDeliveryDate Varchar(50) Null, ;
	PODDeliveryTime Varchar(50) Null, ;
	PODServiceAreaCode Varchar(50) Null, ;
	PODSignatureDescription Varchar(50) Null, ;
	ActualWeightAmount N(7,2) Null, ;
	ActualWeightUnits Varchar(50) Null, ;
	RatedWeightAmount i Null, ;
	RatedWeightUnits Varchar(50) Null, ;
	NumberofPieces i Null, ;
	BundleNumber Varchar(50) Null, ;
	MeterNumber Varchar(50) Null, ;
	TDMasterTrackingID Varchar(50) Null, ;
	ServicePackaging Varchar(50) Null, ;
	DimLength i Null, ;
	DimWidth i Null, ;
	DimHeight i Null, ;
	DimDivisor i Null, ;
	DimUnit Varchar(50) Null, ;
	RecipientName Varchar(50) Null, ;
	RecipientCompany Varchar(50) Null, ;
	RecipientAddressLine1 Varchar(50) Null, ;
	RecipientAddressLine2 Varchar(50) Null, ;
	RecipientCity Varchar(50) Null, ;
	RecipientState Varchar(50) Null, ;
	RecipientZipCode Varchar(50) Null, ;
	RecipientCountryTerritory Varchar(50) Null, ;
	ShipperCompany Varchar(50) Null, ;
	ShipperName Varchar(50) Null, ;
	ShipperAddressLine1 Varchar(50) Null, ;
	ShipperAddressLine2 Varchar(50) Null, ;
	ShipperCity Varchar(50) Null, ;
	ShipperState Varchar(50) Null, ;
	ShipperZipCode Varchar(50) Null, ;
	ShipperCountryTerritory Varchar(50) Null, ;
	OriginalCustomerReference Varchar(50) Null, ;
	OriginalRef2 Varchar(50) Null, ;
	OriginalRef3PONumber Varchar(50) Null, ;
	OriginalDepartmentReferenceDescription Varchar(50) Null, ;
	UpdatedCustomerReference Varchar(50) Null, ;
	UpdatedRef2 Varchar(50) Null, ;
	UpdatedRef3PONumber Varchar(50) Null, ;
	UpdatedDepartmentReferenceDescription Varchar(50) Null, ;
	RMA Varchar(50) Null, ;
	OriginalRecipientAddressLine1 Varchar(50) Null, ;
	OriginalRecipientAddressLine2 Varchar(50) Null, ;
	OriginalRecipientCity Varchar(50) Null, ;
	OriginalRecipientState Varchar(50) Null, ;
	OriginalRecipientZipCode Varchar(50) Null, ;
	OriginalRecipientCountryTerritory Varchar(50) Null, ;
	ZoneCode Varchar(50) Null, ;
	CostAllocation Varchar(50) Null, ;
	AlternateAddressLine1 Varchar(50) Null, ;
	AlternateAddressLine2 Varchar(50) Null, ;
	AlternateCity Varchar(50) Null, ;
	AlternateStateProvince Varchar(50) Null, ;
	AlternateZipCode Varchar(50) Null, ;
	AlternateCountryTerritoryCode Varchar(50) Null, ;
	CrossRefTrackingIDPrefix Varchar(50) Null, ;
	CrossRefTrackingID Varchar(50) Null, ;
	EntryDate Varchar(50) Null, ;
	EntryNumber Varchar(50) Null, ;
	CustomsValue Varchar(50) Null, ;
	CustomsValueCurrencyCode Varchar(50) Null, ;
	DeclaredValue Varchar(50) Null, ;
	DeclaredValueCurrencyCode Varchar(50) Null, ;
	CommodityDescription1 Varchar(50) Null, ;
	CommodityCountryTerritoryCode1 Varchar(50) Null, ;
	CommodityDescription2 Varchar(50) Null, ;
	CommodityCountryTerritoryCode2 Varchar(50) Null, ;
	CommodityDescription3 Varchar(50) Null, ;
	CommodityCountryTerritoryCode3 Varchar(50) Null, ;
	CommodityDescription4 Varchar(50) Null, ;
	CommodityCountryTerritoryCode4 Varchar(50) Null, ;
	CurrencyConversionDate Varchar(50) Null, ;
	CurrencyConversionRate Varchar(50) Null, ;
	MultiweightNumber Varchar(50) Null, ;
	MultiweightTotalMultiweightUnits Varchar(50) Null, ;
	MultiweightTotalMultiweightWeight Varchar(50) Null, ;
	MultiweightTotalShipmentChargeAmount Varchar(50) Null, ;
	MultiweightTotalShipmentWeight Varchar(50) Null, ;
	GroundTrackingIDAddressCorrectionDiscountChargeAmount Varchar(50) Null, ;
	GroundTrackingIDAddressCorrectionGrossChargeAmount Varchar(50) Null, ;
	RatedMethod Varchar(50) Null, ;
	SortHub Varchar(50) Null, ;
	EstimatedWeight Varchar(50) Null, ;
	EstimatedWeightUnit Varchar(50) Null, ;
	PostalClass Varchar(50) Null, ;
	ProcessCategory Varchar(50) Null, ;
	PackageSize Varchar(50) Null, ;
	DeliveryConfirmation Varchar(50) Null, ;
	TenderedDate Varchar(50) Null, ;
	TrackingIDChargeDescription1 Varchar(50) Null, ;
	TrackingIDChargeAmount1 N(7,2) , ;
	TrackingIDChargeDescription2 Varchar(50) Null, ;
	TrackingIDChargeAmount2 N(7,2) , ;
	TrackingIDChargeDescription3 Varchar(50) Null, ;
	TrackingIDChargeAmount3 N(7,2) , ;
	TrackingIDChargeDescription4 Varchar(50) Null, ;
	TrackingIDChargeAmount4 N(7,2) , ;
	TrackingIDChargeDescription5 Varchar(50) Null, ;
	TrackingIDChargeAmount5 N(7,2) , ;
	TrackingIDChargeDescription6 Varchar(50) Null, ;
	TrackingIDChargeAmount6 N(7,2) , ;
	TrackingIDChargeDescription7 Varchar(50) Null, ;
	TrackingIDChargeAmount7 N(7,2) , ;
	TrackingIDChargeDescription8 Varchar(50) Null, ;
	TrackingIDChargeAmount8 N(7,2) , ;
	TrackingIDChargeDescription9 Varchar(50) Null, ;
	TrackingIDChargeAmount9 N(7,2) , ;
	TrackingIDChargeDescription10 Varchar(50) Null, ;
	TrackingIDChargeAmount10 N(7,2) , ;
	TrackingIDChargeDescription11 Varchar(50) Null, ;
	TrackingIDChargeAmount11 N(7,2) , ;
	TrackingIDChargeDescription12 Varchar(50) Null, ;
	TrackingIDChargeAmount12 N(7,2) , ;
	TrackingIDChargeDescription13 Varchar(50) Null, ;
	TrackingIDChargeAmount13 N(7,2) , ;
	TrackingIDChargeDescription14 Varchar(50) Null, ;
	TrackingIDChargeAmount14 N(7,2) , ;
	TrackingIDChargeDescription15 Varchar(50) Null, ;
	TrackingIDChargeAmount15 N(7,2) , ;
	TrackingIDChargeDescription16 Varchar(50) Null, ;
	TrackingIDChargeAmount16 N(7,2) , ;
	TrackingIDChargeDescription17 Varchar(50) Null, ;
	TrackingIDChargeAmount17 N(7,2) , ;
	TrackingIDChargeDescription18 Varchar(50) Null, ;
	TrackingIDChargeAmount18 N(7,2) , ;
	TrackingIDChargeDescription19 Varchar(50) Null, ;
	TrackingIDChargeAmount19 N(7,2) , ;
	TrackingIDChargeDescription20 Varchar(50) Null, ;
	TrackingIDChargeAmount20 N(7,2) , ;
	TrackingIDChargeDescription21 Varchar(50) Null, ;
	TrackingIDChargeAmount21 N(7,2) , ;
	TrackingIDChargeDescription22 Varchar(50) Null, ;
	TrackingIDChargeAmount22 N(7,2) , ;
	TrackingIDChargeDescription23 Varchar(50) Null, ;
	TrackingIDChargeAmount23 N(7,2) , ;
	TrackingIDChargeDescription24 Varchar(50) Null, ;
	TrackingIDChargeAmount24 N(7,2) , ;
	TrackingIDChargeDescription25 Varchar(50) Null, ;
	TrackingIDChargeAmount25 N(7,2) , ;
	ShipmentNotes Varchar(50) Null)


Endfunc
**************************************************
Function AddToChargeTable
lcInvoiceNumber  = Alltrim(InvoiceNumber)
lcTracking = Alltrim(Alltrim(ExpressOrGroundTrackingID))
For lnI = 1 To 25
	lcFAmount = 'TrackingIDChargeAmount' + Transform(lnI)
	lcFDescr = 'TrackingIDChargeDescription' + Transform(lnI)
	lnAmount = Evaluate(lcFAmount)
	lcDescr = Evaluate(lcFDescr)
	If lnAmount <> 0
		Insert Into curCharges (InvoiceNumber, Tracking, ChargeType, Amount) Values;
			(lcInvoiceNumber, lcTracking, lcDescr, lnAmount)
	Endif
Endfor

Endfunc
********************************************
Function GetInsertSql

TEXT TO lcInsertSql NOSHOW TEXTMERGE
INSERT INTO Fedex.Invoices
           (BillToAccountNumber
           ,InvoiceDate
           ,InvoiceNumber
           ,StoreID
           ,OriginalAmountDue
           ,CurrentBalance
           ,Payor
           ,GroundTrackingIDPrefix
           ,ExpressOrGroundTrackingID
           ,TransportationChargeAmount
           ,NetChargeAmount
           ,ServiceType
           ,GroundService
           ,ShipmentDate
           ,PODDeliveryDate
           ,PODDeliveryTime
           ,PODServiceAreaCode
           ,PODSignatureDescription
           ,ActualWeightAmount
           ,ActualWeightUnits
           ,RatedWeightAmount
           ,RatedWeightUnits
           ,NumberofPieces
           ,BundleNumber
           ,MeterNumber
           ,TDMasterTrackingID
           ,ServicePackaging
           ,DimLength
           ,DimWidth
           ,DimHeight
           ,DimDivisor
           ,DimUnit
           ,RecipientName
           ,RecipientCompany
           ,RecipientAddressLine1
           ,RecipientAddressLine2
           ,RecipientCity
           ,RecipientState
           ,RecipientZipCode
           ,RecipientCountryTerritory
           ,ShipperCompany
           ,ShipperName
           ,ShipperAddressLine1
           ,ShipperAddressLine2
           ,ShipperCity
           ,ShipperState
           ,ShipperZipCode
           ,ShipperCountryTerritory
           ,OriginalCustomerReference
           ,OriginalRef2
           ,OriginalRef3PONumber
           ,OriginalDepartmentReferenceDescription
           ,UpdatedCustomerReference
           ,UpdatedRef2
           ,UpdatedRef3PONumber
           ,UpdatedDepartmentReferenceDescription
           ,RMA
           ,OriginalRecipientAddressLine1
           ,OriginalRecipientAddressLine2
           ,OriginalRecipientCity
           ,OriginalRecipientState
           ,OriginalRecipientZipCode
           ,OriginalRecipientCountryTerritory
           ,ZoneCode
           ,CostAllocation
           ,AlternateAddressLine1
           ,AlternateAddressLine2
           ,AlternateCity
           ,AlternateStateProvince
           ,AlternateZipCode
           ,AlternateCountryTerritoryCode
           ,CrossRefTrackingIDPrefix
           ,CrossRefTrackingID
           ,EntryDate
           ,EntryNumber
           ,CustomsValue
           ,CustomsValueCurrencyCode
           ,DeclaredValue
           ,DeclaredValueCurrencyCode
           ,CommodityDescription1
           ,CommodityCountryTerritoryCode1
           ,CommodityDescription2
           ,CommodityCountryTerritoryCode2
           ,CommodityDescription3
           ,CommodityCountryTerritoryCode3
           ,CommodityDescription4
           ,CommodityCountryTerritoryCode4
           ,CurrencyConversionDate
           ,CurrencyConversionRate
           ,MultiweightNumber
           ,MultiweightTotalMultiweightUnits
           ,MultiweightTotalMultiweightWeight
           ,MultiweightTotalShipmentChargeAmount
           ,MultiweightTotalShipmentWeight
           ,GroundTrackingIDAddressCorrectionDiscountChargeAmount
           ,GroundTrackingIDAddressCorrectionGrossChargeAmount
           ,RatedMethod
           ,SortHub
           ,EstimatedWeight
           ,EstimatedWeightUnit
           ,PostalClass
           ,ProcessCategory
           ,PackageSize
           ,DeliveryConfirmation
           ,TenderedDate
           ,TrackingIDChargeDescription1
           ,TrackingIDChargeAmount1
           ,TrackingIDChargeDescription2
           ,TrackingIDChargeAmount2
           ,TrackingIDChargeDescription3
           ,TrackingIDChargeAmount3
           ,TrackingIDChargeDescription4
           ,TrackingIDChargeAmount4
           ,TrackingIDChargeDescription5
           ,TrackingIDChargeAmount5
           ,TrackingIDChargeDescription6
           ,TrackingIDChargeAmount6
           ,TrackingIDChargeDescription7
           ,TrackingIDChargeAmount7
           ,TrackingIDChargeDescription8
           ,TrackingIDChargeAmount8
           ,TrackingIDChargeDescription9
           ,TrackingIDChargeAmount9
           ,TrackingIDChargeDescription10
           ,TrackingIDChargeAmount10
           ,TrackingIDChargeDescription11
           ,TrackingIDChargeAmount11
           ,TrackingIDChargeDescription12
           ,TrackingIDChargeAmount12
           ,TrackingIDChargeDescription13
           ,TrackingIDChargeAmount13
           ,TrackingIDChargeDescription14
           ,TrackingIDChargeAmount14
           ,TrackingIDChargeDescription15
           ,TrackingIDChargeAmount15
           ,TrackingIDChargeDescription16
           ,TrackingIDChargeAmount16
           ,TrackingIDChargeDescription17
           ,TrackingIDChargeAmount17
           ,TrackingIDChargeDescription18
           ,TrackingIDChargeAmount18
           ,TrackingIDChargeDescription19
           ,TrackingIDChargeAmount19
           ,TrackingIDChargeDescription20
           ,TrackingIDChargeAmount20
           ,TrackingIDChargeDescription21
           ,TrackingIDChargeAmount21
           ,TrackingIDChargeDescription22
           ,TrackingIDChargeAmount22
           ,TrackingIDChargeDescription23
           ,TrackingIDChargeAmount23
           ,TrackingIDChargeDescription24
           ,TrackingIDChargeAmount24
           ,TrackingIDChargeDescription25
           ,TrackingIDChargeAmount25
           ,ShipmentNotes
          )
     VALUES
           (?lcBillToAccountNumber
           ,?lcInvoiceDate
           ,?lcInvoiceNumber
           ,?lcStoreID
           ,?lcOriginalAmountDue
           ,?lcCurrentBalance
           ,?lcPayor
           ,?lcGroundTrackingIDPrefix
           ,?lcExpressOrGroundTrackingID
           ,?lcTransportationChargeAmount
           ,?lcNetChargeAmount
           ,?lcServiceType
           ,?lcGroundService
           ,?lcShipmentDate
           ,?lcPODDeliveryDate
           ,?lcPODDeliveryTime
           ,?lcPODServiceAreaCode
           ,?lcPODSignatureDescription
           ,?lcActualWeightAmount
           ,?lcActualWeightUnits
           ,?lcRatedWeightAmount
           ,?lcRatedWeightUnits
           ,?lcNumberofPieces
           ,?lcBundleNumber
           ,?lcMeterNumber
           ,?lcTDMasterTrackingID
           ,?lcServicePackaging
           ,?lcDimLength
           ,?lcDimWidth
           ,?lcDimHeight
           ,?lcDimDivisor
           ,?lcDimUnit
           ,?lcRecipientName
           ,?lcRecipientCompany
           ,?lcRecipientAddressLine1
           ,?lcRecipientAddressLine2
           ,?lcRecipientCity
           ,?lcRecipientState
           ,?lcRecipientZipCode
           ,?lcRecipientCountryTerritory
           ,?lcShipperCompany
           ,?lcShipperName
           ,?lcShipperAddressLine1
           ,?lcShipperAddressLine2
           ,?lcShipperCity
           ,?lcShipperState
           ,?lcShipperZipCode
           ,?lcShipperCountryTerritory
           ,?lcOriginalCustomerReference
           ,?lcOriginalRef2
           ,?lcOriginalRef3PONumber
           ,?lcOriginalDepartmentReferenceDescription
           ,?lcUpdatedCustomerReference
           ,?lcUpdatedRef2
           ,?lcUpdatedRef3PONumber
           ,?lcUpdatedDepartmentReferenceDescription
           ,?lcRMA
           ,?lcOriginalRecipientAddressLine1
           ,?lcOriginalRecipientAddressLine2
           ,?lcOriginalRecipientCity
           ,?lcOriginalRecipientState
           ,?lcOriginalRecipientZipCode
           ,?lcOriginalRecipientCountryTerritory
           ,?lcZoneCode
           ,?lcCostAllocation
           ,?lcAlternateAddressLine1
           ,?lcAlternateAddressLine2
           ,?lcAlternateCity
           ,?lcAlternateStateProvince
           ,?lcAlternateZipCode
           ,?lcAlternateCountryTerritoryCode
           ,?lcCrossRefTrackingIDPrefix
           ,?lcCrossRefTrackingID
           ,?lcEntryDate
           ,?lcEntryNumber
           ,?lcCustomsValue
           ,?lcCustomsValueCurrencyCode
           ,?lcDeclaredValue
           ,?lcDeclaredValueCurrencyCode
           ,?lcCommodityDescription1
           ,?lcCommodityCountryTerritoryCode1
           ,?lcCommodityDescription2
           ,?lcCommodityCountryTerritoryCode2
           ,?lcCommodityDescription3
           ,?lcCommodityCountryTerritoryCode3
           ,?lcCommodityDescription4
           ,?lcCommodityCountryTerritoryCode4
           ,?lcCurrencyConversionDate
           ,?lcCurrencyConversionRate
           ,?lcMultiweightNumber
           ,?lcMultiweightTotalMultiweightUnits
           ,?lcMultiweightTotalMultiweightWeight
           ,?lcMultiweightTotalShipmentChargeAmount
           ,?lcMultiweightTotalShipmentWeight
           ,?lcGroundTrackingIDAddressCorrectionDiscountChargeAmount
           ,?lcGroundTrackingIDAddressCorrectionGrossChargeAmount
           ,?lcRatedMethod
           ,?lcSortHub
           ,?lcEstimatedWeight
           ,?lcEstimatedWeightUnit
           ,?lcPostalClass
           ,?lcProcessCategory
           ,?lcPackageSize
           ,?lcDeliveryConfirmation
           ,?lcTenderedDate
           ,?lcTrackingIDChargeDescription1
           ,?lcTrackingIDChargeAmount1
           ,?lcTrackingIDChargeDescription2
           ,?lcTrackingIDChargeAmount2
           ,?lcTrackingIDChargeDescription3
           ,?lcTrackingIDChargeAmount3
           ,?lcTrackingIDChargeDescription4
           ,?lcTrackingIDChargeAmount4
           ,?lcTrackingIDChargeDescription5
           ,?lcTrackingIDChargeAmount5
           ,?lcTrackingIDChargeDescription6
           ,?lcTrackingIDChargeAmount6
           ,?lcTrackingIDChargeDescription7
           ,?lcTrackingIDChargeAmount7
           ,?lcTrackingIDChargeDescription8
           ,?lcTrackingIDChargeAmount8
           ,?lcTrackingIDChargeDescription9
           ,?lcTrackingIDChargeAmount9
           ,?lcTrackingIDChargeDescription10
           ,?lcTrackingIDChargeAmount10
           ,?lcTrackingIDChargeDescription11
           ,?lcTrackingIDChargeAmount11
           ,?lcTrackingIDChargeDescription12
           ,?lcTrackingIDChargeAmount12
           ,?lcTrackingIDChargeDescription13
           ,?lcTrackingIDChargeAmount13
           ,?lcTrackingIDChargeDescription14
           ,?lcTrackingIDChargeAmount14
           ,?lcTrackingIDChargeDescription15
           ,?lcTrackingIDChargeAmount15
           ,?lcTrackingIDChargeDescription16
           ,?lcTrackingIDChargeAmount16
           ,?lcTrackingIDChargeDescription17
           ,?lcTrackingIDChargeAmount17
           ,?lcTrackingIDChargeDescription18
           ,?lcTrackingIDChargeAmount18
           ,?lcTrackingIDChargeDescription19
           ,?lcTrackingIDChargeAmount19
           ,?lcTrackingIDChargeDescription20
           ,?lcTrackingIDChargeAmount20
           ,?lcTrackingIDChargeDescription21
           ,?lcTrackingIDChargeAmount21
           ,?lcTrackingIDChargeDescription22
           ,?lcTrackingIDChargeAmount22
           ,?lcTrackingIDChargeDescription23
           ,?lcTrackingIDChargeAmount23
           ,?lcTrackingIDChargeDescription24
           ,?lcTrackingIDChargeAmount24
            ,?lcTrackingIDChargeDescription25
           ,?lcTrackingIDChargeAmount25
           ,?lcShipmentNotes
           )
ENDTEXT
Return lcInsertSql
Endfunc

****************************
Function InsertRecord
lcBillToAccountNumber = Alltrim(BillToAccountNumber)
lcInvoiceDate = Alltrim(InvoiceDate)
lcInvoiceNumber = Alltrim(InvoiceNumber)
lcStoreID = Alltrim(StoreID)
lcOriginalAmountDue = OriginalAmountDue
lcCurrentBalance = CurrentBalance
lcPayor = Alltrim(Payor)
lcGroundTrackingIDPrefix = Alltrim(GroundTrackingIDPrefix)
lcExpressOrGroundTrackingID = Alltrim(ExpressOrGroundTrackingID)
lcTransportationChargeAmount = TransportationChargeAmount
lcNetChargeAmount = NetChargeAmount
lcServiceType = Alltrim(ServiceType)
lcGroundService = Alltrim(GroundService)
lcShipmentDate = Alltrim(ShipmentDate)
lcPODDeliveryDate = Alltrim(PODDeliveryDate)
lcPODDeliveryTime = Alltrim(PODDeliveryTime)
lcPODServiceAreaCode = Alltrim(PODServiceAreaCode)
lcPODSignatureDescription = Alltrim(PODSignatureDescription)
lcActualWeightAmount = ActualWeightAmount
lcActualWeightUnits = Alltrim(ActualWeightUnits)
lcRatedWeightAmount = RatedWeightAmount
lcRatedWeightUnits = Alltrim(RatedWeightUnits)
lcNumberofPieces = NumberofPieces
lcBundleNumber = Alltrim(BundleNumber)
lcMeterNumber = Alltrim(MeterNumber)
lcTDMasterTrackingID = Alltrim(TDMasterTrackingID)
lcServicePackaging = Alltrim(ServicePackaging)
lcDimLength = DimLength
lcDimWidth = DimWidth
lcDimHeight = DimHeight
lcDimDivisor = DimDivisor
lcDimUnit = Alltrim(DimUnit)
lcRecipientName = Alltrim(RecipientName)
lcRecipientCompany = Alltrim(RecipientCompany)
lcRecipientAddressLine1 = Alltrim(RecipientAddressLine1)
lcRecipientAddressLine2 = Alltrim(RecipientAddressLine2)
lcRecipientCity = Alltrim(RecipientCity)
lcRecipientState = Alltrim(RecipientState)
lcRecipientZipCode = Alltrim(RecipientZipCode)
lcRecipientCountryTerritory = Alltrim(RecipientCountryTerritory)
lcShipperCompany = Alltrim(ShipperCompany)
lcShipperName = Alltrim(ShipperName)
lcShipperAddressLine1 = Alltrim(ShipperAddressLine1)
lcShipperAddressLine2 = Alltrim(ShipperAddressLine2)
lcShipperCity = Alltrim(ShipperCity)
lcShipperState = Alltrim(ShipperState)
lcShipperZipCode = Alltrim(ShipperZipCode)
lcShipperCountryTerritory = Alltrim(ShipperCountryTerritory)
lcOriginalCustomerReference = Alltrim(OriginalCustomerReference)
lcOriginalRef2 = Alltrim(OriginalRef2)
lcOriginalRef3PONumber = Alltrim(OriginalRef3PONumber)
lcOriginalDepartmentReferenceDescription = Alltrim(OriginalDepartmentReferenceDescription)
lcUpdatedCustomerReference = Alltrim(UpdatedCustomerReference)
lcUpdatedRef2 = Alltrim(UpdatedRef2)
lcUpdatedRef3PONumber = Alltrim(UpdatedRef3PONumber)
lcUpdatedDepartmentReferenceDescription = Alltrim(UpdatedDepartmentReferenceDescription)
lcRMA = Alltrim(RMA)
lcOriginalRecipientAddressLine1 = Alltrim(OriginalRecipientAddressLine1)
lcOriginalRecipientAddressLine2 = Alltrim(OriginalRecipientAddressLine2)
lcOriginalRecipientCity = Alltrim(OriginalRecipientCity)
lcOriginalRecipientState = Alltrim(OriginalRecipientState)
lcOriginalRecipientZipCode = Alltrim(OriginalRecipientZipCode)
lcOriginalRecipientCountryTerritory = Alltrim(OriginalRecipientCountryTerritory)
lcZoneCode = Alltrim(ZoneCode)
lcCostAllocation = Alltrim(CostAllocation)
lcAlternateAddressLine1 = Alltrim(AlternateAddressLine1)
lcAlternateAddressLine2 = Alltrim(AlternateAddressLine2)
lcAlternateCity = Alltrim(AlternateCity)
lcAlternateStateProvince = Alltrim(AlternateStateProvince)
lcAlternateZipCode = Alltrim(AlternateZipCode)
lcAlternateCountryTerritoryCode = Alltrim(AlternateCountryTerritoryCode)
lcCrossRefTrackingIDPrefix = Alltrim(CrossRefTrackingIDPrefix)
lcCrossRefTrackingID = Alltrim(CrossRefTrackingID)
lcEntryDate = Alltrim(EntryDate)
lcEntryNumber = Alltrim(EntryNumber)
lcCustomsValue = Alltrim(CustomsValue)
lcCustomsValueCurrencyCode = Alltrim(CustomsValueCurrencyCode)
lcDeclaredValue = Alltrim(DeclaredValue)
lcDeclaredValueCurrencyCode = Alltrim(DeclaredValueCurrencyCode)
lcCommodityDescription1 = Alltrim(CommodityDescription1)
lcCommodityCountryTerritoryCode1 = Alltrim(CommodityCountryTerritoryCode1)
lcCommodityDescription2 = Alltrim(CommodityDescription2)
lcCommodityCountryTerritoryCode2 = Alltrim(CommodityCountryTerritoryCode2)
lcCommodityDescription3 = Alltrim(CommodityDescription3)
lcCommodityCountryTerritoryCode3 = Alltrim(CommodityCountryTerritoryCode3)
lcCommodityDescription4 = Alltrim(CommodityDescription4)
lcCommodityCountryTerritoryCode4 = Alltrim(CommodityCountryTerritoryCode4)
lcCurrencyConversionDate = Alltrim(CurrencyConversionDate)
lcCurrencyConversionRate = Alltrim(CurrencyConversionRate)
lcMultiweightNumber = Alltrim(MultiweightNumber)
lcMultiweightTotalMultiweightUnits = Alltrim(MultiweightTotalMultiweightUnits)
lcMultiweightTotalMultiweightWeight = Alltrim(MultiweightTotalMultiweightWeight)
lcMultiweightTotalShipmentChargeAmount = Alltrim(MultiweightTotalShipmentChargeAmount)
lcMultiweightTotalShipmentWeight = Alltrim(MultiweightTotalShipmentWeight)
lcGroundTrackingIDAddressCorrectionDiscountChargeAmount = Alltrim(GroundTrackingIDAddressCorrectionDiscountChargeAmount)
lcGroundTrackingIDAddressCorrectionGrossChargeAmount = Alltrim(GroundTrackingIDAddressCorrectionGrossChargeAmount)
lcRatedMethod = Alltrim(RatedMethod)
lcSortHub = Alltrim(SortHub)
lcEstimatedWeight = Alltrim(EstimatedWeight)
lcEstimatedWeightUnit = Alltrim(EstimatedWeightUnit)
lcPostalClass = Alltrim(PostalClass)
lcProcessCategory = Alltrim(ProcessCategory)
lcPackageSize = Alltrim(PackageSize)
lcDeliveryConfirmation = Alltrim(DeliveryConfirmation)
lcTenderedDate = Alltrim(TenderedDate)
lcTrackingIDChargeDescription1 = Alltrim(TrackingIDChargeDescription1)
lcTrackingIDChargeAmount1 = TrackingIDChargeAmount1
lcTrackingIDChargeDescription2 = Alltrim(TrackingIDChargeDescription2)
lcTrackingIDChargeAmount2 = TrackingIDChargeAmount2
lcTrackingIDChargeDescription3 = Alltrim(TrackingIDChargeDescription3)
lcTrackingIDChargeAmount3 = TrackingIDChargeAmount3
lcTrackingIDChargeDescription4 = Alltrim(TrackingIDChargeDescription4)
lcTrackingIDChargeAmount4 = TrackingIDChargeAmount4
lcTrackingIDChargeDescription5 = Alltrim(TrackingIDChargeDescription5)
lcTrackingIDChargeAmount5 = TrackingIDChargeAmount5
lcTrackingIDChargeDescription6 = Alltrim(TrackingIDChargeDescription6)
lcTrackingIDChargeAmount6 = TrackingIDChargeAmount6
lcTrackingIDChargeDescription7 = Alltrim(TrackingIDChargeDescription7)
lcTrackingIDChargeAmount7 = TrackingIDChargeAmount7
lcTrackingIDChargeDescription8 = Alltrim(TrackingIDChargeDescription8)
lcTrackingIDChargeAmount8 = TrackingIDChargeAmount8
lcTrackingIDChargeDescription9 = Alltrim(TrackingIDChargeDescription9)
lcTrackingIDChargeAmount9 = TrackingIDChargeAmount9
lcTrackingIDChargeDescription10 = Alltrim(TrackingIDChargeDescription10)
lcTrackingIDChargeAmount10 = TrackingIDChargeAmount10
lcTrackingIDChargeDescription11 = Alltrim(TrackingIDChargeDescription11)
lcTrackingIDChargeAmount11 = TrackingIDChargeAmount11
lcTrackingIDChargeDescription12 = Alltrim(TrackingIDChargeDescription12)
lcTrackingIDChargeAmount12 = TrackingIDChargeAmount12
lcTrackingIDChargeDescription13 = Alltrim(TrackingIDChargeDescription13)
lcTrackingIDChargeAmount13 = TrackingIDChargeAmount13
lcTrackingIDChargeDescription14 = Alltrim(TrackingIDChargeDescription14)
lcTrackingIDChargeAmount14 = TrackingIDChargeAmount14
lcTrackingIDChargeDescription15 = Alltrim(TrackingIDChargeDescription15)
lcTrackingIDChargeAmount15 = TrackingIDChargeAmount15
lcTrackingIDChargeDescription16 = Alltrim(TrackingIDChargeDescription16)
lcTrackingIDChargeAmount16 = TrackingIDChargeAmount16
lcTrackingIDChargeDescription17 = Alltrim(TrackingIDChargeDescription17)
lcTrackingIDChargeAmount17 = TrackingIDChargeAmount17
lcTrackingIDChargeDescription18 = Alltrim(TrackingIDChargeDescription18)
lcTrackingIDChargeAmount18 = TrackingIDChargeAmount18
lcTrackingIDChargeDescription19 = Alltrim(TrackingIDChargeDescription19)
lcTrackingIDChargeAmount19 = TrackingIDChargeAmount19
lcTrackingIDChargeDescription20 = Alltrim(TrackingIDChargeDescription20)
lcTrackingIDChargeAmount20 = TrackingIDChargeAmount20
lcTrackingIDChargeDescription21 = Alltrim(TrackingIDChargeDescription21)
lcTrackingIDChargeAmount21 = TrackingIDChargeAmount21
lcTrackingIDChargeDescription22 = Alltrim(TrackingIDChargeDescription22)
lcTrackingIDChargeAmount22 = TrackingIDChargeAmount22
lcTrackingIDChargeDescription23 = Alltrim(TrackingIDChargeDescription23)
lcTrackingIDChargeAmount23 = TrackingIDChargeAmount23
lcTrackingIDChargeDescription24 = Alltrim(TrackingIDChargeDescription24)
lcTrackingIDChargeAmount24 = TrackingIDChargeAmount24
lcTrackingIDChargeDescription25 = Alltrim(TrackingIDChargeDescription25)
lcTrackingIDChargeAmount25 = TrackingIDChargeAmount25
lcShipmentNotes = Alltrim(ShipmentNotes)
If SQLExec(lnH, lcInsertSql) < 1
	Aerror(aa)
	Throw (aa[2])
	Return .F.
Endif
**?lcExpressOrGroundTrackingID , " added"
Return .T.
Endfunc
**************************************************
Function CheckIfRecordExist
TEXT TO lcCheckSql NOSHOW TEXTMERGE
SELECT TOP 1 InvoiceNumber, ExpressOrGroundTrackingID from Fedex.Invoices
where InvoiceNumber = ?lcInvoiceNumber
and ExpressOrGroundTrackingID  = ?lcExpressOrGroundTrackingID
ENDTEXT
lcInvoiceNumber  = Alltrim(InvoiceNumber)
lcExpressOrGroundTrackingID = Alltrim(ExpressOrGroundTrackingID)
If Used('curCheck')
	Use In curCheck
Endif
If SQLExec(lnH, lcCheckSql,'curCheck') < 1
	Aerror(aa)
	Throw aa[2]
	Return
Endif
If Reccount('curCheck') > 0
	Return .T.
Endif
Return .F.
Endfunc
******************************
FUNCTION InsertChargeRecord
TEXT TO lcCheckChargeExists NOSHOW TEXTMERGE
SELECT * FROM Fedex.ChargeDetails 
where  InvoiceNumber = ?lcInvoiceNumber
and Tracking  = ?lcTracking
and  Chargetype = ?lcChargeType
and Amount = ?lnAmount
ENDTEXT
TEXT TO lcInsertChargeSql NOSHOW TEXTMERGE
INSERT INTO Fedex.ChargeDetails (InvoiceNumber, Tracking, ChargeType, Amount)
values (?lcInvoiceNumber, ?lcTracking, ?lcChargetype, ?lnAmount)
ENDTEXT

SELECT curCharges
lcInvoiceNumber = ALLTRIM(InvoiceNumber)
lcTracking = ALLTRIM(tracking)
lcChargeType = ALLTRIM(ChargeType)
lnAmount = Amount 
IF USED('curCheckRecord')
USE IN curCheckRecord
ENDIF
If SQLExec(lnH, lcCheckChargeExists ,'curCheckRecord') < 1
	Aerror(aa)
	Throw aa[2]
	RETURN .f.
ENDIF

If Reccount('curCheckRecord') > 0
	**?lcTracking, lcChargeType, lnAmount, "Charge EXISTS"
ELSE
If SQLExec(lnH, lcInsertChargeSql ) < 1
	Aerror(aa)
	Throw aa[2]
	RETURN .f.
	ELSE 
	RETURN .t.
	**?lcTracking, lcChargeType, lnAmount, "Charge ADDED"
Endif
ENDIF

SELECT curCharges
RETURN .t. 

ENDFUNC 
