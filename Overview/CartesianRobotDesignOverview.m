%% Cartesian Robot Design with Simscape
% 
% This project contains custom libraries, models and code to help 
% you design Cartesian robots. You can learn to perform a positional 
% accuracy analysis for a 3D printing operation.
%

% Copyright 2024 The MathWorks, Inc.

%% Cartesian Robot For 3D Printing Operation
%
% Cartesian robots operate on three linear axes (X, Y, and Z). They are 
% widely used in applications such as CNC machining, 3D printing, and 
% automated assembly due to their straightforward movement and control. 
% The development of Cartesian robots involves the 
% design, control, and implementation of mechanical systems capable of 
% performing precise tasks. Mechanical designers often use Computer-Aided 
% Design (CAD) models to evaluate a design. To meet all the functional 
% requirements, the CAD design process is generally iterative and can be 
% time consuming. You can accelerate the development process by starting 
% with a system-level analysis to evaluate your options. This project shows 
% how to create a system-level simplified parametric robot model using 
% Simscape Multibody(TM).
%
% * To open the Cartesian robot model for 3D printing application, click
% <matlab:open_system('XYZCartesianRobot3DPrinting.slx') 3D Printing XYZ 
% Cartesian Robot Model>.
% 
% <<CartesianRobotModel.png>>
% 
% * You can configure the robot subsystem for Cantilever Cartesian robot or
% Gantry robot and tune controllers accordingly. You can define your own 
% custom trajectory and analyze the path tracing for 3D printing operation.
% * You can compare measured axis positions with target values 
% using the Scope block called Axis Positions on model canvas.
% * To learn how to determine positional accuracy for a 3D printing 
% operation using a Simscape model, see 
% <matlab:open('PositionalAccuracyAnalysis.mlx') Perform Positional Accuracy 
% Analysis for a 3D Printing Cartesian Robot>.
%
% To design your own Cartesian robot, you can leverage the existing 
% custom library blocks or create your new custom blocks. To learn more on 
% how to do that, go to the next section and follow the 3-step process. You 
% will also learn how to tune the control system to achieve high positional 
% accuracy for 3D printing.
%
%% Design Your Own Cartesian Robot
% 
% This section shows you how to build and 
% parameterize components, assemble them to build a Cartesian robot, and 
% verify a final design for a 3D printing application. Follow these 
% steps to design a Cartesian robot.
%
% 1. *Design Components:* The project contains custom library blocks such 
% as <matlab:web('DocumentationLinearStage.html','-new') Linear Stage>, 
% <matlab:web('DocumentationColumn.html','-new') Column>, 
% <matlab:web('DocumentationMount.html','-new') Mount>. The custom library blocks 
% serve as early-stage or system-level mechanical design tools for 
% quick prototyping and development of a simplified parametric Cartesian 
% robot. The custom library blocks use the foundation of Simscape Multibody. 
% You can parameterize custom library blocks to suit your application.
%
% 2. *Assemble Robot from Components:* Assemble the parameterized blocks to 
% build integrated robot models with tools or end effectors. You can build 
% robot models of various configurations like Cantilever Cartesian robot 
% and Gantry robot. You can represent the payloads and operating environment 
% using Simscape Multibody. You can also use Simscape Multibody in MATLAB(R) 
% classes to assemble and visualize a robot. To assemble, visualize and scale a 
% Cartesian robot model using Simscape Multibody in MATLAB classes, see 
% <matlab:open('ProgrammaticCartesianRobotModelDevelopment.mlx') Develop a 
% Cartesian Robot Model Programmatically>.
%
% 3. *Perform Positional Accuracy Analysis for 3D Printing:* You can use a 
% robot model with electric actuation and control system to perform a task. 
% To determine the positional accuracy of the robot performing a 3D 
% printing, see <matlab:open('PositionalAccuracyAnalysis.mlx') Perform 
% Positional Accuracy Analysis for a 3D Printing Cartesian Robot>.
% 
%% Workflows  
%
% * <matlab:open('ProgrammaticCartesianRobotModelDevelopment.mlx') Develop a 
% Cartesian Robot Model Programmatically>
% * <matlab:open('PositionalAccuracyAnalysis.mlx') Perform 
% Positional Accuracy Analysis for a 3D Printing Cartesian Robot>
%
%% Model
%
% * <matlab:open_system('XYZCartesianRobot3DPrinting.slx') 3D Printing XYZ 
% Cartesian Robot Model>
%
