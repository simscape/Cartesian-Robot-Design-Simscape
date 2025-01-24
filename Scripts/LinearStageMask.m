% This code initializes Linear Stage custom block and implements 
% callbacks in the block mask.

% Copyright 2024 The MathWorks, Inc.

%% Initialization section
maskObj = Simulink.Mask.get(gcb);
strokeValue = get_param(gcb,'value@stroke');
diaScrewValue = get_param(gcb,'value@diaScrew');
widthRailValue = get_param(gcb,'value@widthRail');
guideSystemPath = [gcb,'/Linear Guide'];
carriageSystemPath = [gcb,'/Carriage'];
fracLengthCarriageGuide = 0.2;
lengthRail = strokeValue/(1-fracLengthCarriageGuide);
lengthBlock = fracLengthCarriageGuide*lengthRail;
lengthScrew = strokeValue/(1-fracLengthCarriageGuide);
lengthBearing = fracLengthCarriageGuide*lengthScrew;
widthBearing = 2*diaScrewValue;
set_param(guideSystemPath,'lengthRail',num2str(lengthRail));
set_param(carriageSystemPath,'lengthBlock',num2str(lengthBlock));
set_param(guideSystemPath,'lengthScrew',num2str(lengthScrew));
set_param(carriageSystemPath,'lengthBearing',num2str(lengthBearing));
set_param(carriageSystemPath,'widthBearing',num2str(widthBearing));

%% guideSystem & axisGuide Callback Section
systemGuide = maskObj.getParameter('systemGuide');
axisGuide = maskObj.getParameter('axisGuide');
transform1Path = [gcb,'/Rigid Transform1'];
transform2Path = [gcb,'/Rigid Transform2'];
transform3Path = [gcb,'/Rigid Transform3'];
transform4Path = [gcb,'/Rigid Transform4'];
stroke = maskObj.getParameter('stroke');
widthRail = maskObj.getParameter('widthRail');
diaScrew = maskObj.getParameter('diaScrew');
if strcmp(systemGuide.Value,'Rail-block')
    stroke.Visible = 'on';
    widthRail.Visible = 'on';
    diaScrew.Visible = 'off';
    set_param(guideSystemPath, 'typeGuide', 'Rail');
    set_param(carriageSystemPath, 'typeCarriage', 'Block');
    switch axisGuide.Value
        case 'X-axis'
            set_param(transform1Path,'RotationMethod','RotationSequence');
            set_param(transform1Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform1Path,'RotationSequence','ZYX');
            set_param(transform1Path,'RotationSequenceAngles','[90 90 0]');
            set_param(transform1Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform2Path,'RotationMethod','RotationSequence');
            set_param(transform2Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform2Path,'RotationSequence','XYZ');
            set_param(transform2Path,'RotationSequenceAngles','[-90 -90 0]');
            set_param(transform2Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform3Path,'RotationMethod','RotationSequence');
            set_param(transform3Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform3Path,'RotationSequence','YXZ');
            set_param(transform3Path,'RotationSequenceAngles','[90 90 0]');
            set_param(transform3Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform4Path,'RotationMethod','RotationSequence');
            set_param(transform4Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform4Path,'RotationSequence','XYZ');
            set_param(transform4Path,'RotationSequenceAngles','[-90 -90 0]');
            set_param(transform4Path,'RotationSequenceAnglesUnits','deg');
        case 'Y-axis'
            set_param(transform1Path,'RotationMethod','RotationSequence');
            set_param(transform1Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform1Path,'RotationSequence','XYZ');
            set_param(transform1Path,'RotationSequenceAngles','[-90 -90 0]');
            set_param(transform1Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform2Path,'RotationMethod','RotationSequence');
            set_param(transform2Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform2Path,'RotationSequence','XYZ');
            set_param(transform2Path,'RotationSequenceAngles','[90 0 90]'); 
            set_param(transform2Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform3Path,'RotationMethod','RotationSequence');
            set_param(transform3Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform3Path,'RotationSequence','ZYX'); 
            set_param(transform3Path,'RotationSequenceAngles','[-90 0 -90]');
            set_param(transform3Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform4Path,'RotationMethod','RotationSequence');
            set_param(transform4Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform4Path,'RotationSequence','XYZ');
            set_param(transform4Path,'RotationSequenceAngles','[90 0 90]'); 
            set_param(transform4Path,'RotationSequenceAnglesUnits','deg');
        case 'Z-axis'
            set_param(transform1Path,'RotationMethod','StandardAxis');
            set_param(transform1Path,'RotationStandardAxis','+Z');
            set_param(transform1Path,'RotationAngle','-90');
            set_param(transform1Path,'RotationAngleUnits','deg');

            set_param(transform2Path,'RotationMethod','StandardAxis');
            set_param(transform2Path,'RotationStandardAxis','+Z');
            set_param(transform2Path,'RotationAngle','90');
            set_param(transform2Path,'RotationAngleUnits','deg');

            set_param(transform3Path,'RotationMethod','StandardAxis');
            set_param(transform3Path,'RotationStandardAxis','+Z');
            set_param(transform3Path,'RotationAngle','-90');
            set_param(transform3Path,'RotationAngleUnits','deg');

            set_param(transform4Path,'RotationMethod','StandardAxis');
            set_param(transform4Path,'RotationStandardAxis','+Z');
            set_param(transform4Path,'RotationAngle','90');
            set_param(transform4Path,'RotationAngleUnits','deg');
    end

