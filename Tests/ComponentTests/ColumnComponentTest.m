classdef ColumnComponentTest < matlab.unittest.TestCase
    % This test sets up a test harness model with the "column" block of the  
    % connected to a World Frame block and a Reference Frame block. The 
    % test verifies that the harness model set with default values of block 
    % parameters simulates without any errors or warnings. The test also 
    % verifies that the harness model set with custom values of block 
    % parameters simulates without any errors or warnings.

    % Copyright 2024 The MathWorks, Inc.
    
    properties
        % Model and Block under test
        modelname = 'testModelTemplate';
        blockname = 'Column';

        % Source block
        sourceBlock = 'CartesianLib/Column';
        blockpath;
    end

    properties(TestParameter)
         % Dropdown options for 'inertiaType' parameter
        inertiaType = {'Calculate from Geometry', 'Custom'};
    end

    methods (TestClassSetup)
       function openModelWithTeardown(test)
            % Open model and add teardown.
            open_system(test.modelname);
            test.addTeardown(@()close_system(test.modelname, 0));
        end

        function setupBlockForTesting(test)
            % Setup test model
            
            % Add block to the test model
            test.blockpath = [test.modelname, '/', test.blockname];
            add_block(test.sourceBlock, test.blockpath, 'Position', [-220,193,-35,302]);

            % Add 'Reference Frame' block to the test model
            referenceFrameBlock = 'Reference Frame';
            add_block('sm_lib/Frames and Transforms/Reference Frame',...
                [test.modelname, '/', referenceFrameBlock], 'Position', [-135,350,-95,390]);

            % Connect blocks
            add_line(test.modelname, 'World Frame/RConn1', [test.blockname, '/LConn1']);
            add_line(test.modelname, [referenceFrameBlock, '/RConn1'], [test.blockname, '/RConn1']);
        end
    end

    methods (Test)
        % Test methods

        function verifySimulationForDefaultValues(test,inertiaType)
            % This test point verifies that the test harness model
            % (containing the column block) simulates without any warnings
            % and errors for default values.
            set_param(test.blockpath,'typeInertiaColumn',inertiaType);
            set_param(test.modelname,'SimulationCommand','update');

            % Verify that the simulation is error and/or warnings free
            test.verifyWarningFree(@()sim(test.modelname),...
                ['The model with block- ''', test.blockname, ''' should simulate without any errors and/or warnings.']);        
        end

        function verifyChangeInInertiaTypeUpdatesSubsystemBlocks(test)
            % This test verifies that changing the inertia type from
            % "calculate from geometry" to "Custom" updates the
            % corresponding sub system blocks.
            set_param(test.blockpath,'typeInertiaColumn','Custom');
            set_param(test.modelname,'SimulationCommand','update');

            % Getting the block parameter of the "Column" sub system
            % block and verifying that it is updated
            subSystemBlockpathPillar = [test.blockpath,'/','Pillar'];
            parameterTypeColumn = get_param(subSystemBlockpathPillar,'InertiaType');
            test.verifyEqual(parameterTypeColumn,'Custom',['The inertia type parameter' ...
                'of the "Pillar" sub system block is not updated']);

            % Getting the block parameter of the "Base Plate" sub system
            % block and verifying that it is updated
            subSystemBlockpathBasePlate = [test.blockpath,'/','Base Plate'];
            parameterTypeBasePlate = get_param(subSystemBlockpathBasePlate,'InertiaType');
            test.verifyEqual(parameterTypeBasePlate,'Custom',['The inertia type parameter' ...
                'of the "Base Plate" sub system block is not updated']);

            % Getting the block parameter of the "Top Plate" sub system
            % block and verifying that it is updated
            subSystemBlockpathTopPlate = [test.blockpath,'/','Top Plate'];
            parameterTypeTopPlate = get_param(subSystemBlockpathTopPlate,'InertiaType');
            test.verifyEqual(parameterTypeTopPlate,'Custom',['The inertia type parameter' ...
                'of the "Top Plate" sub system block is not updated']);       
        end

        function verifySimulationForUserDefinedValues(test)
            % This test point verifies that the test harness model
            % (containing the column block) simulates without any warnings
            % and errors for user-defined values.

            set_param(test.blockpath,'widthColumn','0.01');
            set_param(test.blockpath,'lengthColumn','0.3');
            set_param(test.modelname,'SimulationCommand','update');

            % Verify that the simulation is error and/or warnings free
            test.verifyWarningFree(@()sim(test.modelname),...
                ['The model with block- ''', test.blockname, ''' should simulate without any errors and/or warnings.']); 
        end



    end

end