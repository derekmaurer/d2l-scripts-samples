-- add new servers to servers table 
INSERT INTO tblServers (ServerName)
SELECT RIGHT(Col001, LEN(Col001) - 1)
FROM tblTempServerDetails
WHERE RIGHT(Col001, LEN(Col001) - 1) not in (SELECT TPS.ServerName FROM tblServers AS TPS) 

TRUNCATE TABLE  tblTempServerDetails

GO 

BULK INSERT adminblog2..tblTempServerDetails
	FROM 'C:\bin\system_info\servers_info.txt'	
	WITH 
	( 
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '","',
	 ROWTERMINATOR = '\n') 

GO

TRUNCATE TABLE tblServersDetails

GO 

INSERT INTO tblServersDetails(ServerId, OSName, OSVersion, OSManufacturer, OSConfiguration, 
OSBuildType, RegisteredOwner, RegisteredOrganization, ProductId, OriginalInstallDate, 
SystemUpTime, SystemManufacturer, SystemModel, SystemType, Processors, BIOSVersion,
WIndowsDirectory, SystemDirectory, BootDevice, SystemLocale, InputLocale, Timezone, TotPhysMem, AvailPhysMem, 
PageFileMaxSize, PageFileAvail, PageFileInUse, PageFileLocation, Domain, LogonServer, 
Hotfixes, NetworkCards )
SELECT TPS.ServerId, Col002, Col003, Col004, Col005, Col006, Col007, Col008, Col009, Col010,  Col011, 
Col012, Col013, Col014, col015, col016, Col017, Col018, Col019, Col020, Col021,
Col022, Col023, Col024, Col025, Col026, Col027, Col028, Col029, Col030, Col031, Col032
FROM tblServers AS TPS
INNER JOIN tblTempServerDetails
ON TPS.ServerName = RIGHT(Col001, LEN(Col001) - 1)
--And Col001 NOT IN (Select ServerName from tblServers) 
WHERE TPS.ServerID NOT IN (SELECT ServerId From tblServersDetails) -- this is so only so new
								   -- server info is added
ORDER BY TPS.ServerId


--- update existing server information 

UPDATE tblServersDetails 
Set OSName = Col002, 
OSVersion = Col003,
OSManufacturer = Col004, 
OSConfiguration= Col005, 
OSBuildType = Col006, 
RegisteredOwner = Col007, 
RegisteredOrganization = Col008, 
ProductId= Col009, 
OriginalInstallDate= Col010,  
SystemUpTime = Col011, 
SystemManufacturer = Col012,
SystemModel = Col013, 
SystemType = Col014, 
Processors = col015,
BIOSVersion = col016, 
WIndowsDirectory = Col017, 
SystemDirectory = Col018, 
BootDevice = Col019, 
SystemLocale = Col020, 
InputLocale = Col021,
Timezone = Col022, 
TotPhysMem = Col023, 
AvailPhysMem = Col024, 
PageFileMaxSize = Col025, 
PageFileAvail = Col026, 
PageFileInUse = Col027, 
PageFileLocation = Col028, 
Domain = Col029, 
LogonServer = Col030, 
Hotfixes = Col031, 
NetworkCards = Col032
FROM tblServersDetails SD
JOIN tblServers TS
ON TS.ServerId = SD.ServerId
JOIN  tblTempServerDetails TSD
ON TS.ServerName = RIGHT(Col001, LEN(Col001) - 1)