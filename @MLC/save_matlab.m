function save_matlab(MLC,AuxName)
    % SAVE save method for MLC.
    % Saves the MLC object (mlc) in the save_runs folder with the its name.
    % To load the MLC object : mlc.load('NameOfMyRun');
    %
    % See also MLC, go, @MLC/load.



%% Parameters
    Name = MLC.parameters.Name;
    if nargin<2,SaveName='MLC';else,SaveName=AuxName;end
    
%% Folders
    % create them
    create_folders(Name);

%% Save
    MLC.parameters.LastSave = [MLC.parameters.LastSave;date];
    direc = ['save_runs/',Name];
    SaveMLC = [direc,'/',SaveName,'_Matlab.mat'];
    save(SaveMLC,'MLC')

end
