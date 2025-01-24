function [YCarriageMB,YBlockRB] = constructYAxisCarriage(Parameters)
%% Define input argument validation
arguments
    Parameters.strokeYGuide (1,1) double {mustBePositive}
    Parameters.fracLenYCarrgGuide (1,1) double {mustBePositive}
    Parameters.widYRail (1,1) double {mustBePositive}
    Parameters.rhoYCarriage (1,1) double {mustBePositive}
    Parameters.graphicYCarriage (1,:) double
end

% This function creates the Y-Axis Linear Guide using objects of the 
% simscape.multibody.Component class.

% Copyright 2024 The MathWorks, Inc.

%% Calculate geometry and inertia parameters of the Y-Axis Block.
widYSlideSurface = Parameters.widYRail; % Y-Axis block sliding surface width (m). It is same as rail width.
lenYRail = Parameters.strokeYGuide/(1-Parameters.fracLenYCarrgGuide);
lenYBlock = Parameters.fracLenYCarrgGuide*lenYRail;

lengthYBlock = simscape.Value(lenYBlock,"m");
widthYSlideSurface = simscape.Value(widYSlideSurface,"m");
sectionYBlock = createSectionBlock(widthYSlideSurface);
densityYBlock = simscape.Value(Parameters.rhoYCarriage,"kg/m^3");

%% Define frames of the Y-Axis block using the simscape.multibody.RigidTransform objects
rtYBlockF1 = simscape.multibody.RigidTransform(simscape.multibody.RotationSequenceRotation(simscape.multibody.FrameSide.Base,...
    simscape.multibody.AxisSequence.XYZ,simscape.Value([90 0 90],"deg")), simscape.multibody.StandardAxisTranslation ...
    (simscape.Value(widYSlideSurface,"m"), simscape.multibody.Axis.PosY));
rtYBlockF2 = simscape.multibody.RigidTransform(simscape.multibody.RotationSequenceRotation(simscape.multibody.FrameSide.Base,...
    simscape.multibody.AxisSequence.XYZ,simscape.Value([90 0 90],"deg")), simscape.multibody.StandardAxisTranslation ...
    (simscape.Value(1.5*widYSlideSurface,"m"), simscape.multibody.Axis.PosY));
framesYBlock = struct('F1',rtYBlockF1,'F2',rtYBlockF2);

%% Construct rigid body of the Y-Axis block using the function constructGeneralShapeRigidBody.
YBlockRB = constructGeneralShapeRigidBody(crossSection=sectionYBlock,length=lengthYBlock,density=densityYBlock,graphic=Parameters.graphicYCarriage,frames=framesYBlock);

%% Create a new simscape.multibody.Multibody object for Y-Axis Carriage
% Add the Multibody object for Y-Axis block to the multibody system for Y-Axis carriage using addComponent method of the Multibody object.
YCarriageMB = simscape.multibody.Multibody;
addComponent(YCarriageMB,"YBlock",YBlockRB);
addComponent(YCarriageMB,"World", simscape.multibody.WorldFrame);

%% Connect the rigid bodies in the Y-Axis Carriage multibody system using connect method of the Multibody object
connect(YCarriageMB,"World/W", "YBlock/F1");
end