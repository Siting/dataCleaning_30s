% transfer excel sensor data into mat file
% add flows across lanes ==> flowDataSum
clear all
clc

sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'sensorData';

% load sensor data
dataCollection = [];
cumulativeFlows = [];
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    [flowDataLanes, flowDataSum] = loadSensorData(sensorID, sensorDataFolder);    
    save(['sensorData_mat\' num2str(sensorID)], 'flowDataSum', 'flowDataLanes');
end