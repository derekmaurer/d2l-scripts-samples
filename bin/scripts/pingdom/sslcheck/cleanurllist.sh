awk 'NR==FNR{arr[$1];next}!($1 in arr)' FS=":"  badurls.txt urllist.txt