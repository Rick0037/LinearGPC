function idx=find_bad_individuals(pop,MLC_parameters)
    % FIND_BAD_INDIVIDUALS gives the indices of bad individuals.
    % See also replace_individuals, clean, remove_bad_individuals.

idx = find(pop.costs >= MLC_parameters.BadValue);
end
