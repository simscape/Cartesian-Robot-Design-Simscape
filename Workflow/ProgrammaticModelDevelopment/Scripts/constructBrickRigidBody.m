function brickRigidBody = constructBrickRigidBody(Parameters)  %inertiaType,density,mass,centerOfMass,momentsOfInertia,productsOfInertia
%% Define input argument validation
arguments
    Parameters.dimensions (1,3)
    Parameters.density (1,1)
    Parameters.graphic (1,:) double {mustBePositive,mustBeReal}
    Parameters.frames (:,:) struct
end
% This function creates a brick solid using objects of the 
% simscape.multibody.Component class.
%
% Specify:
%   dimensions - dimensions of solid as simscape.Value in vector
%   [length,width,height] form.
%   density - density of solid as simscape.Value
%   graphic - graphic properties of solid as [R,G,B,opacity]. Opacity by
%   default is 1.
%   frames - frame definitions of solid as a structure array as
%   ['frameName',rigidTransformFrame].

% Copyright 2024 The MathWorks, Inc.

%% Create a simscape.multibody.Multibody object to construct the brick rigid body

% Create an object of the class RigidBody. The RigidBody class is a 
% container which can comprise of solids, inertias, graphics, frames and 
% other rigid body objects.

brickDimensions = simscape.multibody.Brick(Parameters.dimensions);
inertia = simscape.multibody.UniformDensity(Parameters.density);
graphics = simscape.multibody.SimpleVisualProperties(Parameters.graphic);

brickRigidBody = simscape.multibody.RigidBody;
brickSolid = simscape.multibody.Solid(brickDimensions,inertia,graphics);
addComponent(brickRigidBody,'Solid','reference',brickSolid);

frameNames = fieldnames(Parameters.frames);
for ii=1:numel(frameNames)
    frameName = frameNames{ii};
    rtFrame = getfield(Parameters.frames,frameName);
    brickRigidBody.addFrame(frameName, 'reference', rtFrame);
    brickRigidBody.addConnector(frameName);
end

end