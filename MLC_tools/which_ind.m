function IND=which_ind(mlc,gen,ind)
    % WHICH_IND gives the indice of the control law in GenXpopulation.mat (old version)
    % Given a generation and an individual.
    % See also read, mat2lisp, simplify_my_LISP.


    
gen_=num2str(gen);

load(['Populations/Gen',gen_,'population.mat']);

%% b
    idx = mlc.population(gen).individuals(ind);
        indiv = mlc.table.individuals(idx);
        b1_ = indiv.control_law{1};
        b2_ = indiv.control_law{2};
        b3_ = indiv.control_law{3};
    bss = strrep_cl(mlc.parameters,indiv.control_law,2);

        b1s = bss{1}; l1 = length(b1s);
        b2s = bss{2}; l2 = length(b2s);
        b3s = bss{3}; l3 = length(b3s);

A1=[];A2=[];A3=[];
for p=1:100
    a1 = Gen_population{p,1};
    a2 = Gen_population{p,2};
    a3 = Gen_population{p,3};
    try
    if strcmp(a1(6:7+l1),[b1s,')>'])
        A1 = [A1,p];
    end
    if strcmp(a2(6:7+l2),[b2s,')>'])
        A2 = [A2,p];
    end
    if strcmp(a3(6:7+l3),[b3s,')>'])
        A3 = [A3,p];
    end
    end
end

IND=intersect(intersect(A1,A2),A3);
IND=IND(1);
