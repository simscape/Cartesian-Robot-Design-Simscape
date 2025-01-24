% This code runs the callback sections of the mask for the Gantry Robot 
% subsystem used for the gantry configuration of a cartesian robot.

% Copyright 2024 - 2025 The MathWorks, Inc.

%% Initialization section
sys = gcb;
maskObj = Simulink.Mask.get(sys);
dof = maskObj.getParameter('DOF');
configAxis = maskObj.getParameter('configAxis');
tabXAxis = maskObj.getDialogControl('tabX');
tabYAxis = maskObj.getDialogControl('tabY');
tabZAxis = maskObj.getDialogControl('tabZ');

variantName = 'GantryRobotVariant';
variantBlockPath = [sys,'/GantryRobotVariant'];

systemGuideX = maskObj.getParameter('systemGuideX');
strokeX = maskObj.getParameter('strokeXMax');
wGuideX = maskObj.getParameter('widthGuideX');
dScrewX = maskObj.getParameter('diaScrewX');
typeInertiaGuideX = maskObj.getParameter('typeInertiaGuideX');
rhoGuideX = maskObj.getParameter('densityGuideX');
mGuideX = maskObj.getParameter('massGuideX');
CnOMGuideX = maskObj.getParameter('COMGuideX');
MoOIGuideX = maskObj.getParameter('MOIGuideX');
PrOIGuideX = maskObj.getParameter('POIGuideX');
typeInertiaCarriageX = maskObj.getParameter('typeInertiaCarriageX');
rhoCarriageX = maskObj.getParameter('densityCarriageX');
mCarriageX = maskObj.getParameter('massCarriageX');
CnOMCarriageX = maskObj.getParameter('COMCarriageX');
MoOICarriageX = maskObj.getParameter('MOICarriageX');
PrOICarriageX = maskObj.getParameter('POICarriageX');

systemGuideY = maskObj.getParameter('systemGuideY');
strokeY = maskObj.getParameter('strokeYMax');
wGuideY = maskObj.getParameter('widthGuideY');
dScrewY = maskObj.getParameter('diaScrewY');
typeInertiaGuideY = maskObj.getParameter('typeInertiaGuideY');
rhoGuideY = maskObj.getParameter('densityGuideY');
mGuideY = maskObj.getParameter('massGuideY');
CnOMGuideY = maskObj.getParameter('COMGuideY');
MoOIGuideY = maskObj.getParameter('MOIGuideY');
PrOIGuideY = maskObj.getParameter('POIGuideY');
typeInertiaCarriageY = maskObj.getParameter('typeInertiaCarriageY');
rhoCarriageY = maskObj.getParameter('densityCarriageY');
mCarriageY = maskObj.getParameter('massCarriageY');
CnOMCarriageY = maskObj.getParameter('COMCarriageY');
MoOICarriageY = maskObj.getParameter('MOICarriageY');
PrOICarriageY = maskObj.getParameter('POICarriageY');

systemGuideZ = maskObj.getParameter('systemGuideZ');
strokeZ = maskObj.getParameter('strokeZMax');
wGuideZ = maskObj.getParameter('widthGuideZ');
dScrewZ = maskObj.getParameter('diaScrewZ');
typeInertiaGuideZ = maskObj.getParameter('typeInertiaGuideZ');
rhoGuideZ = maskObj.getParameter('densityGuideZ');
mGuideZ = maskObj.getParameter('massGuideZ');
CnOMGuideZ = maskObj.getParameter('COMGuideZ');
MoOIGuideZ = maskObj.getParameter('MOIGuideZ');
PrOIGuideZ = maskObj.getParameter('POIGuideZ');
typeInertiaCarriageZ = maskObj.getParameter('typeInertiaCarriageZ');
rhoCarriageZ = maskObj.getParameter('densityCarriageZ');
mCarriageZ = maskObj.getParameter('massCarriageZ');
CnOMCarriageZ = maskObj.getParameter('COMCarriageZ');
MoOICarriageZ = maskObj.getParameter('MOICarriageZ');
PrOICarriageZ = maskObj.getParameter('POICarriageZ');

wXMount = maskObj.getParameter('widthXMount');
wYMount = maskObj.getParameter('widthYMount');
wZMount = maskObj.getParameter('widthZMount');
wXMount.Visible = 'off';
wYMount.Visible = 'off';
wZMount.Visible = 'off';

