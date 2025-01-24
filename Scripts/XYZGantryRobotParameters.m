% This code loads the parameters for the XYZCartesianRobot3DPrinting model.

% Copyright 2024 The MathWorks, Inc.

%% Load parameters for Cartesian Robot
% Columns 
% (Only Column1 and Column2 are required for Cantilever Cartesian
% Robot configuration. Column1, Column2, Column3 and Column4 are
% required for Gantry Robot configuration.)
CartesianRobot.BaseFrame.heightColumn    = 1.2;           %[m]
CartesianRobot.BaseFrame.widthColumn     = 0.15;          %[m]
CartesianRobot.BaseFrame.positionColumn1 = [-1.5 -1.5 0]; %[m]
CartesianRobot.BaseFrame.positionColumn2 = [1.5 -1.5 0];  %[m]
CartesianRobot.BaseFrame.positionColumn3 = [-1.5 1.5 0];  %[m] 
CartesianRobot.BaseFrame.positionColumn4 = [1.5 1.5 0];   %[m]

% X-axis
CartesianRobot.XAxis.strokeMax      = 3;    %[m]
CartesianRobot.XAxis.widthRail      = 0.15; %[m]
CartesianRobot.XAxis.densityRail    = 1750; %[kg/m^3]
CartesianRobot.XAxis.densityBlock   = 1750; %[kg/m^3]

% Y-axis
CartesianRobot.YAxis.strokeMax      = 3;    %[m]
CartesianRobot.YAxis.widthRail      = 0.15; %[m]
CartesianRobot.YAxis.densityRail    = 1750; %[kg/m^3]
CartesianRobot.YAxis.densityBlock   = 1750; %[kg/m^3]

% Z-axis
CartesianRobot.ZAxis.strokeMax      = 0.9;  %[m]
CartesianRobot.ZAxis.widthRail      = 0.15; %[m]
CartesianRobot.ZAxis.shiftZAxisDown = 0.45; % Downward shift of installed position of Z-axis unit from reference position %[m]
CartesianRobot.ZAxis.densityRail    = 1750; %[kg/m^3]
CartesianRobot.ZAxis.densityBlock   = 1750; %[kg/m^3]

%% Load parameters for Floor
Floor.dimensions = [4.5 4.5 0.02];  %[m]
Floor.position   = [0 0 0];         %[m]

%% Load parameters for Print Head
PrintHead.diaNozzleExit = 0.03;   %[m]
PrintHead.offsetX       = 0.6374; %[m] Absolute value  for offset of print head from center of X-axis linear stage
                                  % in X-axis direction due to mounts, Y-axis, Z-axis & print head
%% Load parameters for Printing Bed
PrintBed.radiusCircle = 0.6;    %[m]
PrintBed.offsetFloor  = [PrintHead.offsetX-PrintBed.radiusCircle 0 0]; %[m]
PrintBed.height       = 0.01;   %[m]

%% Load parameters for Target Trajectory
Trajectory.time = linspace(0,30,1081); %[m]
Trajectory.radiusCircle = 0.6;                 %[m]
Trajectory.offsetX = PrintBed.offsetFloor(1);
Trajectory.pathX = [linspace(Trajectory.radiusCircle+PrintBed.offsetFloor(1),Trajectory.radiusCircle+PrintBed.offsetFloor(1),108) ...
    Trajectory.radiusCircle*cos(linspace(0,2*pi,865))+PrintBed.offsetFloor(1) ...
    linspace(Trajectory.radiusCircle+PrintBed.offsetFloor(1),Trajectory.radiusCircle+PrintBed.offsetFloor(1),108)]; %[m]
Trajectory.pathY = [linspace(0,0,108) Trajectory.radiusCircle*sin(linspace(0,2*pi,865)) ... 
    linspace(0,0,108)];                       %[m]
Trajectory.pathZ = [0.28*tanh(1.4*linspace(0,3,108)) linspace(0.28,0.28,865) ...
    0.28*tanh(1.4*linspace(3,0,108))];        %[m]
Trajectory.pathR = linspace(0,0,1081);        %[m]

%% Load parameters for Actuation System
% X-Axis Actuation System
Actuation.XAxis.maxTorque = 20; %[N*m]
Actuation.XAxis.maxPower = 1.2; %[kW]]

% Y-Axis Actuation System
Actuation.YAxis.maxTorque = 20; %[N*m]
Actuation.YAxis.maxPower = 1.2; %[kW]]

% Z-Axis Actuation System
Actuation.ZAxis.maxTorque = 20; %[N*m]
Actuation.ZAxis.maxPower = 1.2; %[kW]]

%% Load parameters for Controllers
% X-Axis Position Controller
Controller.XP.kp = 230.94;
Controller.XP.ki = 3.1663e-5;
Controller.XP.kd = 5.9787;
Controller.XP.N = 12179;

% X-Axis Velocity Controller
Controller.XV.kp = 0.80695;
Controller.XV.ki = 8.0061e-8;
Controller.XV.kd = 16.249;
Controller.XV.N = 1.9827e+5;

% Y-Axis Position Controller
Controller.YP.kp = 152.6;
Controller.YP.ki = 1e-5; %194.68;
Controller.YP.kd = 12.521;
Controller.YP.N = 1.5116;

% Y-Axis Velocity Controller
Controller.YV.kp = 0.36798;
Controller.YV.ki = 1e-8; %0.11025;
Controller.YV.kd = 111.36;
Controller.YV.N = 4.6496e5;

% Z-Axis Position Controller
Controller.ZP.kp = 11.4311;
Controller.ZP.ki = 0.98352;
Controller.ZP.kd = 3.5169;
Controller.ZP.N = 1155.15;

% Z-Axis Velocity Controller
Controller.ZV.kp = 1.5046;
Controller.ZV.ki = 4.9741;
Controller.ZV.kd = 0.06338;
Controller.ZV.N = 2475.2435;