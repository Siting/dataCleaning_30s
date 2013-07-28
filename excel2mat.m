% transfer excel sensor data into mat file
% add flows across lanes ==> flowDataSum
clear all
clc

sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'occupancy';

% load sensor data
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    [occuDataLanes, occuDataSum] = loadSensorData(sensorID, sensorDataFolder);    
    save(['sensorOccuData_mat\' num2str(sensorID)], 'occuDataLanes', 'occuDataSum');
end

