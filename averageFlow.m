clear all
clc

deltaT = 2; % unit: second
dataInterval = 0.5;  % unit: min
c = dataInterval*60/deltaT;
sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'sensorData_version2';
newSensorDataFolder = ['sensorData_version4_' num2str(deltaT) 's'];

for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\' num2str(sensorDataFolder) '\' num2str(sensorID) '.mat']);  
    flowDataSum = flowDataSum ./ c;
    save([num2str(newSensorDataFolder) '\' num2str(sensorID)], 'flowDataSum');
end

