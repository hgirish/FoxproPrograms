*!*	Shows nubers of records in every table in SQL database

Local lnH, lcSql
*!* Modify below connection string as appropriate
lnH = Sqlstringconnect("Server=.\SqlExpress;Database=MyDb;Trusted_Connection=True;",.T.)

TEXT TO lcSql NOSHOW TEXTMERGE
SELECT t.name, s.row_count from sys.tables t
JOIN sys.dm_db_partition_stats s
ON t.object_id = s.object_id
AND t.type_desc = 'USER_TABLE'
AND t.name not like '%dss%'
AND s.index_id = 1
order by name
ENDTEXT


If SQLExec(lnH, lcSql, 'curRecordCounts') < 1
	Aerror(aa)
	Messagebox(aa[2])
	Return
Endif

Browse

Return
