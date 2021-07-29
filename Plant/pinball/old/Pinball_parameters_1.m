function parameters = Pinball_parameters()
%% Options
        parameters.verbose=2;

%% Population_size
parameters.PopulationSize = 100;

%% Problem
parameters.ProblemParameters.OutputNumber = 3; % number of OutputNumber
parameters.TmaxEV=5;
parameters.ProblemParameters.RoundEval = 3;
parameters.EvaluationFunction = 'external';
%parameters.file_generator = 0;
parameters.BadValue = 10^36;
if ~strcmp(parameters.EvaluationFunction,'external')
   J0 = feval(parameters.EvaluationFunction,{'0'},parameters,0);
   parameters.ProblemParameters.J0 = J0{1};
else
    parameters.ProblemParameters.J0 = 1.5051;
end
parameters.ProblemParameters.Jmin = 0.8627; %best linear control
parameters.ProblemParameters.Jmax = 10*parameters.ProblemParameters.J0;
parameters.ProblemParameters.ActuationLimit = 5;
parameters.autonomous_problem = 0; %/!\ if 0, inputs include function time dependent functions
parameters.ProblemParameters.Tmax = [400 520];


%% Registers
parameters.ProblemParameters.InputNumber = 8; %number of OutputNumber
parameters.ControlLaw.VarRegNumber = 11;
parameters.ControlLaw.VarRegNumber = 14; % variable registers and constante registers (operands)
parameters.ControlLaw.VarRegNumber = 5; % range of values of the random constants [-X,X]
% Initialization---
nvr = parameters.ControlLaw.VarRegNumber;
nop = parameters.ControlLaw.VarRegNumber;
r{nop}='0';
% variable registers 
for p=1:nvr
	r{p} = '0';
end
r{1} = '0';
r{2} = '0';
r{3} = '0';
% constant registers
for p=(nvr+1):nop % cts
    r{p} = num2str(2*parameters.ControlLaw.VarRegNumber*(rand-0.5));
end
for p=(nvr+1):(nvr+parameters.ProblemParameters.InputNumber)
    r{p} = ['s(',num2str(p-nvr),')'];
end
parameters.ControlLaw.Registers = r;

%%% Sensors definition
% % pre-testing - change here when delays are changed
%s_test{parameters.ProblemParameters.InputNumber} = '0';
%for p=1:15
%	s_test{p} = ['SSbt(:,',num2str(p),')'];
%end
%for p=16:30
%	s_test{p} = ['[zeros(20,1);SSbt(1:end-20,',num2str(p-nvr),')]'];
%end
%for p=31:45
%	s_test{p} = ['[zeros(40,1);SSbt(1:end-40,',num2str(p-2*nvr),')]'];
%end
%for p=46:60
%	s_test{p} = ['[zeros(60,1);SSbt(1:end-60,',num2str(p-3*nvr),')]'];
%end

 % evaluation
s_eval{parameters.ProblemParameters.InputNumber} = '0';
	s_eval{1} = 'cos(2*pi*PHI^(-4)*T/8)';
	s_eval{2} = 'cos(2*pi*PHI^(-3)*T/8)';
	s_eval{3} = 'cos(2*pi*PHI^(-2)*T/8)';
	s_eval{4} = 'cos(2*pi*PHI^(-1)*T/8)';
	s_eval{5} = 'cos(2*pi*PHI^(1)*T/8)';
	s_eval{6} = 'cos(2*pi*PHI^(2)*T/8)';
	s_eval{7} = 'cos(2*pi*PHI^(3)*T/8)';
	s_eval{8} = 'cos(2*pi*PHI^(4)*T/8)';

 % definition
%parameters.ControlLaw.TestSensors = s_test;
parameters.ControlLaw.EvalSensors = s_eval;



%% Functions
parameters.ControlLaw.OperatorIndices = 1:9;
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
parameters.ControlLaw.Precision = 4;

%% Instructions parameters (Number and distribution)
parameters.ControlLaw.InstructionSize.InitMax=15;
parameters.ControlLaw.InstructionSize.InitMin=1;
parameters.ControlLaw.InstructionSize.Max=15;

%% MLC
parameters.OptiMonteCarlo = 1;
parameters.RemoveBadIndividuals = 0;
parameters.RemoveRedundants = 1;
parameters.CrossGenRemoval = 1;

parameters.number_evaluation_points = 100;%*
parameters.range_evaluation_points = [-5 5];%*
    Nbpts = parameters.number_evaluation_points;%*
    Rmin = min(parameters.range_evaluation_points);%*
    Rmax = max(parameters.range_evaluation_points);%*
    Rmean = mean([Rmin,Rmax]);%*
    Rrad = abs(Rmean-Rmin);%*
    parameters.ControlLaw.EvalTimeSample = parameters.ProblemParameters.Tmax(1)+rand(1,Nbpts)*(parameters.ProblemParameters.Tmax(2)-parameters.ProblemParameters.Tmax(1));
    parameters.evaluation_points = 2*rand(parameters.ProblemParameters.InputNumber,Nbpts)*Rrad+Rmin;%*
parameters.Pretesting = 0; %remove individuals who have no effective instruction
parameters.MultipleEvaluations = 0;
parameters.ExploreIC = 1;
parameters.MaxIterations = 100; % for remove_duplicates_operators and redundants, max number of iterations of the operations when we don't satisfy the test.


%% Selection parameters
parameters.TournamentSize = 7;
parameters.p_tour = 1;

%% Selection genetic operator parameters
parameters.ReplicationProb = 0.10;
parameters.CrossoverProb = 0.60;
parameters.MutationProb = 0.30;

%% Other genetic parameters
parameters.MutationType = 'at_least_one';
parameters.MutationRate = 0.05;
parameters.CrossoverPoints = 1;
parameters.CrossoverMix = 1;
parameters.CrossoverOptions = {'gives2'};
Elitism = 1;

%% Options
parameters.verbose=1;
end