widthGuideXValue = get_param(sys,'value@widthGuideX');
diaScrewXValue = get_param(sys,'value@diaScrewX');
widthGuideYValue = get_param(sys,'value@widthGuideY');
diaScrewYValue = get_param(sys,'value@diaScrewY');
widthGuideZValue = get_param(sys,'value@widthGuideZ');
diaScrewZValue = get_param(sys,'value@diaScrewZ');

switch systemGuideX.Value
    case "Rail-block"
        widthXMount = 2*widthGuideXValue;
    case "Lead screw-bearing"
        widthXMount = 2*3*diaScrewXValue;
end
set_param(sys,"widthXMount",num2str(widthXMount));

switch systemGuideY.Value
    case "Rail-block"
        widthYMount = widthGuideYValue;
    case "Lead screw-bearing"
        widthYMount = 3*diaScrewYValue;
end
set_param(sys,"widthYMount",num2str(widthYMount));

switch systemGuideZ.Value
    case "Rail-block"
        widthZMount = widthGuideZValue;
    case "Lead screw-bearing"
        widthZMount = 3*diaScrewZValue;
end
set_param(sys,"widthZMount",num2str(widthZMount));

switch dof.Value
    case "2DOF"
        configAxis.TypeOptions = {'XY'};
        tabXAxis.Visible = 'on';
        tabYAxis.Visible = 'on';
        tabZAxis.Visible = 'off';
        set_param(variantBlockPath, 'LabelModeActiveChoice', 'XYG');

        % Set X-axis guide system and parameters in underlying linear
        % stages
        setXparams(variantBlockPath,systemGuideX,strokeX,wGuideX,dScrewX,typeInertiaGuideX,...
            rhoGuideX,mGuideX,CnOMGuideX,MoOIGuideX,PrOIGuideX,...
            typeInertiaCarriageX,rhoCarriageX,mCarriageX,CnOMCarriageX,...
            MoOICarriageX,PrOICarriageX);

        % Set Y-axis guide system and parameters in underlying linear
        % stages
        setYparams(variantBlockPath,systemGuideY,strokeY,wGuideY,dScrewY,typeInertiaGuideY,...
            rhoGuideY,mGuideY,CnOMGuideY,MoOIGuideY,PrOIGuideY,...
            typeInertiaCarriageY,rhoCarriageY,mCarriageY,CnOMCarriageY,...
            MoOICarriageY,PrOICarriageY);

    case "3DOF"
        configAxis.TypeOptions = {'XYZ'};
        tabXAxis.Visible = 'on';
        tabYAxis.Visible = 'on';
        tabZAxis.Visible = 'on';
        set_param(variantBlockPath, 'LabelModeActiveChoice', 'XYZG');

        % Set X-axis guide system and parameters in underlying linear
        % stages
        setXparams(variantBlockPath,systemGuideX,strokeX,wGuideX,dScrewX,typeInertiaGuideX,...
            rhoGuideX,mGuideX,CnOMGuideX,MoOIGuideX,PrOIGuideX,...
            typeInertiaCarriageX,rhoCarriageX,mCarriageX,CnOMCarriageX,...
            MoOICarriageX,PrOICarriageX);

        % Set Y-axis guide system and parameters in underlying linear
        % stages
        setYparams(variantBlockPath,systemGuideY,strokeY,wGuideY,dScrewY,typeInertiaGuideY,...
            rhoGuideY,mGuideY,CnOMGuideY,MoOIGuideY,PrOIGuideY,...
            typeInertiaCarriageY,rhoCarriageY,mCarriageY,CnOMCarriageY,...
            MoOICarriageY,PrOICarriageY);

        % Set Z-axis guide system and parameters in underlying linear
        % stages
        setZparams(variantBlockPath,systemGuideZ,strokeZ,wGuideZ,dScrewZ,typeInertiaGuideZ,...
            rhoGuideZ,mGuideZ,CnOMGuideZ,MoOIGuideZ,PrOIGuideZ,...
            typeInertiaCarriageZ,rhoCarriageZ,mCarriageZ,CnOMCarriageZ,...
            MoOICarriageZ,PrOICarriageZ)

    case "4DOF"
        configAxis.TypeOptions = {'XYZR'};
        tabXAxis.Visible = 'on';
        tabYAxis.Visible = 'on';
        tabZAxis.Visible = 'on';
        set_param(variantBlockPath, 'LabelModeActiveChoice', 'XYZRG');

        % Set X-axis guide system and parameters in underlying linear
        % stages
        setXparams(variantBlockPath,systemGuideX,strokeX,wGuideX,dScrewX,typeInertiaGuideX,...
            rhoGuideX,mGuideX,CnOMGuideX,MoOIGuideX,PrOIGuideX,...
            typeInertiaCarriageX,rhoCarriageX,mCarriageX,CnOMCarriageX,...
            MoOICarriageX,PrOICarriageX);

        % Set Y-axis guide system and parameters in underlying linear
        % stages
        setYparams(variantBlockPath,systemGuideY,strokeY,wGuideY,dScrewY,typeInertiaGuideY,...
            rhoGuideY,mGuideY,CnOMGuideY,MoOIGuideY,PrOIGuideY,...
            typeInertiaCarriageY,rhoCarriageY,mCarriageY,CnOMCarriageY,...
            MoOICarriageY,PrOICarriageY);

        % Set Z-axis guide system and parameters in underlying linear
        % stages
        setZparams(variantBlockPath,systemGuideZ,strokeZ,wGuideZ,dScrewZ,typeInertiaGuideZ,...
            rhoGuideZ,mGuideZ,CnOMGuideZ,MoOIGuideZ,PrOIGuideZ,...
            typeInertiaCarriageZ,rhoCarriageZ,mCarriageZ,CnOMCarriageZ,...
            MoOICarriageZ,PrOICarriageZ)
