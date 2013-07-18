% SMALL network
% cut flow value to half except for the last sensor
clear all
clc

sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'sensorData_mat';
newSensorDataFolder = 'sensorData_version1';

for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load([sensorDataFolder '\' num2str(sensorID)]);
    
    % cut half
    if i <= (length(sensorIDs) -1)
        flowDataSum = flowDataSum ./ 2;
        flowDataLanes = flowDataLanes ./ 2;
    end
    
    save([num2str(newSensorDataFolder) '\' num2str(sensorID)], 'flowDataSum', 'flowDataLanes');
end