elseif strcmp(systemGuide.Value,'Lead screw-bearing')
    stroke.Visible = 'on';
    widthRail.Visible = 'off';
    diaScrew.Visible = 'on';
    set_param(guideSystemPath, 'typeGuide', 'Lead screw');
    set_param(carriageSystemPath, 'typeCarriage', 'Bearing');
    switch axisGuide.Value
        case 'X-axis'
            set_param(transform1Path,'RotationMethod','RotationSequence');
            set_param(transform1Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform1Path,'RotationSequence','ZYX');
            set_param(transform1Path,'RotationSequenceAngles','[0 90 180]');
            set_param(transform1Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform2Path,'RotationMethod','RotationSequence');
            set_param(transform2Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform2Path,'RotationSequence','XYZ');
            set_param(transform2Path,'RotationSequenceAngles','[180 -90 0]');
            set_param(transform2Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform3Path,'RotationMethod','RotationSequence');
            set_param(transform3Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform3Path,'RotationSequence','YXZ');
            set_param(transform3Path,'RotationSequenceAngles','[-90 180 0]');
            set_param(transform3Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform4Path,'RotationMethod','RotationSequence');
            set_param(transform4Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform4Path,'RotationSequence','XYZ');
            set_param(transform4Path,'RotationSequenceAngles','[180 90 0]');
            set_param(transform4Path,'RotationSequenceAnglesUnits','deg');
        case 'Y-axis'
            set_param(transform1Path,'RotationMethod','StandardAxis');
            set_param(transform1Path,'RotationStandardAxis','+X');
            set_param(transform1Path,'RotationAngle','-90');
            set_param(transform1Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform2Path,'RotationMethod','StandardAxis');
            set_param(transform2Path,'RotationStandardAxis','+X');
            set_param(transform2Path,'RotationAngle','90');
            set_param(transform2Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform3Path,'RotationMethod','RotationSequence');
            set_param(transform3Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform3Path,'RotationSequence','XYZ');
            set_param(transform3Path,'RotationSequenceAngles','[90 180 0]');
            set_param(transform3Path,'RotationSequenceAnglesUnits','deg');

            set_param(transform4Path,'RotationMethod','RotationSequence');
            set_param(transform4Path,'RotationSequenceAxes','BaseAxes');
            set_param(transform4Path,'RotationSequence','XYZ');
            set_param(transform4Path,'RotationSequenceAngles','[90 180 0]');
            set_param(transform4Path,'RotationSequenceAnglesUnits','deg');
        case 'Z-axis'
            set_param(transform1Path,'RotationMethod','StandardAxis');
            set_param(transform1Path,'RotationStandardAxis','+Z');
            set_param(transform1Path,'RotationAngle','0');
            set_param(transform1Path,'RotationAngleUnits','deg');

            set_param(transform2Path,'RotationMethod','StandardAxis');
            set_param(transform2Path,'RotationStandardAxis','+Z');
            set_param(transform2Path,'RotationAngle','0');
            set_param(transform2Path,'RotationAngleUnits','deg');

            set_param(transform3Path,'RotationMethod','StandardAxis');
            set_param(transform3Path,'RotationStandardAxis','+Z');
            set_param(transform3Path,'RotationAngle','180');
            set_param(transform3Path,'RotationAngleUnits','deg');

            set_param(transform4Path,'RotationMethod','StandardAxis');
            set_param(transform4Path,'RotationStandardAxis','+Z');
            set_param(transform4Path,'RotationAngle','180');
            set_param(transform4Path,'RotationAngleUnits','deg');
    end
