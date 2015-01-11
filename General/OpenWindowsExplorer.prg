*** Open windows explorer from Foxpro in Current Directory
LOCAL loshell as Shell32.application
loshell = CREATEOBJECT('shell.application')
loShell.Explore(FULLPATH(CURDIR()))
loShell = null