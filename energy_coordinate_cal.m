function energy_at_point = energy_coordinate_cal(x,y,psi1,V0,E1)
%calculation of energy at certain coordinate
x0 = input("Enter the x coordinate to calculate energy"); % specify the x-coordinate
y0 = input("Enter the y coordinate to calculate energy"); % specify the y-coordinate

% Find the indices of the closest points in the grid
[~, idx_x0] = min(abs(x - x0));
[~, idx_y0] = min(abs(y - y0));

% Calculate the potential energy at the specified point
V0_at_point = V0(x0, y0);

% Evaluate the wave function at the specified point
psi_at_point = psi1(idx_y0, idx_x0, :);

% Calculate the energy using the time-independent Schrödinger equation
energy_at_point = sum(psi_at_point .* conj(psi_at_point) .* E1) / sum(psi_at_point .* conj(psi_at_point));
end





