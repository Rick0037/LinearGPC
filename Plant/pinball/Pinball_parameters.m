function parameters = Pinball_parameters()
	% GMFM_parameters sets the parameters for an GMFM problem.
    
%% Options
    parameters.verbose=2;

%% Problem parameters
% Problem
    parameters.Name = 'Pinball1';
    parameters.EvaluationFunction = 'external';
        % Problem variables
        % The inputs and outputs are considered from the controller point
        % of view. Thus ouputs are the controllers (plasma, jets) and
        % inputs are sensors and time dependent functions.
        % Outputs - Number of control laws
        ProblemParameters.OutputNumber = 3; % number of controllers
        ProblemParameters.InputNumber = 36; % number of sensors       
            % si(t)
            ProblemParameters.NumberSensors = 36;
                SensorsEval{ProblemParameters.InputNumber} = '0';
                for p=1:9
                    SensorsEval{p} = ['s(',num2str(p),',T)'];
                    SensorsEval{p+9} = ['s(',num2str(p),',T-2)'];
                    SensorsEval{p+18} = ['s(',num2str(p),',T-4)'];
                    SensorsEval{p+27} = ['s(',num2str(p),',T-6)'];
                end
                ProblemParameters.Sensors = SensorsEval; % name in the problem
            % hi(t)
            ProblemParameters.NumberTimeDependentFunctions = 0;
            ProblemParameters.TimeDependentFunctions = {}; % syntax in MATLAB/Octave
%             ProblemParameters.TimeDependentFunctions{2,:} = {}; % syntax in the problem (if null then comment)
                % Test (to export)
                if ProblemParameters.NumberSensors+ProblemParameters.NumberTimeDependentFunctions~=ProblemParameters.InputNumber
                          error('Number of inputs is not well defined')
                end
        % Control Syntax
        Sensors = cell(1,ProblemParameters.NumberSensors); %*
        TDF = cell(1,ProblemParameters.NumberTimeDependentFunctions); %*
        for p=1:ProblemParameters.NumberSensors,Sensors{p} = ['s(',num2str(p),')'];end %*
        for p=1:ProblemParameters.NumberTimeDependentFunctions,TDF{p} = ['h(',num2str(p),')'];end %*
        ControlSyntax = horzcat(Sensors,TDF); %*
        % Round evaluation of control points and J
        ProblemParameters.RoundEval = 6;
        % Fortran ?
        ProblemParameters.fortran_evaluation = 0;
        % Evaluation
        ProblemParameters.Tmax = [400 1400];
        % Actuation limitation -[lower bound,upper bound]
            act_lim = [-5,5;... % front cylinder
                -5,5;... % bottom cylinder
                -5,5]; % top cylinder
        ProblemParameters.ActuationLimit = act_lim;
        % Costs        
        ProblemParameters.J0 = 1.56; % no actuation
        ProblemParameters.Jmin = 0.8627; % best boat-tailing
        ProblemParameters.Jmax = inf;
        % Round evaluation
        ProblemParameters.EstimatePerformance = 'mean'; % default 'mean', if drift 'last'
        ProblemParameters.gamma = [0,0,0,0,0,0]; % Jb,Jc,Jd,Je,Jf,Jg
        % Path for external evaluation
        ProblemParameters.PathExt = '../../Pinball_MLC_OUTPUT/Costs'; % Pinball
    % Definition
    parameters.ProblemParameters = ProblemParameters;
    
