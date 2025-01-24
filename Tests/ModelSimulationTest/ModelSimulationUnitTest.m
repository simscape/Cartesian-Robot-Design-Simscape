classdef ModelSimulationUnitTest < matlab.unittest.TestCase
    % This MATLAB unit test is used to run the Simulink models for the
    % project. The test verifies that models simulate without any errors or 
    % warnings. 

    % Copyright 2024 The MathWorks, Inc.

    methods (Test)

        function testGantryRobotModel(testCase)
            % Test for the GantryRobot subsystem harness model

            % Load system and add teardown
            modelname = "GantryRobot";
            load_system(modelname)
            testCase.addTeardown(@()close_system(modelname, 0));
            set_param(modelname,'SimMechanicsOpenEditorOnUpdate','off');

            % Simulate model
            testCase.verifyWarningFree(@()sim(modelname),['The "Gantry Robot Model"' ...
                'simulated without any warnings or errors.']);
        end

        function testCantileverCartesianRobotModel(testCase)
            % Test for the CantileverCartesianRobot subsystem harness model

            % Load system and add teardown
            modelname = "CantileverCartesianRobot";
            load_system(modelname)
            testCase.addTeardown(@()close_system(modelname, 0));
            set_param(modelname,'SimMechanicsOpenEditorOnUpdate','off');

            % Simulate model
            testCase.verifyWarningFree(@()sim(modelname),['The "Cantilever Cartesian Robot Model"' ...
                'simulated without any warnings or errors.']);
        end

        function testCartesianRobot3DPrintingModel(testCase)
            % Test for the CartesianRobot3DPrinting example model

            % Load system and add teardown
            modelname = "XYZCartesianRobot3DPrinting";
            load_system(modelname)
            testCase.addTeardown(@()close_system(modelname, 0));
            set_param(modelname,'SimMechanicsOpenEditorOnUpdate','off');

            % Simulate model
            testCase.verifyWarningFree(@()sim(modelname),['The "Cartesian Robot 3D Printing model"' ...
                'simulated without any warnings or errors.']);
        end

    end

end