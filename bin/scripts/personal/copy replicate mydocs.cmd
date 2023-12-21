copy "C:\Documents and Settings\Administrator\My Documents\GasLogs - master\*" "\\300gl\c$\Documents and Settings\Administrator\My Documents\Gas Logs" /Y

now >> "GASLOG REPLICATION.LOG"
fc "C:\Documents and Settings\Administrator\My Documents\GasLogs - master\*" "\\300gl\c$\Documents and Settings\Administrator\My Documents\Gas Logs\*" >> "GASLOG REPLICATION.LOG"

