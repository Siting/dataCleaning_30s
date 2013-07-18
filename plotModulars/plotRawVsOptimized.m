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
    subplot(2,2,i)
    sensorID = sensorIDs(i);
    load(['.\sensorData_version3\' num2str(sensorID) '.mat']);
    plot(flowDataSum(startIndex:endIndex), 'r.');
    hold on
    load(['.\sensorData_version2\' num2str(sensorID) '.mat']);
    plot(flowDataSum(startIndex:endIndex), 'k.');
    title(['sensor' num2str(sensorID)]);
    legend('optimized', 'raw');
    xlabel('time');
    ylabel('flow');
end

saveas(gcf, ['.\Plots\RawVsOptimizedFlows_' num2str(startTime) '_' num2str(endTime) '.pdf']);
saveas(gcf, ['.\Plots\RawVsOptimizedFlows_' num2str(startTime) '_' num2str(endTime) '.fig']);
saveas(gcf, ['.\Plots\RawVsOptimizedFlows_' num2str(startTime) '_' num2str(endTime) '.eps'], 'epsc');