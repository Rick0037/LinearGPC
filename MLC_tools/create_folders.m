function create_folders(name)
    % Creates the needed folders to save an MLC run.
    % See also chromosome, MLCind.


%% Other folders
    dir = ['save_runs/',name];
    % Save folder
    if not(exist(dir,'dir')),mkdir(dir);end
    % Figures
    if not(exist([dir,'/Figures'],'dir')),mkdir([dir,'/Figures']);end

end %method
