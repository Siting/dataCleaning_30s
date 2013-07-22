clear all
clc

deltaT = 2; % unit: second
oneHour = 1; % unit: hr
c = oneHour * 3600 / deltaT;  % amplify
sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = ['sensorData_version6_' num2str(deltaT) 's'];
newSensorDataFolder = 'sensorData_version7';

for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\' num2str(sensorDataFolder) '\' num2str(sensorID) '.mat']);  
    flowDataSum = flowDataSum .* c;
    save([num2str(newSensorDataFolder) '\' num2str(sensorID)], 'flowDataSum');
end