end

%% typeInertiaGuide Callback section

typeInertiaGuide = maskObj.getParameter('typeInertiaGuide');
massGuideObj = maskObj.getParameter('massGuide');
CMGuideObj = maskObj.getParameter('CMGuide');
MOIGuideObj = maskObj.getParameter('MOIGuide');
POIGuideObj = maskObj.getParameter('POIGuide');
densityGuide = maskObj.getParameter('densityGuide');                                    
railPath = [gcb,'/Linear Guide/Rail/Extruded Solid'];
housingRailPath = [gcb,'/Linear Guide/Rail/Housing/Motor Housing'];
endstopRailPath = [gcb,'/Linear Guide/Rail/Tail End Stop/End Stop'];
screwPath = [gcb,'/Linear Guide/Lead Screw/Screw'];
axisStructurePath = [gcb,'/Linear Guide/Lead Screw/Axis Structure'];
housingScrewPath = [gcb,'/Linear Guide/Lead Screw/Housing/Motor Housing'];
endstopScrewPath = [gcb,'/Linear Guide/Lead Screw/Tail End Housing/End Stop'];

pathRailSolid = [gcb,'/Linear Guide/Rail/Extruded Solid'];
pathScrewSolid = [gcb,'/Linear Guide/Lead Screw/Screw'];
pathBlockSolid = [gcb,'/Carriage/Block/Extruded Solid'];
pathBearingSolid = [gcb,'/Carriage/Bearing/Extruded Solid'];

if strcmp(typeInertiaGuide.Value,'Calculate from Geometry')
    massGuideObj.Visible='off';
    CMGuideObj.Visible='off';
    MOIGuideObj.Visible='off';
    POIGuideObj.Visible='off';
    densityGuide.Visible='on';
    set_param(railPath,'InertiaType','CalculateFromGeometry');
    set_param(railPath,'BasedOnType','Density');
    set_param(housingRailPath,'InertiaType','CalculateFromGeometry');
    set_param(housingRailPath,'BasedOnType','Density');
    set_param(endstopRailPath,'InertiaType','CalculateFromGeometry');
    set_param(endstopRailPath,'BasedOnType','Density');
    set_param(screwPath,'InertiaType','CalculateFromGeometry');
    set_param(screwPath,'BasedOnType','Density');
    set_param(axisStructurePath,'InertiaType','CalculateFromGeometry');
    set_param(axisStructurePath,'BasedOnType','Density');
    set_param(housingScrewPath,'InertiaType','CalculateFromGeometry');
    set_param(housingScrewPath,'BasedOnType','Density');
    set_param(endstopScrewPath,'InertiaType','CalculateFromGeometry');
    set_param(endstopScrewPath,'BasedOnType','Density');