%% Control law parameters
        % Number of instructions
        ControlLaw.InstructionSize.InitMax=50;
        ControlLaw.InstructionSize.InitMin=1;
        ControlLaw.InstructionSize.Max=50;
        % Operators
        ControlLaw.OperatorIndices = 1:9;
            %   implemented:     - 1  addition       (+)
            %                    - 2  substraction   (-)
            %                    - 3  multiplication (*)
            %                    - 4  division       (%)
            %                    - 5  sinus         (sin)
            %                    - 6  cosinus       (cos)
            %                    - 7  logarithm     (log)
            %                    - 8  exp           (exp)
            %                    - 9  tanh          (tanh)
            %                    - 10 square        (.^2)
            %                    - 11 modulo        (mod)
            %                    - 12 power         (pow)
            %
        ControlLaw.Precision = 6;
        % Registers
            % Number of variable registers
            VarRegNumberMinimum = ProblemParameters.OutputNumber+ProblemParameters.InputNumber; %*
            ControlLaw.VarRegNumber = VarRegNumberMinimum + 3; % add some memory slots if needed  
            % Number of constant registers
            ControlLaw.CstRegNumber = 10;
            ControlLaw.CstRange = [repmat([-1,1],ControlLaw.CstRegNumber,1)]; % Range of values of the random constants
            % Total number of registers
            ControlLaw.RegNumber = ControlLaw.VarRegNumber + ControlLaw.CstRegNumber;  %* % variable registers and constante registers (operands)
            % Register initialization
                NVR = ControlLaw.VarRegNumber;
                RN = ControlLaw.RegNumber;
                r{RN}='0';
                r(:) = {'0'};
                % Variable registers
                for p=1:ProblemParameters.InputNumber
                    r{p+ProblemParameters.OutputNumber} = ControlSyntax{p}; %*
                end
                % Constant registers
                minC = min(ControlLaw.CstRange,[],2);
                maxC = max(ControlLaw.CstRange,[],2);
                dC = maxC-minC;
                for p=NVR+1:RN
                    r{p} = num2str(dC(p-NVR)*rand+minC(p-NVR));
                end
            ControlLaw.Registers = r;
        % Control law estimation
        ControlLaw.ControlPointNumber = 1000;
        ControlLaw.SensorRange = [repmat([-5,5],ProblemParameters.NumberSensors,1)];
            Nbpts = ControlLaw.ControlPointNumber;
            Rmin = min(ControlLaw.SensorRange,[],2);
            Rmax = max(ControlLaw.SensorRange,[],2);
            dR = Rmax-Rmin;
        ControlLaw.EvalTimeSample = ProblemParameters.Tmax(1)+rand(1,Nbpts)*(ProblemParameters.Tmax(2)-ProblemParameters.Tmax(1));
        ControlLaw.ControlPoints = rand(ProblemParameters.NumberSensors,Nbpts).*dR+Rmin;
    % Definition
    parameters.ControlLaw = ControlLaw;

%% MLC parameters
    % Population size
    parameters.PopulationSize = 100;
    % Optimization parameters
    parameters.OptiMonteCarlo = 1;
    parameters.RemoveBadIndividuals = 0;
    parameters.RemoveRedundants = 1;
    parameters.CrossGenRemoval = 1;
    parameters.ExploreIC = 1;
    % For remove_duplicates_operators and redundants, maximum number of
    % iterations of the operations when the test is not satisfied.
    parameters.MaxIterations = 100; % for remove_duplicates_operators and redundants, max number of iterations of the operations when we don't satisfy the test.
    % Reevaluate individuals (noise and experiment)
    parameters.MultipleEvaluations = 0;
    % Stopping criterion
    parameters.Criterion = 'number of evaluations'; % (not yet)
    % Selection parameters
    parameters.TournamentSize = 7;
    parameters.p_tour = 1;
    % Selection genetic operator parameters
    parameters.Elitism = 1;
    parameters.CrossoverProb = 0.60;
    parameters.MutationProb = 0.30;
    parameters.ReplicationProb = 0.10;
    % Other genetic parameters
    parameters.MutationType = 'at_least_one';
    parameters.MutationRate = 0.05;
    parameters.CrossoverPoints = 1;
    parameters.CrossoverMix = 1;
    parameters.CrossoverOptions = {'gives2'};
    % Other parameters
    parameters.BadValue = 10^36;
    parameters.Pretesting = 0; %remove individuals who have no effective instruction

%% Constants
    parameters.PHI = 1.61803398875;
    
%% Other parameters
    parameters.LastSave = '';
    
end


