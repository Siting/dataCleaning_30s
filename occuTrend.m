clear all
clc

sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];
sensorDataFolder = 'sensorOccuData_version2';

for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\' sensorDataFolder '\' num2str(sensorID) '.mat']);
    figure
    for j = 1 : size(occuDataLanes,2)
        plot(occuDataLanes(:,j));
        hold on
    end
    title(['sensor ' num2str(sensorID)]);
    hold off
    
    saveas(gcf, ['.\Plots\occuTrend_' num2str(sensorID) '.pdf']);
    saveas(gcf, ['.\Plots\occuTrend_' num2str(sensorID) '.fig']);
    saveas(gcf, ['.\Plots\occuTrend_' num2str(sensorID) '.eps'], 'epsc');
end
