clear all
clc

sensorIDs = [400468; 400739; 400363; 400698];
startTime = 4;
endTime = 5.5;

startIndex = (startTime * 3600)/30 + 1;
endIndex = (endTime * 3600)/30 + 1;

col=str2mat('r', 'g', 'b', 'k', 'y');

figure
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\sensorData_version5\' num2str(sensorID) '.mat']);
    plot(densityDataSum(startIndex:endIndex), [col(i)]);
    hold on
end

xlabel('time');
ylabel('flow');
legend(num2str(sensorIDs));
hold off

saveas(gcf, ['.\Plots\densityPlotOfSensors_' num2str(startTime) '_' num2str(endTime) '.pdf']);
saveas(gcf, ['.\Plots\densityPlotOfSensors_' num2str(startTime) '_' num2str(endTime) '.fig']);
saveas(gcf, ['.\Plots\densityPlotOfSensors_' num2str(startTime) '_' num2str(endTime) '.eps'], 'epsc');