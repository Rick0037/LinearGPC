function ope = choose_operation(GeneticProbabilities)
    %CHOOSE_OPERATION choose a random operation
    %
    % See also @MLCpop/mutate, @MLCpop/crossover.
%% Operators probability
  pc = GeneticProbabilities(1);
  pm = GeneticProbabilities(2);
  pr = GeneticProbabilities(3);

%% Test
  if round((pr+pm+pc)*10^5)/10^5 ~= 1
      fprintf('ERROR: wrong operators probability')
      return
  end

%% Choose
  r=rand;
       if r<pr %REPLICATION
           ope = 'replication';
       elseif r<pr+pm  %MUTATION
           ope = 'mutation';
       else %CROSSOVER
           ope = 'crossover';
       end
end
