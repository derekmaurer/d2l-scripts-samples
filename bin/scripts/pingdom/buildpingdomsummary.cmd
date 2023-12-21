rem @echo off

curl -H "App-Key: 0qncr144bzrqfekc3tujjgrcyyd9sk13" -u "d2lvendorsupport@desire2learn.com:g3MTJhYzY5ND" "https://api.pingdom.com/api/2.0/checks" > pingdom_checks.txt
sed -e 's/"id":/\n/g' pingdom_checks.txt | sed -e 's/,.created.:.*hostname.:./,/' | sed -e 's/.,.resolution..*$//g' | grep "," | sort > idsitelist.csv

for /f "tokens=1 delims=[,]" %%a in (idsitelist.csv) do (
	@echo Processing %%a...
	bash getpingdomsummary1month.sh %%a
	)

rem ### tr -d '\n$'  < summary.txt | tr -d '\r' > sum2
rem ### sed -e 's/\"\ \"/\n/g' sum2 > sum3
rem ### sed -e 's/ //g;s/{\"su.*from\"\:/,/g;s/\"to\"://g;s/\"avgresponse\"://g;s/}*$//g' sum3 | sort > sum4

bash summtocsv.sh

bash sedfilter.sh

sed -f idsitelist.sed summ.csv > summary.csv

rem #### c:\bin\scripts\pingdom>type summary.txt | sed -e 's/$/,/g;s/ //g' | tr -d "\n" | sed -e 's/\}\}\}\"\",/\n/g;s/\}\}\},//g;s/\"\",//g' | sed -e 's/,{"summary":{"responsetime":{"from"://;s/"to"://;s/"avgresponse"://' | sed -f idsitelist.sed > summary.csv



