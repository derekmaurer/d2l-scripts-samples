c:\bin\unix\sed s/\@schawk.com/\@schawk.wwteam.com/ %1opentext.ini > %1opentext.ini.new
copy %1opentext.ini %12006-01-29.opentext.ini
copy %1opentext.ini.new %1opentext.ini
c:\bin\grep @schawk %1\opentext.ini