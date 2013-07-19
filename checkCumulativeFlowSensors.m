clear all
clc

sensorIDs = [400468; 402955; 402953; 402954; 402950; 400698];

% load sensor data
flowCollection = [];
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\sensorData_version4_2s\' num2str(sensorID) '.mat']);
    flowCollection = [flowCollection flowDataSum];
end

upStream = flowCollection(:,1) + flowCollection(:,2) - flowCollection(:,3) +...
    flowCollection(:,4) - flowCollection(:,5);
downStream = flowCollection(:,6);

% load optimized downstreamData
load(['.\sensorData_version3\' num2str(sensorIDs(end)) '.mat']);
downStream_opt = flowDataSum;

% get cumulative flows
upStream_cumu = cumsum(upStream);
downStream_cumu = cumsum(downStream);
downStream_opt_cumu = cumsum(downStream_opt);

figure
plot(upStream, 'r.');
hold on
plot(downStream, 'k.');
% plot(downStream_opt, 'g.');


figure
plot(upStream_cumu, 'r');
hold on
plot(downStream_cumu, 'k');
% plot(downStream_opt_cumu, 'g');
