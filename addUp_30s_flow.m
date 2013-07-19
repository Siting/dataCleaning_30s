% add up data to the scale of 30 seconds
% a day has 2880 entries of data
clear all
clc

sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'sensorData_version1';
newSensorDataFolder = 'sensorData_version2';

for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);    
    load([sensorDataFolder '\' num2str(sensorID)]);

    if size(flowDataSum,1) == 5760
        flowDataSum_30s = [];
        flowDataLanes_30s = [];
        for row = 1 : 4 : (size(flowDataSum,1))
            % add up data for each miniute
            dataSum_30s = sum(flowDataSum(row:row+3));
            dataLanes_30s = sum(flowDataLanes(row:row+3));
            % duplicate the data and take half of 1 min
            flowDataSum_30s = [flowDataSum_30s; dataSum_30s/2; dataSum_30s/2];
            flowDataLanes_30s = [flowDataLanes_30s; dataLanes_30s/2; dataLanes_30s/2];
        end
    elseif size(flowDataSum,1) == 2880        
        flowDataSum_30s = [];
        flowDataLanes_30s = [];
        for row = 1 : 2 : (size(flowDataSum,1))
            % add up data for each miniute
            dataSum_30s = sum(flowDataSum(row:row+1));
            dataLanes_30s = sum(flowDataLanes(row:row+1));
            % duplicate the data and take half of 1 min
            flowDataSum_30s = [flowDataSum_30s; dataSum_30s/2; dataSum_30s/2];
            flowDataLanes_30s = [flowDataLanes_30s; dataLanes_30s/2; dataLanes_30s/2];
        end
    end
    
    flowDataSum = flowDataSum_30s;
    flowDataLanes = flowDataLanes_30s;
    save([num2str(newSensorDataFolder) '\' num2str(sensorID)], 'flowDataSum', 'flowDataLanes');
end