classdef PositionalAccuracyAnalysisWorkflowTest < InitializeTestForWorkflows & matlab.unittest.TestCase
    % The test class runs the scripts and functions associated with
    % Positional Accuracy Analysis Workflow and verify there are no 
    % warnings or errors when files are executed.
    
    % Copyright 2024 The MathWorks, Inc.

    methods (Test)

        function TestPositionalAccuracyAnalysisMLX(test)
            %The test runs the |.mlx| file and makes sure that there are
            %no errors or warning thrown.
            modelname = "XYZCartesianRobot3DPrinting";
            set_param(modelname,'SimMechanicsOpenEditorOnUpdate','off');
            test.verifyWarningFree(@()runPositionalAccuracyAnalysis,...
                '''PositionalAccuracyAnalysis'' |.mlx|  should execute without any warnings or errors.');

        end

    end

end


function runPositionalAccuracyAnalysis
% Function runs the |.mlx| script.
% testScript = true; %#ok<NASGU> % Required to run script for less number of sensors.
PositionalAccuracyAnalysis;
end