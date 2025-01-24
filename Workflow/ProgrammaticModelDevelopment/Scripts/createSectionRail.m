function sectionRail = createSectionRail(widthRail)
arguments
    widthRail (1,1)
end
% This function creates cross section of a rail used in a linear guide.

% Copyright 2024 The MathWorks, Inc.

% Define coordinates of vertices of the rail
v1 = [0.4*widthRail, widthRail];
v2 = [-0.4*widthRail, widthRail];
v3 = [-0.5*widthRail, 0.85*widthRail];
v4 = [-0.5*widthRail, 0.75*widthRail];
v5 = [-0.4*widthRail, 0.6*widthRail];
v6 = [-0.4*widthRail, 0.45*widthRail];
v7 = [-0.5*widthRail, 0.27*widthRail];
v8 = [-0.5*widthRail, 0.05*widthRail];
v9 = [-0.45*widthRail, 0];
v10 = [0.45*widthRail, 0];
v11 = [0.5*widthRail, 0.05*widthRail];
v12 = [0.5*widthRail, 0.27*widthRail];
v13 = [0.4*widthRail, 0.45*widthRail];
v14 = [0.4*widthRail, 0.6*widthRail];
v15 = [0.5*widthRail, 0.75*widthRail];
v16 = [0.5*widthRail, 0.85*widthRail];

% Derived section of rail from vertices
sectionRail = [v1; v2; v3; v4; v5; v6; v7; v8; v9; v10; v11; v12; v13; v14; v15; v16];