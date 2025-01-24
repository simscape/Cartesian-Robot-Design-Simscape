function deleteVariantConnectionPort(NameValueArgs)
%% Define input argument validation
arguments
    NameValueArgs.system (1,:) char
    NameValueArgs.variantName (1,:) char {mustBeMember(NameValueArgs.variantName,{'GantryRobotVariant','CantileverCartesianRobotVariant'})}
    NameValueArgs.portName (1,2) char {mustBeMember(NameValueArgs.portName,{'XA','YA','ZA','RA'})}
end

% This function deletes a connection port inside the CartesianRobotSubsystem 
% with name as NameValueArgs.portName.

% Copyright 2024 - 2025 The MathWorks, Inc.

pathPort = [NameValueArgs.system,'/',NameValueArgs.portName];
pathConverter = [NameValueArgs.system,'/','Conv',NameValueArgs.portName];
handleConverter = getSimulinkBlockHandle(pathConverter);
pathVariantPort = [NameValueArgs.system,'/',NameValueArgs.variantName,'/',NameValueArgs.portName];
portNumber = get_param(pathVariantPort,'Port'); %str2double

switch portNumber
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

% delete line between Simulink-PS Converter of subsystem reference and variant
% subsystem
if (handleConverter == -1)
else
    lineHandlesConverter = get_param(pathConverter,'LineHandles');
    if (lineHandlesConverter.RConn == -1)
    else
        delete_line(NameValueArgs.system,['Conv',NameValueArgs.portName,'/RConn1'],[NameValueArgs.variantName,'/',LConnIndex]);
    end

    % delete line between input bus element and Simulink-PS Converter of
    % subsystem reference
    if (lineHandlesConverter.Inport == -1)
    else
        delete_line(NameValueArgs.system,[NameValueArgs.portName,'/Out1'],['Conv',NameValueArgs.portName,'/In1']);
    end

    % delete Simulink-PS Converter inside subsystem reference
    delete_block(pathConverter);
end

% Add a terminator block and connect unused bus element port to the
% terminator
pathTerminator = [NameValueArgs.system,'/Terminate',NameValueArgs.portName];
handleTerminator = getSimulinkBlockHandle(pathTerminator);
if (handleTerminator == -1)
add_block('simulink/Sinks/Terminator',pathTerminator);
posPort = get_param(pathPort,"Position");
hPosPort = posPort(1);
vPosPort = posPort(2);
set_param(pathTerminator,'Orientation','right');
set_param(pathTerminator,'Position',[hPosPort+60 vPosPort-5 hPosPort+60+20 vPosPort-5+20]);
add_line(NameValueArgs.system,[NameValueArgs.portName,'/Out1'],['Terminate',NameValueArgs.portName,'/In1'],'autorouting','smart');
end

end