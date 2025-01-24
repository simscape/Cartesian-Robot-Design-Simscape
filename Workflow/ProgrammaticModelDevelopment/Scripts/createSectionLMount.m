function sectionLMount = createSectionLMount(widthLMount,thickMount)
arguments
    widthLMount (1,1)
    thickMount (1,1)
end
% This function creates cross section of a L-shaped mount or L-mount.

% Copyright 2024 The MathWorks, Inc.

% Define coordinates of vertices of the L-mount
vL1 = [widthLMount, thickMount];
vL2 = [widthLMount, 0];
vL3 = [0*widthLMount, 0*widthLMount];
vL4 = [0, widthLMount];
vL5 = [thickMount, widthLMount];
vL6 = [thickMount, thickMount];

% Derived section of block from vertices
sectionLMount = flipud([vL1; vL2; vL3; vL4; vL5; vL6]);