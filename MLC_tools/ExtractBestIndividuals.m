    % Extract best individual of a set of runs with the same name but with 
    % a number to differentiate them : example : MyRun1, MyRun2, etc.
    % The script writes the associate control law in a file.
    % The file is saved in the save_runs folder and it ends
    % with '_BestControlLaws.txt'.
    % Only for MATLAB for the moment.
    % See also
    
%% Initialization
    mlc = MLC;
    
%% Parameters
    dir = 'save_runs';
    % Name type
        NamePrefix = 'MyRun'; % CHANGE HERE
        NameRange = 1:3; % CHANGE HERE
    % Problem - Number of controllers
        mlc.load_matlab([NamePrefix,num2str(NameRange(1))]);
        NumberControllers = mlc.parameters.ProblemParameters.OutputNumber;

%% Allocation
    BestControlLaws = cell(numel(NameRange),NumberControllers);

%% Extract control laws
    for p=1:numel(NameRange)
        RunName = [NamePrefix,num2str(NameRange(p))];
        mlc.load_matlab(RunName);
        ID = mlc.population(end).individuals(1);
        chromosome = mlc.table.individuals(ID).chromosome;
        BestControlLaws(p,:) = reshape(read(mlc.parameters,chromosome,1),1,[]);
    end
   
%% Export
    % Open
    fid = fopen(fullfile(dir,[NamePrefix,'_BestControlLaws.txt']),'wt');
    % Header
    fprintf(fid,'Best control laws for several runs.\n');
    fprintf(fid,'\n');
  
    % Loop over the runs
    for p=1:numel(NameRange)
        RunName = [NamePrefix,num2str(NameRange(p))];
        fprintf(fid,[RunName,' :\n']);
        for q=1:NumberControllers
            fprintf(fid,['   b',num2str(q),' = ',BestControlLaws{p,q},'\n']);
        end
        fprintf(fid,'\n');
    end
fclose(fid);