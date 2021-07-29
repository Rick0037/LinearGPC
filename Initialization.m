    % Initialization script.
    % See also External_evaluation_START, External_evaluation_CONTINUE, External_evaluation_END

%% Load Paths
% Tools
    addpath('MLC_tools');
% Plant
    addpath(genpath('Plant'));
% ODE_solvers
    addpath('ODE_Solvers')

%% Show more
    more off;

%% MATLAB options
    % Version
    isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
    % Save
    if not(isOctave)
      rng('shuffle');
    end

%% Information display
% Header
fprintf('====================== ')
fprintf('xMLC ')
fprintf(' ==================\n')
% Version
disp(' Welcome to the xMLC software to solve non-convex')
disp(' regression problems.')
% Link
    fprintf('\n')
% Start
disp(' Start by creating a MLC object with : mlc=MLC;')
% Foot
fprintf('===========================')
fprintf('==========================\n')
fprintf('\n')

%% Initialization
%     mlc=MLC;
    