end

%% This function sets parameters in the underlying X-Axis linear stages 
% based on the Gantry subsystem mask parameter selection.
function setXparams(variantBlockPath,systemGuideX,strokeX,wGuideX,dScrewX,typeInertiaGuideX,...
    rhoGuideX,mGuideX,CnOMGuideX,MoOIGuideX,PrOIGuideX,...
    typeInertiaCarriageX,rhoCarriageX,mCarriageX,CnOMCarriageX,...
    MoOICarriageX,PrOICarriageX)

if strcmp(systemGuideX.Value,'Rail-block')
    strokeX.Visible = 'on';
    wGuideX.Visible = 'on';
    dScrewX.Visible = 'off';
else
    strokeX.Visible = 'on';
    wGuideX.Visible = 'off';
    dScrewX.Visible = 'on';
end

if strcmp(typeInertiaGuideX.Value,'Calculate from Geometry')
    rhoGuideX.Visible = 'on';
    mGuideX.Visible = 'off';
    CnOMGuideX.Visible = 'off';
    MoOIGuideX.Visible = 'off';
    PrOIGuideX.Visible = 'off';
else
    rhoGuideX.Visible = 'off';
    mGuideX.Visible = 'on';
    CnOMGuideX.Visible = 'on';
    MoOIGuideX.Visible = 'on';
    PrOIGuideX.Visible = 'on';
end

if strcmp(typeInertiaCarriageX.Value,'Calculate from Geometry')
    rhoCarriageX.Visible = 'on';
    mCarriageX.Visible = 'off';
    CnOMCarriageX.Visible = 'off';
    MoOICarriageX.Visible = 'off';
    PrOICarriageX.Visible = 'off';
else
    rhoCarriageX.Visible = 'off';
    mCarriageX.Visible = 'on';
    CnOMCarriageX.Visible = 'on';
    MoOICarriageX.Visible = 'on';
    PrOICarriageX.Visible = 'on';
end

linearStageXPathAll = find_system(variantBlockPath,'MatchFilter',@Simulink.match.activeVariants,'Name','X-Axis Linear Stage');

