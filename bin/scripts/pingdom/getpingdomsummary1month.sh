startdate=`date -d "Jan 1 2013" +%s`
enddate=`date -d "Feb 1 2013" +%s`
header='App-Key: 0qncr144bzrqfekc3tujjgrcyyd9sk13'
user='d2lvendorsupport@desire2learn.com:g3MTJhYzY5ND'
URL='https://api.pingdom.com/api/2.0/summary.average/'$1'?from='$startdate'&to='$enddate''

#echo $header
#echo $user
#echo $URL
echo '' >> summary.txt
echo $1 >> summary.txt
`curl -H "$header" -u "$user" "$URL" >> summary.txt`
#echo "curl -H $header -u $user $URL >> summary.txt"

