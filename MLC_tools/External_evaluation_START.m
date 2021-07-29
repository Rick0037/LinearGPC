    % EXTERNAL_EVALUATION_START starts the run.
    % New control laws are generated in the Population folder and ready to be evaluated.
    % See also external_evaluation_CONTINUE, External_evaluation_END.

Initialization;
%% Start
    mlc=MLC('PinballMF');
    mlc.parameters.ProblemParameters.PathExt='';
    
%% Generate population
    mlc.generate_population;
    
%% Save
    mlc.save_matlab('Gen0');