for ii=1:numel(linearStageXPathAll)
linearStageXiPath = linearStageXPathAll{ii};
set_param(linearStageXiPath, 'stroke', strokeX.Value); 
set_param(linearStageXiPath, 'widthRail', wGuideX.Value); 
set_param(linearStageXiPath, 'diaScrew', dScrewX.Value); 
set_param(linearStageXiPath, 'systemGuide', systemGuideX.Value);
set_param(linearStageXiPath, 'typeInertiaGuide', typeInertiaGuideX.Value);
set_param(linearStageXiPath, 'densityGuide', rhoGuideX.Value);
set_param(linearStageXiPath, 'massGuide', mGuideX.Value);
set_param(linearStageXiPath, 'CMGuide', CnOMGuideX.Value);
set_param(linearStageXiPath, 'MOIGuide', MoOIGuideX.Value);
set_param(linearStageXiPath, 'POIGuide', PrOIGuideX.Value);
set_param(linearStageXiPath, 'typeInertiaCarriage', typeInertiaCarriageX.Value);
set_param(linearStageXiPath, 'densityCarriage', rhoCarriageX.Value);
set_param(linearStageXiPath, 'massCarriage', mCarriageX.Value);
set_param(linearStageXiPath, 'CMCarriage', CnOMCarriageX.Value);
set_param(linearStageXiPath, 'MOICarriage', MoOICarriageX.Value);
set_param(linearStageXiPath, 'POICarriage', PrOICarriageX.Value);
end

end

%% This function sets parameters in the underlying Y-Axis linear stages
% based on the Gantry subsystem mask parameter selection.
function setYparams(variantBlockPath,systemGuideY,strokeY,wGuideY,dScrewY,typeInertiaGuideY,...
    rhoGuideY,mGuideY,CnOMGuideY,MoOIGuideY,PrOIGuideY,...
    typeInertiaCarriageY,rhoCarriageY,mCarriageY,CnOMCarriageY,...
    MoOICarriageY,PrOICarriageY)

if strcmp(systemGuideY.Value,'Rail-block')
    strokeY.Visible = 'on';
    wGuideY.Visible = 'on';
    dScrewY.Visible = 'off';
else
    strokeY.Visible = 'on';
    wGuideY.Visible = 'off';
    dScrewY.Visible = 'on';
end

if strcmp(typeInertiaGuideY.Value,'Calculate from Geometry')
    rhoGuideY.Visible = 'on';
    mGuideY.Visible = 'off';
    CnOMGuideY.Visible = 'off';
    MoOIGuideY.Visible = 'off';
    PrOIGuideY.Visible = 'off';
else
    rhoGuideY.Visible = 'off';
    mGuideY.Visible = 'on';
    CnOMGuideY.Visible = 'on';
    MoOIGuideY.Visible = 'on';
    PrOIGuideY.Visible = 'on';
end

if strcmp(typeInertiaCarriageY.Value,'Calculate from Geometry')
    rhoCarriageY.Visible = 'on';
    mCarriageY.Visible = 'off';
    CnOMCarriageY.Visible = 'off';
    MoOICarriageY.Visible = 'off';
    PrOICarriageY.Visible = 'off';
else
    rhoCarriageY.Visible = 'off';
    mCarriageY.Visible = 'on';
    CnOMCarriageY.Visible = 'on';
    MoOICarriageY.Visible = 'on';
    PrOICarriageY.Visible = 'on';
end

linearStageYPathAll = find_system(variantBlockPath,'MatchFilter',@Simulink.match.activeVariants,'Name','Y-Axis Linear Stage');

for ii=1:numel(linearStageYPathAll)
    linearStageYiPath = linearStageYPathAll{ii};
    set_param(linearStageYiPath, 'stroke', strokeY.Value);
    set_param(linearStageYiPath, 'widthRail', wGuideY.Value);
    set_param(linearStageYiPath, 'diaScrew', dScrewY.Value);
    set_param(linearStageYiPath, 'systemGuide', systemGuideY.Value);
    set_param(linearStageYiPath, 'typeInertiaGuide', typeInertiaGuideY.Value);
    set_param(linearStageYiPath, 'densityGuide', rhoGuideY.Value);
    set_param(linearStageYiPath, 'massGuide', mGuideY.Value);
    set_param(linearStageYiPath, 'CMGuide', CnOMGuideY.Value);
    set_param(linearStageYiPath, 'MOIGuide', MoOIGuideY.Value);
    set_param(linearStageYiPath, 'POIGuide', PrOIGuideY.Value);
    set_param(linearStageYiPath, 'typeInertiaCarriage', typeInertiaCarriageY.Value);
    set_param(linearStageYiPath, 'densityCarriage', rhoCarriageY.Value);
    set_param(linearStageYiPath, 'massCarriage', mCarriageY.Value);
    set_param(linearStageYiPath, 'CMCarriage', CnOMCarriageY.Value);
    set_param(linearStageYiPath, 'MOICarriage', MoOICarriageY.Value);
    set_param(linearStageYiPath, 'POICarriage', PrOICarriageY.Value);
