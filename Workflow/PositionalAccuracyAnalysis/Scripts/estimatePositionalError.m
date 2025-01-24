function error = estimatePositionalError(NameValueArgs)
arguments
    NameValueArgs.logsout
    NameValueArgs.trajectory
    NameValueArgs.errorPlotTitle char
end
% This function plots the circle radius positional error and also the 
% target and printed circular shape.

% Copyright 2024 The MathWorks, Inc.

xSample = resample(NameValueArgs.logsout.getElement("<Xp (m)>").Values,NameValueArgs.trajectory.time);
ySample = resample(NameValueArgs.logsout.getElement("<Yp (m)>").Values,NameValueArgs.trajectory.time);

indicesPoints = linspace(109,973,865);
count = 1;
for i = 1:length(xSample.Data)
    if any(i == indicesPoints)
        xPrinted(count) = xSample.Data(i);
        yPrinted(count) = ySample.Data(i);
        xTarget(count) = NameValueArgs.trajectory.pathX(i);
        yTarget(count) = NameValueArgs.trajectory.pathY(i);
        rTarget(count) = sqrt((xTarget(count)-NameValueArgs.trajectory.offsetX).^2 + (yTarget(count)).^2); %+NameValueArgs.trajectory.offsetX
        rPrinted(count) = sqrt((xPrinted(count)-NameValueArgs.trajectory.offsetX).^2 + (yPrinted(count)).^2); %+NameValueArgs.trajectory.offsetX
        rError(count) = rPrinted(count) - rTarget(count);
        rErrorMM(count) = 1000*rError(count); % Convert error to mm
        indicesCircle(count) =  count;
        count = count + 1;
    end
end

angleDeg = linspace(0,360-360/size(indicesCircle,2),size(indicesCircle,2));

disp('Plotting positional error in mm for 3D-printed circle')
figure;
plot(angleDeg,rErrorMM,LineWidth=1)
title(NameValueArgs.errorPlotTitle)
xlabel('Angle with X-axis (deg)') 
ylabel('Radial positional error (mm)') 
grid on
xlim([0 360])

errorRMS = 1000*rmse(rTarget,rPrinted); % Convert error to mm
errorMax = max(abs(rErrorMM));

error.angle = angleDeg;
error.rError = rErrorMM;
error.RMS = errorRMS;
error.max = errorMax;





