% add up data to the scale of 30 seconds
% a day has 2880 entries of data
clear all
clc

sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'sensorOccuData_mat';
newSensorDataFolder = 'sensorOccuData_version1';

for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);    
    load([sensorDataFolder '\' num2str(sensorID)]);

    if size(occuDataSum,1) == 5760

        occuDataSum_30s = [];
        occuDataLanes_30s = [];
        for row = 1 : 4 : (size(occuDataSum,1))
            % add up data for each miniute
            dataSum_30s = sum(occuDataSum(row:row+3));
            dataLanes_30s = sum(occuDataLanes(row:row+3),1);
            % duplicate the data and take half of 1 min
            occuDataSum_30s = [occuDataSum_30s; dataSum_30s/2; dataSum_30s/2];
            occuDataLanes_30s = [occuDataLanes_30s; dataLanes_30s/2; dataLanes_30s/2];
        end
    elseif size(occuDataSum,1) == 2880

        occuDataSum_30s = [];
        occuDataLanes_30s = [];
        for row = 1 : 2 : (size(occuDataSum,1))
            % add up data for each miniute
            dataSum_30s = sum(occuDataSum(row:row+1));
            dataLanes_30s = sum(occuDataLanes(row:row+1),1);
            % duplicate the data and take half of 1 min
            occuDataSum_30s = [occuDataSum_30s; dataSum_30s/2; dataSum_30s/2];
            occuDataLanes_30s = [occuDataLanes_30s; dataLanes_30s/2; dataLanes_30s/2];
        end
    end
    
    occuDataSum = occuDataSum_30s;
    occuDataLanes = occuDataLanes_30s;
    save([num2str(newSensorDataFolder) '\' num2str(sensorID)], 'occuDataSum', 'occuDataLanes');
end