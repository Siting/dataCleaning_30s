% check shape of fundamental diagram
clear all
clc

sensorIDs = [400468; 400698];
sensorDataFolder1 = 'sensorData_version2';   % for optimizaed 30s sensor data
sensorDataFolder2 = 'sensorData';            % for speed
newSensorDataFolder = 'sensorData_version5';
keyboard
for i = 1 : length(sensorIDs)
    sensorID = sensorIDs(i);
    [num,txt,raw] = xlsread(['.\' sensorDataFolder2 '\' num2str(sensorID)]);
    load([sensorDataFolder1 '\' num2str(sensorID)]);

    % compute # lanes of the link
    numLanes = (size(txt,2)-1) / 2;
    % extract speed data
    speedDataLanes = num(:, (numLanes+1):end);
    % compute density
    densityLanes = flowDataLanes .* 60 .* 2 ./ speedDataLanes;  % 60 * 2 ==> 30s to hr    
    % compute density across all lanes (get sum)
    densityDataSum = sum(densityLanes,2);

    for j = 1 : size(densityDataSum,1)
        if isnan(densityDataSum(j)) && j >= 4 && j <= size(densityDataSum,1)

            dataWindow = densityDataSum(j-3 : j+3);
            densityDataSum(j) = mean(dataWindow(isnan(dataWindow)==0));
        elseif isnan(densityDataSum(j)) && j < 4
            dataWindow = densityDataSum(j+1: j+4);
            densityDataSum(j) = mean(dataWindow(isnan(dataWindow)==0));
        end
    end
    
    densityDataSum = smooth(densityDataSum);
  
    if any(densityDataSum<0)
        densityDataSum(densityDataSum<0) = 0 ;
    end
    
    save([num2str(newSensorDataFolder) '\' num2str(sensorID)], 'densityDataSum');
    

    figure
    for j = 1 : size(densityLanes,2)
        plot(densityLanes(:,j),flowDataLanes(:,j),'.');
        hold on
    end
    hold off
    xlabel('density');
    ylabel('flow')
    title(['flow-speed plot of sensor ' num2str(sensorID)]);
    
    saveas(gcf, ['.\plots\funda_' num2str(sensorID) '.pdf']);
end