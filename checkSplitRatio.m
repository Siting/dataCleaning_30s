clear all
clc

sensorIDs = [400468; 402955; 402953; 400739;];

% load sensor data
flowCollection = [];
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\sensorData_version6_2s\' num2str(sensorID) '.mat']);
    flowCollection = [flowCollection flowDataSum];
end

incoming(:,1) = flowCollection(:,1) + flowCollection(:,2);
outgoing(:,1) = flowCollection(:,3);

splitRatio = outgoing(:,1) ./ incoming(:,1);
a = splitRatio(find(0<=splitRatio<=1));
b = a(find(isinf(a)==0));

mean(b)
mean(b(960:1200))
figure
plot(b)
saveas(gcf, ['.\Plots\splitRatio_realTime.pdf']);

figure
hist(b)
saveas(gcf, ['.\Plots\splitRatio.pdf']);
