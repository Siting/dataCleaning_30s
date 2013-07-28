clear all
clc

sensorIDs = [400468; 402955; 402953; 400739; 402954; 400363; 402950; 400698];

% load sensor data
flowCollection = [];
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    load(['.\sensorData_version6_2s\' num2str(sensorID) '.mat']);
    flowCollection = [flowCollection flowDataSum];
end

upStream(:,1) = flowCollection(:,1) + flowCollection(:,2) - flowCollection(:,3);
downStream(:,1) = flowCollection(:,4);

upStream(:,2) = flowCollection(:,4) + flowCollection(:,5);
downStream(:,2) = flowCollection(:,6);

upStream(:,3) = flowCollection(:,6) + flowCollection(:,7);
downStream(:,3) = flowCollection(:,8);


% get cumulative flows
upStream_cumu = cumsum(upStream,1);
downStream_cumu = cumsum(downStream,1);


for i = 1 : size(upStream_cumu,2)
    figure
    plot(upStream_cumu(:,i), 'r');
    hold on
    plot((3:2+size(downStream,1)),downStream_cumu(:,i), 'k');
    plot((3:2+size(downStream,1)),upStream_cumu(:,i), 'b');
    xlabel('time');
    ylabel('cumulative flow on 2s time scale');
    legend('upstream', 'downstream','expected');
    saveas(gcf, ['.\Plots\cumulativeFlow' num2str(i) '.pdf']);
    saveas(gcf, ['.\Plots\cumulativeFlow' num2str(i) '.fig']);
    saveas(gcf, ['.\Plots\cumulativeFlow' num2str(i) '.eps'], 'epsc');
end

