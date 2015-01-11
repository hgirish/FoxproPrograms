*!* Demo showing how to use  AdoDB with Excel

*!* Credits to following resources
** http://www.motobit.com/tips/detpg_listdb/
** http://www.ericphelps.com/scripting/samples/Reference/CGI_DB/AdoExcelRead.txt
** http://allenbrowne.com/func-ado.html

CLEAR
lcxls = GETFILE('xls?')

CREATE CURSOR curtemp (col1 c(50), col2 c(50), col3 c(50))

cn = CREATEOBJECT("adodb.connection")
cn.Provider = "Microsoft.ACE.OLEDB.12.0;"
cn.ConnectionString = "Data Source=" + lcxls+ ";Extended Properties=Excel 12.0 Xml;"
cn.Open()
rst = cn.OpenSchema(20)
lcSheetName = rst.Fields[2].value
lcType = rst.Fields[3].value
rst.close()

qry = "SELECT * FROM [" + lcSheetName + "]"
rs = CreateObject("ADODB.recordset")
rs.Open(qry,cn)
rs.movefirst()
DO WHILE !rs.EOF
lcCol1 = TRANSFORM(rs.Fields[0].value)
lcCol2 = TRANSFORM(rs.Fields[1].value)
lcCol3 = TRANSFORM(rs.Fields[2].value)
INSERT INTO curtemp(col1, col2, col3) values(lcCol1, lcCol2, lcCol3)
rs.movenext()
ENDDO