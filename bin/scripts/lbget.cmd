@echo off

scp dmaurer@zeus:startconfig .
ren startConfig.cfg startConfig.cfg.zeus

scp dmaurer@poseidon:startconfig .
ren startConfig.cfg startConfig.cfg.poseidon

grep -n "health\|&username" startConfig.cfg.zeus | grep -v port | grep -v boolean | sed s/\?/\\\?/g | sed s/password=.*/password=/g | sed "s/\:/\:\ /g" | sed "s/^.:/00\0/g" | sed "s/^..:/0\0/g" | sed "s/\ \ \ /\ /g" > lbpwds.txt


rem grep "health\|&username" startConfig.cfg.zeus | grep -v port | sed s/\?/\\\?/g | sed s/password=.*/password=/g | sort | uniq > lbpwds.txt
