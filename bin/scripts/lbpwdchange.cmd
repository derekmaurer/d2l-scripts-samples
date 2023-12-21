grep monitor startConfig.cfg.zeus  | sed -e "s/username\=.*/username\=monitor\&password\=/" | sort | uniq | sed -e "s/\?func\=/\\\?func\=/" > lbpwdchange.txt
