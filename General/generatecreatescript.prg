*!* Returns CreateCursor script for current table alias
*!' Optional parameter: cursorName you want to create
Function GenerateCreateScript
Lparameters tcCursor
Local Array aa[1]
Local lcAlias, lcCursor, lnFields, lcsql, lcfield, lcType, lnlen, lnDecimal, lnI, lcFile
lcAlias = Alias()
If Empty(lcAlias)
	Return ''
Endif

If Empty(tcCursor) Or Vartype(tcCursor) # 'C'
	lcCursor = SYS(2015)
Else
	lcCursor = tcCursor
Endif
lnFields = Afields(aa)

lcsql = [ create cursor ] + lcCursor + [ (]
For lnI = 1 To lnFields
	lcfield = aa[lni, 1]
	lcType = aa[lni, 2]
	lnlen = aa[lni, 3]
	lnDecimal = aa[lni, 4]
	lcsql = lcsql + lcfield + ' ' + lcType + [(] + Transform(lnlen)
	If lnDecimal > 0
		lcsql = lcsql + [,] + Transform(lnDecimal)
	Endif
	lcsql = lcsql + [)]
	If lnI = lnFields
		lcsql = lcsql +[ ;] + Chr(13) + Chr(10) + [)]
	Else
		lcsql = lcsql + [ ;] + Chr(13) + Chr(10) + [, ]
	Endif
Endfor
lcFile = Sys(2015) + '.txt'
Strtofile(lcsql, lcFile)
Modify File (lcFile)
Return lcsql
Endfunc
