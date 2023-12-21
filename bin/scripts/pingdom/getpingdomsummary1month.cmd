@echo " " >> summary.txt
@echo %1 >> summary.txt
@curl -H "App-Key: 0qncr144bzrqfekc3tujjgrcyyd9sk13" -u "d2lvendorsupport@desire2learn.com:g3MTJhYzY5ND" "https://api.pingdom.com/api/2.0/summary.average/%1?from=1354341600&to=1357020000" >> summary.txt

