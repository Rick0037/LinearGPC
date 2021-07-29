function value=bary_value(ind_sensor)

W = load('bary_weight.dat','-ascii');

%% --------------------------------------------------
%% Loading Files
grid = load('Grid2.dat', '-ascii');
sensor_triangle_indices = load('sensor_triangle_indices.dat','-ascii');

indices = sensor_triangle_indices(:,ind_sensor);

%% Coordinates
XY1 = grid(indices(1),:);
XY2 = grid(indices(2),:);
XY3 = grid(indices(3),:);
%% ---------------------------------------------------

%% Here we calculate the quantity we want 
w1 = W(ind_sensor,1);
w2 = W(ind_sensor,2);
w3 = W(ind_sensor,3);

value = w1*XY1 + w2*XY2 + w3*XY3;

end
