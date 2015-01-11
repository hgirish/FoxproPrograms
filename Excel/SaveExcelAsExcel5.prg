** Saves The Excel document as Excel 5 document
** as filename_5.xls 
Local lcx, lcfname, lcsave, loExcel, lowb

lcx = Getfile('xls')

lcfname = JUSTFNAME(lcx)

lcsave = FULLPATH(CURDIR()) +lcfname + '_5.xls'
loExcel = CREATEOBJECT("Excel.Application")
lowb = loExcel.Workbooks.Open(lcx)
lowb.SaveAs(lcsave, 39) && xlExcel5 = 39
loexcel.Quit()
loexcel = null