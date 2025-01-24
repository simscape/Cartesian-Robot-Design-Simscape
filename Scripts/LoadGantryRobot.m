% This code sets the reference model for the robot subsystem reference 
% GantryRobotSubsystem.

% Copyright 2024 The MathWorks, Inc.

disp("Configuring the Cartesian 3D printing robot model with Gantry robot...")
modelName = gcs;
robotSystemName = 'Cartesian Robot';
robotSystem=find_system(modelName,'Name',robotSystemName);
set(getSimulinkBlockHandle(robotSystem),'ReferencedSubsystem', ...
    'GantryRobotSubsystem');

run('XYZGantryRobotParameters');

%% Suppress library warnings
warning('off','Simulink:Commands:SetParamLinkChangeWarn')

%% Library warnings reset
warning('on','Simulink:Commands:SetParamLinkChangeWarn')