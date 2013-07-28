function[flowDataLanes, flowDataSum] = loadSensorData(sensorID, sensorDataFolder)
% input: sensorID & the folder sensor data is in

[num,txt,raw] = xlsread(['.\' sensorDataFolder '\' num2str(sensorID)]);
% compute # lanes of the link
if strcmp(sensorDataFolder, 'occupancy')
    numLanes = (size(txt,2)-1);
else
    numLanes = (size(txt,2)-1) / 2;
end
% extract flow data for each lane
flowDataLanes = num(:, 1: numLanes);
flowDataSum = sum(flowDataLanes,2);
