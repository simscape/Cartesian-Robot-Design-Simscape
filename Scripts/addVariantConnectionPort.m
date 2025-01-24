function addVariantConnectionPort(NameValueArgs)
%% Define input argument validation
arguments
    NameValueArgs.system (1,:) char
    NameValueArgs.variantName (1,:) char {mustBeMember(NameValueArgs.variantName,{'GantryRobotVariant','CantileverCartesianRobotVariant'})}
    NameValueArgs.portName (1,2) char {mustBeMember(NameValueArgs.portName,{'XA','YA','ZA','RA'})}
    NameValueArgs.portNumber (1,1) char {mustBeMember(NameValueArgs.portNumber,{'3','4','5','6'})}
end

% This function adds a connection port inside the CartesianRobotSubsystem
% and CartesianRobotVariant subsystem with name as NameValueArgs.portName 
% and port number in CartesianRobotVariant as NameValueArgs.portNumber.

% Copyright 2024 - 2025 The MathWorks, Inc.

pathPort = [NameValueArgs.system,'/',NameValueArgs.portName];
posPort = get_param(pathPort,"Position");
hPosPort = posPort(1);
vPosPort = posPort(2);
pathVariantPort = [NameValueArgs.system,'/',NameValueArgs.variantName,'/',NameValueArgs.portName];
handleVariantPort = getSimulinkBlockHandle(pathVariantPort);
pathConverter = [NameValueArgs.system,'/','Conv',NameValueArgs.portName];
handleConverter = getSimulinkBlockHandle(pathConverter);
pathTerminator = [NameValueArgs.system,'/Terminate',NameValueArgs.portName];
handleTerminator = getSimulinkBlockHandle(pathTerminator);

switch NameValueArgs.portNumber
    case '3'
        LportIndex = 1;
    case '4'
        LportIndex = 2;
    case '5'
        LportIndex = 3;
    case '6'
        LportIndex = 4;
end
LConnIndex = ['LConn',num2str(LportIndex)];

% Horizontal & vertical position of first port of variant subsystem
hPosVariantPort = -630;
vPosVariantPort = 40;
% hPosPort = 5;
% vPosPort = 40;

% Width & height of connection ports
widthConnPort = 30;
heightConnPort = 15;

% Vertical gap between ports
vGapConnPort = 2*heightConnPort;

% add connection port inside variant subsystem of subsystem reference
if (handleVariantPort == -1)
    add_block('simulink/Signal Routing/Connection Port',pathVariantPort);
end
set_param(pathVariantPort,'Orientation','right');
set_param(pathVariantPort,'Position',[hPosVariantPort ...
    vPosVariantPort+(str2double(NameValueArgs.portNumber)-3)*vGapConnPort hPosVariantPort+widthConnPort ...
    vPosVariantPort+(str2double(NameValueArgs.portNumber)-3)*vGapConnPort+heightConnPort]);
set_param(pathVariantPort,'Port',num2str(str2double(NameValueArgs.portNumber)));

% add Simulink-PS converter and connect bus element inport to variant port
% through converter
if (handleConverter ~= -1)
    lineHandlesConverter = get_param(pathConverter,'LineHandles');
    if (lineHandlesConverter.RConn ~= -1)
    elseif (lineHandlesConverter.Inport ~= -1)
        add_line(NameValueArgs.system,['Conv',NameValueArgs.portName,'/RConn1'],[NameValueArgs.variantName,'/',LConnIndex],'autorouting','smart');
    else
        add_line(NameValueArgs.system,[NameValueArgs.portName,'/Out1'],['Conv',NameValueArgs.portName,'/In1'],'autorouting','smart');
    end
elseif (handleTerminator == -1)
    add_block('nesl_utility/Simulink-PS Converter',pathConverter);
    switch NameValueArgs.portName
        case 'RA'
            set_param(pathConverter,'Unit','N*m');
        otherwise
            set_param(pathConverter,'Unit','N');
    end
    set_param(pathConverter,'Orientation','right');
    set_param(pathConverter,'Position',[hPosPort+60 vPosPort-5 hPosPort+60+15 vPosPort-5+15]);
    add_line(NameValueArgs.system,[NameValueArgs.portName,'/Out1'],['Conv',NameValueArgs.portName,'/In1'],'autorouting','smart');
    add_line(NameValueArgs.system,['Conv',NameValueArgs.portName,'/RConn1'],[NameValueArgs.variantName,'/',LConnIndex],'autorouting','smart');
else
    lineHandlesTerminator = get_param(pathTerminator,'LineHandles');
    if (lineHandlesTerminator.Inport == -1)
        delete_block(pathTerminator);
        add_block('nesl_utility/Simulink-PS Converter',pathConverter);
        switch NameValueArgs.portName
            case 'RA'
                set_param(pathConverter,'Unit','N*m');
            otherwise
                set_param(pathConverter,'Unit','N');
        end
        set_param(pathConverter,'Orientation','right');
        set_param(pathConverter,'Position',[hPosPort+60 vPosPort-5 hPosPort+60+20 vPosPort-5+20]);
        add_line(NameValueArgs.system,[NameValueArgs.portName,'/Out1'],['Conv',NameValueArgs.portName,'/In1'],'autorouting','smart');
        add_line(NameValueArgs.system,['Conv',NameValueArgs.portName,'/RConn1'],[NameValueArgs.variantName,'/',LConnIndex],'autorouting','smart');
    else
        delete_line(NameValueArgs.system,[NameValueArgs.portName,'/Out1'],['Terminate',NameValueArgs.portName,'/In1']);
        delete_block(pathTerminator);
        add_block('nesl_utility/Simulink-PS Converter',pathConverter);
        switch NameValueArgs.portName
            case 'RA'
                set_param(pathConverter,'Unit','N*m');
            otherwise
                set_param(pathConverter,'Unit','N');
        end
        set_param(pathConverter,'Orientation','right');
        set_param(pathConverter,'Position',[hPosPort+60 vPosPort-5 hPosPort+60+20 vPosPort-5+20]);
        add_line(NameValueArgs.system,[NameValueArgs.portName,'/Out1'],['Conv',NameValueArgs.portName,'/In1'],'autorouting','smart');
        add_line(NameValueArgs.system,['Conv',NameValueArgs.portName,'/RConn1'],[NameValueArgs.variantName,'/',LConnIndex],'autorouting','smart');

    end
end

end