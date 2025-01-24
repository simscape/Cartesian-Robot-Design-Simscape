classdef ProgrammaticCartesianRobotModelDevelopmentWorkflowTest < InitializeTestForWorkflows & matlab.unittest.TestCase
    % The test class runs the scripts and functions associated with
    % Programmatic Cartesian Robot Model Development Workflow and verify 
    % there are no warnings or errors when files are executed.
    
    % Copyright 2024 The MathWorks, Inc.

    methods (Test)

        function TestProgrammaticCartesianRobotModelDevelopmentMLX(test)
            %The test runs the |.mlx| file and makes sure that there are
            %no errors or warning thrown.
            test.verifyWarningFree(@()runProgrammaticCartesianRobotModelDevelopmentWorkflow, ...
                '''ProgrammaticCartesianRobotModelDevelopment'' |.mlx|  should execute without any warnings or errors.');
        end

    end

end

function runProgrammaticCartesianRobotModelDevelopmentWorkflow()
% Function runs the |.mlx| script.
ProgrammaticCartesianRobotModelDevelopment;
end