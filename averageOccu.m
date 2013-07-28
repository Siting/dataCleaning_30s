clear all
clc

deltaT = 2; % unit: second
dataInterval = 1;  % unit: min
c = dataInterval*60/deltaT;
sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'sensorOccuData_version1';
newSensorDataFolder = 'sensorOccuData_version2';

for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\' num2str(sensorDataFolder) '\' num2str(sensorID) '.mat']);  
    occuDataSum = occuDataSum ./ c;
    occuDataLanes = occuDataLanes ./ c;
    save([num2str(newSensorDataFolder) '\' num2str(sensorID)], 'occuDataSum', 'occuDataLanes');
end

