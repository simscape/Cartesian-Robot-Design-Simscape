function [YGuideMB,YRailRB,YMHousingRB,YEndStopRB] = constructYAxisLinearGuide(Parameters)
%% Define input argument validation
arguments
    Parameters.strokeYGuide (1,1) double {mustBePositive}
    Parameters.fracLenYCarrgGuide (1,1) double {mustBePositive}
    Parameters.widYRail (1,1) double {mustBePositive}
    Parameters.rhoYGuide (1,1) double {mustBePositive}
    Parameters.graphicYGuide (1,:) double
end

% This function creates the Y-Axis Linear Guide using objects of the 
% simscape.multibody.Component class.

% Copyright 2024 The MathWorks, Inc.

%% Calculate geometry and inertia parameters of the Y-Axis Rail
lenYRail = Parameters.strokeYGuide/(1-Parameters.fracLenYCarrgGuide);
widthYRail = simscape.Value(Parameters.widYRail,"m");
sectionYRail = createSectionRail(widthYRail);
lengthYRail = simscape.Value(lenYRail,"m");
offsetYRail = 0.4*lenYRail;
% offsetYRail = simscape.Value(offSYRail,"m");
densityYGuide = simscape.Value(Parameters.rhoYGuide,"kg/m^3");

%% Define frames of the Y-Axis rail using the simscape.multibody.RigidTransform objects.
rtYRailF1 = simscape.multibody.RigidTransform(simscape.multibody.RotationSequenceRotation(simscape.multibody.FrameSide.Base,...
    simscape.multibody.AxisSequence.XYZ,simscape.Value([90 0 90],"deg")), simscape.multibody.StandardAxisTranslation ...
    (simscape.Value(offsetYRail,"m"), simscape.multibody.Axis.NegZ));
rtYRailF2 = simscape.multibody.RigidTransform(simscape.multibody.RotationSequenceRotation(simscape.multibody.FrameSide.Base,...
    simscape.multibody.AxisSequence.XYZ,simscape.Value([90 0 90],"deg")), simscape.multibody.StandardAxisTranslation ...
    (simscape.Value(Parameters.widYRail,"m"), simscape.multibody.Axis.PosY));
rtYRailF3 = simscape.multibody.RigidTransform(simscape.multibody.RotationSequenceRotation(simscape.multibody.FrameSide.Base,...
    simscape.multibody.AxisSequence.XYZ,simscape.Value([90 0 90],"deg")), simscape.multibody.CartesianTranslation ...
    (simscape.Value([0 0.5*Parameters.widYRail -0.5*lenYRail],"m")));
rtYRailF4 = simscape.multibody.RigidTransform(simscape.multibody.RotationSequenceRotation(simscape.multibody.FrameSide.Base,...
    simscape.multibody.AxisSequence.XYZ,simscape.Value([90 0 90],"deg")), simscape.multibody.CartesianTranslation ...
    (simscape.Value([0 0.5*Parameters.widYRail 0.5*lenYRail],"m")));

framesYRail = struct('F1',rtYRailF1,'F2',rtYRailF2, 'F3',rtYRailF3, 'F4',rtYRailF4);

%% Construct rigid body of the Y-Axis rail using the function constructGeneralShapeRigidBody.
YRailRB = constructGeneralShapeRigidBody(crossSection=sectionYRail,length=lengthYRail,density=densityYGuide,graphic=Parameters.graphicYGuide,frames=framesYRail); 

%% Calculate geometry, inertia and graphic parameters of the motor housing of Y-Axis Rail
dimensionsYMHousing = simscape.Value(1.5*[Parameters.widYRail,Parameters.widYRail,Parameters.widYRail],"m");
densityYMHousing = simscape.Value(Parameters.rhoYGuide,"kg/m^3");
graphicYMHousing = [0.5 0.4 0.7];

%% Define frames of the Y-Axis motor housing using the simscape.multibody.RigidTransform objects
rtYMHousingF1 = simscape.multibody.RigidTransform(simscape.multibody.CartesianTranslation(simscape.Value ...
    ([-0.25*Parameters.widYRail 0.75*Parameters.widYRail 0],"m")));
framesYMHousing = struct('F1',rtYMHousingF1);

%% Construct rigid body of the Y-Axis motor housing using the function constructBrickRigidBody
YMHousingRB = constructBrickRigidBody(dimensions=dimensionsYMHousing,density=densityYMHousing,graphic=graphicYMHousing,frames=framesYMHousing);
 
%% Calculate geometry, inertia and graphic parameters of the tail end stop of Y-Axis Rail
dimensionsYEndStop = simscape.Value(1.5*[Parameters.widYRail,0.02*lenYRail,Parameters.widYRail],"m");
densityYEndStop = simscape.Value(Parameters.rhoYGuide,"kg/m^3");
graphicYEndStop = [0.5 0.4 0.7];

%% Define frames of the Y-Axis end stop using the simscape.multibody.RigidTransform objects
rtYEndStopF1 = simscape.multibody.RigidTransform(simscape.multibody.CartesianTranslation...
    (simscape.Value([-0.25*Parameters.widYRail -0.01*lenYRail 0],"m")));
framesYEndStop = struct('F1',rtYEndStopF1);

%% Construct rigid body of the Y-Axis end stop using the function constructBrickRigidBody
YEndStopRB = constructBrickRigidBody(dimensions=dimensionsYEndStop,density=densityYEndStop,graphic=graphicYEndStop,frames=framesYEndStop);

%% Create a new simscape.multibody.Multibody object for Y-Axis Linear guide
% Add the Multibody objects for Y-Axis rail, motor housing and tail end stop 
% to the multibody system for Y-Axis Linear guide using addComponent method of the Multibody object.
YGuideMB = simscape.multibody.Multibody;
addComponent(YGuideMB,"World", simscape.multibody.WorldFrame);
addComponent(YGuideMB,"YRail",YRailRB);
addComponent(YGuideMB,"YMotorHousing",YMHousingRB);
addComponent(YGuideMB,"YEndStop",YEndStopRB);


%% Connect the rigid bodies in the Y-Axis Linear guide multibody system using connect method of the Multibody object
connect(YGuideMB,"World/W", "YRail/F1");
connect(YGuideMB,"YRail/F3", "YMotorHousing/F1");
connect(YGuideMB,"YRail/F4", "YEndStop/F1");

end