end
end

%% This function sets parameters in the underlying Z-Axis linear stages
% based on the Gantry subsystem mask parameter selection.
function setZparams(variantBlockPath,systemGuideZ,strokeZ,wGuideZ,dScrewZ,typeInertiaGuideZ,...
    rhoGuideZ,mGuideZ,CnOMGuideZ,MoOIGuideZ,PrOIGuideZ,...
    typeInertiaCarriageZ,rhoCarriageZ,mCarriageZ,CnOMCarriageZ,...
    MoOICarriageZ,PrOICarriageZ)

if strcmp(systemGuideZ.Value,'Rail-block')
    strokeZ.Visible = 'on';
    wGuideZ.Visible = 'on';
    dScrewZ.Visible = 'off';
else
    strokeZ.Visible = 'on';
    wGuideZ.Visible = 'off';
    dScrewZ.Visible = 'on';
end

if strcmp(typeInertiaGuideZ.Value,'Calculate from Geometry')
    rhoGuideZ.Visible = 'on';
    mGuideZ.Visible = 'off';
    CnOMGuideZ.Visible = 'off';
    MoOIGuideZ.Visible = 'off';
    PrOIGuideZ.Visible = 'off';
else
    rhoGuideZ.Visible = 'off';
    mGuideZ.Visible = 'on';
    CnOMGuideZ.Visible = 'on';
    MoOIGuideZ.Visible = 'on';
    PrOIGuideZ.Visible = 'on';
end

if strcmp(typeInertiaCarriageZ.Value,'Calculate from Geometry')
    rhoCarriageZ.Visible = 'on';
    mCarriageZ.Visible = 'off';
    CnOMCarriageZ.Visible = 'off';
    MoOICarriageZ.Visible = 'off';
    PrOICarriageZ.Visible = 'off';
else
    rhoCarriageZ.Visible = 'off';
    mCarriageZ.Visible = 'on';
    CnOMCarriageZ.Visible = 'on';
    MoOICarriageZ.Visible = 'on';
    PrOICarriageZ.Visible = 'on';
end

linearStageZPathAll = find_system(variantBlockPath,'MatchFilter',@Simulink.match.activeVariants,'Name','Z-Axis Linear Stage');

for ii=1:numel(linearStageZPathAll)
    linearStageZiPath = linearStageZPathAll{ii};
    set_param(linearStageZiPath, 'stroke', strokeZ.Value); 
    set_param(linearStageZiPath, 'widthRail', wGuideZ.Value); 
    set_param(linearStageZiPath, 'diaScrew', dScrewZ.Value); 
    set_param(linearStageZiPath, 'systemGuide', systemGuideZ.Value);
    set_param(linearStageZiPath, 'typeInertiaGuide', typeInertiaGuideZ.Value);
    set_param(linearStageZiPath, 'densityGuide', rhoGuideZ.Value);
    set_param(linearStageZiPath, 'massGuide', mGuideZ.Value);
    set_param(linearStageZiPath, 'CMGuide', CnOMGuideZ.Value);
    set_param(linearStageZiPath, 'MOIGuide', MoOIGuideZ.Value);
    set_param(linearStageZiPath, 'POIGuide', PrOIGuideZ.Value);
    set_param(linearStageZiPath, 'typeInertiaCarriage', typeInertiaCarriageZ.Value);
    set_param(linearStageZiPath, 'densityCarriage', rhoCarriageZ.Value);
    set_param(linearStageZiPath, 'massCarriage', mCarriageZ.Value);
    set_param(linearStageZiPath, 'CMCarriage', CnOMCarriageZ.Value);
    set_param(linearStageZiPath, 'MOICarriage', MoOICarriageZ.Value);
    set_param(linearStageZiPath, 'POICarriage', PrOICarriageZ.Value);
end
end

maskPortVisibility(variant=variantName,axes=configAxis.Value);