curl -H "App-Key: 0qncr144bzrqfekc3tujjgrcyyd9sk13" -u "d2lvendorsupport@desire2learn.com:g3MTJhYzY5ND" "https://api.pingdom.com/api/2.0/checks" > pingdom_checks.txt

sed -e "s/\"\,\"/\n/g" pingdom_checks.txt | grep hostname | sed -e "s/hostname\"\:\"//g" > urllist.txt

bash cleanurllist.sh > urllist_clean.txt

sed -e "s/$/\ 443/g"  urllist_clean.txt > urllist_clean_ports.txt 