elseif strcmp(typeInertiaGuide.Value,'Custom')
    massGuideObj.Visible='on';
    CMGuideObj.Visible='on';
    MOIGuideObj.Visible='on';
    POIGuideObj.Visible='on';
    densityGuide.Visible='off';
    set_param(railPath,'InertiaType','Custom');
    set_param(housingRailPath,'InertiaType','Custom');
    set_param(endstopRailPath,'InertiaType','Custom');
    set_param(screwPath,'InertiaType','Custom');
    set_param(axisStructurePath,'InertiaType','Custom');
    set_param(housingScrewPath,'InertiaType','Custom');
    set_param(endstopScrewPath,'InertiaType','Custom');

    % Assign Center of Mass
    CMGuide = get_param(gcb,'value@CMGuide');
    if strcmp(systemGuide.Value,'Rail-block')
        switch axisGuide.Value
            case 'X-axis'
                CMGuideSolid = '[CMGuide(2) CMGuide(3) CMGuide(1)]';
            case 'Y-axis'
                CMGuideSolid = '[CMGuide(3) CMGuide(1) CMGuide(2)]';
            case 'Z-axis'
                CMGuideSolid = '[-CMGuide(2) CMGuide(1) CMGuide(3)]';
        end
        set_param(pathRailSolid,"CenterOfMass",CMGuideSolid);

    elseif strcmp(systemGuide.Value,'Lead screw-bearing')
        switch axisGuide.Value
            case 'X-axis'
                CMGuideSolid = '[CMGuide(3) -CMGuide(2) CMGuide(1)]';
            case 'Y-axis'
                CMGuideSolid = '[CMGuide(1) -CMGuide(3) CMGuide(2)]';
            case 'Z-axis'
                CMGuideSolid = '[CMGuide(1) CMGuide(2) CMGuide(3)]';
        end
        set_param(pathScrewSolid,"CenterOfMass",CMGuideSolid);

    end
end

%% typeInertiaCarriage Callback section

typeInertiaCarriage = maskObj.getParameter('typeInertiaCarriage');
massCarriageObj = maskObj.getParameter('massCarriage');
CMCarriageObj = maskObj.getParameter('CMCarriage');
MOICarriageObj = maskObj.getParameter('MOICarriage');
POICarriageObj = maskObj.getParameter('POICarriage');
densityCarriage = maskObj.getParameter('densityCarriage');
blockPath = [gcb,'/Carriage/Block/Extruded Solid'];
bearingPath = [gcb,'/Carriage/Bearing/Extruded Solid'];                                     

if strcmp(typeInertiaCarriage.Value,'Calculate from Geometry')
    massCarriageObj.Visible='off';
    CMCarriageObj.Visible='off';
    MOICarriageObj.Visible='off';
    POICarriageObj.Visible='off';
    densityCarriage.Visible='on';
    set_param(blockPath,'InertiaType','CalculateFromGeometry');
    set_param(blockPath,'BasedOnType','Density');
    set_param(bearingPath,'InertiaType','CalculateFromGeometry');
    set_param(bearingPath,'BasedOnType','Density');
elseif strcmp(typeInertiaCarriage.Value,'Custom')
    massCarriageObj.Visible='on';
    CMCarriageObj.Visible='on';
    MOICarriageObj.Visible='on';
    POICarriageObj.Visible='on';
    densityCarriage.Visible='off';  
    set_param(blockPath,'InertiaType','Custom');
    set_param(bearingPath,'InertiaType','Custom');

    % Assign Center of Mass
    CMCarriage = get_param(gcb,'value@CMCarriage');
    if strcmp(systemGuide.Value,'Rail-block')
        switch axisGuide.Value
            case 'X-axis'
                CMCarriageSolid = '[CMCarriage(2) CMCarriage(3) CMCarriage(1)]';
            case 'Y-axis'
                CMCarriageSolid = '[CMCarriage(3) CMCarriage(1) CMCarriage(2)]';
            case 'Z-axis'
                CMCarriageSolid = '[-CMCarriage(2) CMCarriage(1) CMCarriage(3)]';
        end
        set_param(pathBlockSolid,"CenterOfMass",CMCarriageSolid);

    elseif strcmp(systemGuide.Value,'Lead screw-bearing')
        switch axisGuide.Value
            case 'X-axis'
                CMCarriageSolid = '[-CMCarriage(3) -CMCarriage(2) -CMCarriage(1)]';
            case 'Y-axis'
                CMCarriageSolid = '[-CMCarriage(1) -CMCarriage(3) -CMCarriage(2)]';
            case 'Z-axis'
                CMCarriageSolid = '[-CMCarriage(1) -CMCarriage(2) CMCarriage(3)]';
        end
        set_param(pathBearingSolid,"CenterOfMass",CMCarriageSolid);

    end
end