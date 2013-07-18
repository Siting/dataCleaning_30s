clear all
clc

sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'sensorData_version2';
newSensorDataFolder = 'sensorData_version3';
daySum = [];
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\' num2str(sensorDataFolder) '\' num2str(sensorID) '.mat']);
    s = sum(flowDataSum);
    daySum = [daySum s];
end

beq(1) = -(daySum(1)+daySum(2)-daySum(3))+daySum(4);
beq(2) = -(daySum(4)+daySum(5))+daySum(6);
beq(3) = -(daySum(6)+daySum(7))+daySum(8);
b0 = [5,5,5,5];
Aeq = [1/3 -0.5 0 0; 0 1 -0.5 0; 0 0 1 -1];
beq = [beq(1); beq(2); beq(3)];
lb = [0; 0; 0; 0];

% compute the bias
b = fmincon(@smallNetwork,b0,[],[],Aeq,beq,lb,[]);


% modify the flow
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\' num2str(sensorDataFolder) '\' num2str(sensorID) '.mat']);
    
    if i == 1 || i == 2 || i == 3
       flowDataSum =  flowDataSum .* (1 + b(1)/3/daySum(i));
       flowDataLanes =  flowDataLanes .* (1 + b(1)/3/daySum(i));
    end
    
    if i == 4 || i == 5
        flowDataSum =  flowDataSum .* (1 + b(2)/2/daySum(i));
        flowDataLanes =  flowDataLanes .* (1 + b(2)/2/daySum(i));
    end
    
    if i == 6 || i == 7
        flowDataSum =  flowDataSum .* (1 + b(3)/2/daySum(i));
        flowDataLanes =  flowDataLanes .* (1 + b(3)/2/daySum(i));
    end
    
    if i == 8
        flowDataSum = flowDataSum + b(4);
        flowDataLanes =  flowDataLanes + b(4);
    end
    
    save([num2str(newSensorDataFolder) '\' num2str(sensorID)], 'flowDataSum', 'flowDataLanes');
end
