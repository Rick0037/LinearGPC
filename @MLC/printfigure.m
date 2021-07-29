function printfigure(MLC,FigureName)
    % PRINT prints the current figure in the right folder if it doesn't
    % exist
    %
    % See also plot.

%% Parameters
    Name = MLC.parameters.Name;
    FigPath = ['save_runs/',Name,'/Figures/',FigureName];
    
%% Test
    if exist([FigPath,'.eps'],'file')
        error('This file name already exist')
    end
    
%% Print
    print([FigPath,'.eps'],'-depsc','-tiff','-r600') 
    print([FigPath,'.png'],'-dpng','-r600') 
end
