classdef LinearStageComponentTest < matlab.unittest.TestCase
    % This test sets up a test harness model with the "Linear Stage" 
    % block of the connected to a World Frame bloof block parameters simulates
    % without any errors or warnings. The test also verifies that the harness 
    % model set with custom values of block parameters simulates without any 
    % errors or warnings.

    % Copyright 2024 The MathWorks, Inc.

    properties
        % Model and Block under test
        modelname = 'testModelTemplate';
        blockname = 'Linear Stage';

        % Source block
        sourceBlock = 'CartesianLib/Linear Stage';
        blockpath;
    end

    properties(TestParameter)
        % Drop down options for  "Guide system" parameter
        systemGuide = {'Rail-block','Lead screw-bearing'}

        % Drop down option for "Guide Axis" parameter
        axisGuide = {'X-axis','Y-axis','Z-axis'};
       
        % Dropdown options for "typeInertiaGuide" parameter for Linear Guide
        inertiaGuide = {'Calculate from Geometry', 'Custom'};

        % Dropdown options for "typeInertiaCarraige" parameter for Linear Guide
        inertiaCarraige = {'Calculate from Geometry', 'Custom'};


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
            prismaticJointBlock = 'Prismatic Joint';
            prismaticJointBlockPath = 'sm_lib/Joints/Prismatic Joint';
            add_block('sm_lib/Frames and Transforms/Reference Frame',...
                [test.modelname, '/', referenceFrameBlock], 'Position', [25,195,65,235]);
            add_block(prismaticJointBlockPath,[test.modelname, '/', prismaticJointBlock],'Position',[-145,320,-105,360]);

            % Connect blocks
            add_line(test.modelname, 'World Frame/RConn1', [test.blockname, '/LConn1']);
            add_line(test.modelname, [referenceFrameBlock, '/RConn1'], [test.blockname, '/RConn1']);
            add_line(test.modelname, [prismaticJointBlock,'/RConn1'],[test.blockname, '/RConn2']);
            add_line(test.modelname, [prismaticJointBlock,'/LConn1'],[test.blockname, '/LConn2']);
        end
    end

    methods (Test)
        % Test methods

        function verifySimulationForDefaultValues(test,inertiaGuide,inertiaCarraige,systemGuide,axisGuide)
            % This test point verifies that the test harness model
            % (containing the column block) simulates without any warnings
            % and errors for default values.
            set_param(test.blockpath,'typeInertiaGuide',inertiaGuide);
            set_param(test.blockpath,'typeInertiaCarriage',inertiaCarraige)
            set_param(test.blockpath,'systemGuide',systemGuide);
            set_param(test.blockpath,'axisGuide',axisGuide);
            set_param(test.modelname,'SimMechanicsOpenEditorOnUpdate','off');
            set_param(test.modelname,'SimulationCommand','update');           

            % Verify that the simulation is error and/or warnings free
            test.verifyWarningFree(@()sim(test.modelname),...
                ['The model with block- ''', test.blockname, ''' should simulate without any errors and/or warnings.']);
        end

        function verifySimulationForCustomValues(test,inertiaGuide,inertiaCarraige,systemGuide,axisGuide)
            % This test point verifies that the test harness model
            % (containing the column block) simulates without any warnings
            % and errors for valid user defined values.
            set_param(test.blockpath,'typeInertiaGuide',inertiaGuide);
            set_param(test.blockpath,'typeInertiaCarriage',inertiaCarraige)
            set_param(test.blockpath,'systemGuide',systemGuide);
            set_param(test.blockpath,'axisGuide',axisGuide);
            setParametersForTheBlock(test,inertiaGuide,inertiaCarraige,systemGuide);
            set_param(test.modelname,'SimMechanicsOpenEditorOnUpdate','off');
            set_param(test.modelname,'SimulationCommand','update');
            

             % Verify that the simulation is error and/or warnings free
            test.verifyWarningFree(@()sim(test.modelname),...
                ['The model with block- ''', test.blockname, ''' should simulate without any errors and/or warnings.']);
        end



    end

    methods
        function setParametersForTheBlock(test,inertiaGuide,inertiaCarraige,systemGuide)
            % This method sets the libraray block with the custom values
        
            if (ismember(systemGuide,'Rail-block'))
                set_param(test.blockpath,'stroke','2');
                set_param(test.blockpath,'widthRail','0.25');                
            end

            if(isequal(systemGuide,'Lead screw-bearing'))
                set_param(test.blockpath,'stroke','3');
                set_param(test.blockpath,'diaScrew','0.5');
            end

            if(isequal(inertiaGuide,'Calculate from Geometry'))
                set_param(test.blockpath,'densityGuide','2500');
            end

            if(isequal(inertiaGuide,'Custom'))
                set_param(test.blockpath,'massGuide','100');
                set_param(test.blockpath,'CMGuide','[0.02,0.02,0.02]');
                set_param(test.blockpath,'MOIGuide','[1.5,1.5,1.5]');
                set_param(test.blockpath,'POIGuide','[0.02,0.02,0.02]');
            end

            if(isequal(inertiaCarraige,'Calculate from Geometry'))
                set_param(test.blockpath,'densityCarriage','3000');
            end

             if(isequal(inertiaCarraige,'Custom'))
                set_param(test.blockpath,'massGuide','150');
                set_param(test.blockpath,'CMGuide','[0.02,0.02,0.02]');
                set_param(test.blockpath,'MOIGuide','[1.5,1.5,1.5]');
                set_param(test.blockpath,'POIGuide','[0.02,0.02,0.01]');
             end          
        end
    end

end