rem set USERPROFILE=C:\bin\scripts\AWS

aws --profile aws-saas-dmaurer ec2 start-instances --instance-ids i-6a1fb167 i-aae6fe5e i-abe6fe5f i-b4e6fe40 i-b5e6fe41 i-b6e6fe42 i-c3ec2535

aws --profile aws-saas-dmaurer ec2 describe-instances --instance-ids i-6a1fb167 i-aae6fe5e i-abe6fe5f i-b4e6fe40 i-b5e6fe41 i-b6e6fe42 i-c3ec2535 --filters "Name=tag:Owner,Values=HussainTest" | grep "Name\|INSTANCES"




