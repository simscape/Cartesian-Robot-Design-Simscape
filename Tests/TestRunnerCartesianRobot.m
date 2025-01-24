% Test runner for Cartesian Robot Design With Simscape project
% The test runner sricpt for this project is used to create a test suite 
% that consists of test scripts in the 'Tests' folder. The runner runs 
% this test suite and generates output.

% Copyright 2024 - 2025 The MathWorks, Inc.

relStr = matlabRelease().Release;
disp("This is MATLAB " + relStr + ".");

topFolder = currentProject().RootFolder; 

%% Create test suite
% Test suite for unit test
suite = matlab.unittest.TestSuite.fromFolder(fullfile(topFolder,"Tests"), 'IncludingSubfolders', true);
suite = selectIf(suite, 'Superclass', 'matlab.unittest.TestCase');

%% Create test runner
runner = matlab.unittest.TestRunner.withTextOutput(...
    'OutputDetail',matlab.unittest.Verbosity.Detailed);

%% Set up JUnit style test results
runner.addPlugin(matlab.unittest.plugins.XMLPlugin.producingJUnitFormat(...
    fullfile(topFolder, "Tests", "CartesianRobot_TestResults_"+relStr+".xml")));

%% MATLAB Code Coverage Report
coverageReportFolder = fullfile(topFolder, "coverage-CartesianRobotCodeCoverage" + relStr);
if ~isfolder(coverageReportFolder)
    mkdir(coverageReportFolder)
end

coverageReport = matlab.unittest.plugins.codecoverage.CoverageReport( ...
    coverageReportFolder, MainFile = "CartesianRobotCoverageReport" + relStr + ".html" );

% Code Coverage Plugin
list = dir(fullfile(topFolder, '**/*.*'));
list = list(~[list.isdir] & endsWith({list.name}, {'.m', '.mlx'}) & ~contains({list.folder},'Test'));
fileList = arrayfun(@(x)[x.folder, filesep, x.name], list, 'UniformOutput', false);
codeCoveragePlugin = matlab.unittest.plugins.CodeCoveragePlugin.forFile(fileList, Producing = coverageReport );
addPlugin(runner, codeCoveragePlugin);

%% Run tests
results = run(runner, suite);
out = assertSuccess(results);
disp(out); 