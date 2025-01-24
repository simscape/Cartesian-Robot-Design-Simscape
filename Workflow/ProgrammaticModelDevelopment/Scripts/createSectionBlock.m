function sectionBlock = createSectionBlock(widthSlidingSurface)
arguments
    widthSlidingSurface (1,1)
end
% This function creates cross section of a block (carriage) used in a 
% linear guide.

% Copyright 2024 The MathWorks, Inc.

% Define coordinates of vertices of the block
v1 = [0.95*widthSlidingSurface, 1.5*widthSlidingSurface];
v2 = [-0.95*widthSlidingSurface, 1.5*widthSlidingSurface];
v3 = [-widthSlidingSurface, 1.45*widthSlidingSurface];
v4 = [-widthSlidingSurface, 0.32*widthSlidingSurface];
v5 = [-0.95*widthSlidingSurface, 0.27*widthSlidingSurface];
v6 = [-0.5*widthSlidingSurface, 0.27*widthSlidingSurface];
v7 = [-0.4*widthSlidingSurface, 0.45*widthSlidingSurface];
v8 = [-0.4*widthSlidingSurface, 0.6*widthSlidingSurface];
v9 = [-0.5*widthSlidingSurface, 0.75*widthSlidingSurface];
v10 = [-0.5*widthSlidingSurface, 0.85*widthSlidingSurface];
v11 = [-0.4*widthSlidingSurface, widthSlidingSurface];
v12 = [0.4*widthSlidingSurface, widthSlidingSurface];
v13 = [0.5*widthSlidingSurface, 0.85*widthSlidingSurface];
v14 = [0.5*widthSlidingSurface, 0.75*widthSlidingSurface];
v15 = [0.4*widthSlidingSurface, 0.6*widthSlidingSurface];
v16 = [0.4*widthSlidingSurface, 0.45*widthSlidingSurface];
v17 = [0.5*widthSlidingSurface, 0.27*widthSlidingSurface];
v18 = [0.95*widthSlidingSurface, 0.27*widthSlidingSurface];
v19 = [widthSlidingSurface, 0.32*widthSlidingSurface];
v20 = [widthSlidingSurface, 1.45*widthSlidingSurface];

% Derived section of block from vertices
sectionBlock = [v1; v2; v3; v4; v5; v6; v7; v8; v9; v10; v11; v12;...
    v13; v14; v15; v16; v17; v18; v19; v20];