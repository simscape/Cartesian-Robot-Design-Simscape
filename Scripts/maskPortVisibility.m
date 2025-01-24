function maskPortVisibility(NameValueArgs)
%% Define input argument validation
arguments
    NameValueArgs.variant (1,:) char {mustBeMember(NameValueArgs.variant,{'GantryRobotVariant','CantileverCartesianRobotVariant'})}
    NameValueArgs.axes (1,:) char {mustBeMember(NameValueArgs.axes,{'XY','XZ','YZ','XYZ','XYZR'})}
end

% This function enables or disables the visibility of actuation ports for
% CantileverCartesianRobotSubsystem and GantryRobotSubsystem based on the 
% axis configuration.

% Copyright 2024 - 2025 The MathWorks, Inc.

system = gcb;

switch NameValueArgs.axes
        % For XY configuration
    case 'XY'
        deleteVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='ZA');
        deleteVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='RA');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='XA',portNumber='3');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='YA',portNumber='4');

        % For XZ configuration
    case 'XZ'
        deleteVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='YA');
        deleteVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='RA');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='XA',portNumber='3');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='ZA',portNumber='4');

        % For YZ configuration
    case 'YZ'
        deleteVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='XA');
        deleteVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='RA');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='YA',portNumber='3');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='ZA',portNumber='4');

        % For XYZ configuration
    case 'XYZ'
        deleteVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='RA');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='XA',portNumber='3');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='YA',portNumber='4');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='ZA',portNumber='5');

        % For XYZR configuration
    case 'XYZR'
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='XA',portNumber='3');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='YA',portNumber='4');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='ZA',portNumber='5');
        addVariantConnectionPort(system=system,variantName=NameValueArgs.variant,portName='RA',portNumber='6');

end

end