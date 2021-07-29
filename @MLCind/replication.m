function rep_indiv = replication(indiv)
    % REPLICATION copy/paste one individual
    % Old method. Not used.
    % See also crossover, mutate

rep_indiv = indiv;
rep_indiv.parents = indiv.Rank;
rep_indiv.operation = [];
rep_indiv.operation.type = 'replication';
rep_indiv.Rank = 0;
rep_indiv.copy = indiv.Rank;
end
