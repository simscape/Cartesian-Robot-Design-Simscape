classdef  MountComponentTest< matlab.unittest.TestCase
    % This test sets up a test harness model with the "mount" block of the
    % connected to a World Frame block and a Reference Frame block. The
    % test verifies that the harness model set with default values of block
    % parameters simulates without any errors or warnings. The test also
    % verifies that the harness model set with custom values of block
    % parameters simulates without any errors or warnings.

    % Copyright 2024 The MathWorks, Inc.
    
    properties
        % Model and Block under test
        modelname = 'testModelTemplate';
        blockname = 'Mount';

        % Source block
        sourceBlock = 'CartesianLib/Mount';
        blockpath;
    end

    properties(TestParameter)
        % Drop down options for "Mount type" parameter
        mountType = {'Plate Mount','L-shaped mount','Angle mount'}

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

        function verifySimulationForDefaultValues(test,mountType,inertiaType)
            % This test point verifies that the test harness model
            % (containing the column block) simulates without any warnings
            % and errors for default values.
            set_param(test.blockpath,'typeMount',mountType)
            set_param(test.blockpath,'typeInertiaMount',inertiaType);
            set_param(test.modelname,'SimMechanicsOpenEditorOnUpdate','off');
            set_param(test.modelname,'SimulationCommand','update');

            % Verify that the simulation is error and/or warnings free
            test.verifyWarningFree(@()sim(test.modelname),...
                ['The model with block- ''', test.blockname, ''' should simulate without any errors and/or warnings.']);
        end

        function verifyChangeInInertiaTypeUpdatesSubsystemBlocks(test,mountType)
            % This test verifies that changing the inertia type from
            % "calculate from geometry" to "Custom" updates the
            % corresponding sub system blocks.
            set_param(test.blockpath,'typeMount',mountType)
            set_param(test.blockpath,'typeInertiaMount','Custom');
            set_param(test.modelname,'SimMechanicsOpenEditorOnUpdate','off');
            set_param(test.modelname,'SimulationCommand','update');          

            % Verify
            verifyInertiaTypeUpdateInCorrespondingSubsystemBlock(test,mountType);
        end

        function verifySimulationForUserDefinedValues(test,mountType)
            % This test point verifies that the test harness model
            % (containing the column block) simulates without any warnings
            % and errors for user-defined values.

            set_param(test.blockpath,'typeMount',mountType);
            set_param(test.modelname,'SimMechanicsOpenEditorOnUpdate','off');
            verifyWarningAndErrorFreeSimulation(test,mountType);           
        end

    end
    methods
        function verifyInertiaTypeUpdateInCorrespondingSubsystemBlock(test,mountType)
            % This method verifies that the "inertia type" has changed for
            % the given subsytem block
            switch mountType
                case 'Plate Mount'
                    currentSubSystemBlockpath = [test.blockpath,'/','Mount System','/','Plate Mount','/','Brick Solid'];
                    parameterTypeColumn = get_param(currentSubSystemBlockpath,'InertiaType');
                    test.verifyEqual(parameterTypeColumn,'Custom',['The inertia ' ...
                        'type parameter of the "Brick Solid" block of the ' ...
                        '"Plate Mount" sub system block is not updated']);

                case 'L-shaped mount'
                    currentSubSystemBlockpath = [test.blockpath,'/','Mount System','/','L-Shaped Mount','/','Extruded Solid'];
                    parameterTypeColumn = get_param(currentSubSystemBlockpath,'InertiaType');
                    test.verifyEqual(parameterTypeColumn,'Custom',['The inertia ' ...
                        'type parameter of the "Extruded Solid" block of the ' ...
                        '"L-Shaped Mount" sub system block is not updated']);

                case 'Angle mount'
                    currentSubSystemBlockpath = [test.blockpath,'/','Mount System','/','Angle Mount','/','Extruded Solid'];
                    parameterTypeColumn = get_param(currentSubSystemBlockpath,'InertiaType');
                    test.verifyEqual(parameterTypeColumn,'Custom',['The inertia ' ...
                        'type parameter of the "Extruded Solid" block of the ' ...
                        '"Angle Mount" sub system block is not updated']);
            end
        end

        function verifyWarningAndErrorFreeSimulation(test,mountType)
            % This method verifies that the simulation (with user defined
            % parameters) for each configuration (i.e. Plate mount,
            % L-shaped mount and Angle Mount) of the Mount library is free
            % of warnings and errors

            switch mountType
                case 'Plate Mount'
                    set_param(test.blockpath,'widthMount','0.01');
                    set_param(test.modelname,'SimMechanicsOpenEditorOnUpdate','off');
                    test.verifyWarningFree(@()sim(test.modelname),...
                        ['The model with block- ''', test.blockname, ''' with configuration',mountType,'should simulate without any errors and/or warnings.']);

                case 'L-shaped mount'
                    set_param(test.blockpath,'widthMount','0.02');
                    set_param(test.blockpath,'angleRotate','40');
                    set_param(test.modelname,'SimMechanicsOpenEditorOnUpdate','off');
                    test.verifyWarningFree(@()sim(test.modelname),...
                        ['The model with block- ''', test.blockname, ''' with configuration',mountType,'should simulate without any errors and/or warnings.']);

                case 'Angle mount'
                    set_param(test.blockpath,'widthMount','0.03');
                    set_param(test.blockpath,'angleRotate','40');
                    set_param(test.blockpath,'angleMount','120');
                    set_param(test.modelname,'SimMechanicsOpenEditorOnUpdate','off');
                    test.verifyWarningFree(@()sim(test.modelname),...
                        ['The model with block- ''', test.blockname, ''' with configuration',mountType,'should simulate without any errors and/or warnings.']);
            end
        end
    end

end