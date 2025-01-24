function genShapeRigidBody = constructGeneralShapeRigidBody(Parameters) 
%% Define input argument validation
arguments
    Parameters.crossSection (:,2)
    Parameters.length (1,1)
    Parameters.density (1,1) 
    Parameters.graphic (1,:) double
    Parameters.frames (:,:) struct
end
% This function creates a general shape solid using objects of the 
% simscape.multibody.Component class.
%
% Specify:
%   crossSection - cross-section of solid as simscape.Value
%   length - length of solid as simscape.Value
%   density - density of solid as simscape.Value
%   graphic - graphic properties of solid as [R,G,B,opacity]. Opacity by
%   default is 1.
%   frames - frame definitions of solid as a structure array as
%   ['frameName',rigidTransformFrame].

% Copyright 2024 The MathWorks, Inc.

%% Create a simscape.multibody.Multibody object to construct a general shape rigid body

% Create an object of the class RigidBody. The RigidBody class is a 
% container which can comprise of solids, inertias, graphics, frames and 
% other rigid body objects.

extrusion = simscape.multibody.GeneralExtrusion(Parameters.crossSection,Parameters.length);
inertia = simscape.multibody.UniformDensity(Parameters.density);
graphics = simscape.multibody.SimpleVisualProperties(Parameters.graphic);

genShapeRigidBody = simscape.multibody.RigidBody;
genShapeSolid = simscape.multibody.Solid(extrusion,inertia,graphics);
addComponent(genShapeRigidBody,'Solid','reference',genShapeSolid);

frameNames = fieldnames(Parameters.frames);
for ii=1:numel(frameNames)
    frameName = frameNames{ii};
    rtFrame = getfield(Parameters.frames,frameName);
    genShapeRigidBody.addFrame(frameName, 'reference', rtFrame);
    genShapeRigidBody.addConnector(frameName);
end

end