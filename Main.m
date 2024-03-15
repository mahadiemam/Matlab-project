clc
clear 
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%% User Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the potential function here.
% Example: V0 = @(x,y)0.5*x.^2 + 0.5*y.^2 ; for harmonic oscillator
Mass = 0.067;           % Effective mass, constant over all the structure...
Fx = 0;                 % Electric field [V/m] in the x-direction
Fy = 0;                 % Electric field [V/m] in the y-direction

%Nx = 3;
%Ny = 3;
Nx = input("Enter the quantum number N_x ");% Meshing points in x-direction
Ny = input("Enter the quantum number N_y ");% Meshing points in y-direction
Mx = 20e-9;             % Map X [m]
My = 20e-9;             % Map Y [m]

x = linspace(-Mx/2, Mx/2, Nx);
y = linspace(-My/2, My/2, Ny);
[X, Y] = meshgrid(x, y);

n = input('Enter the number of solutions: ');
m=n;

% example for harmonic oscillator = @(x,y) 0.5*(x.^2 + y.^2)
prompt = 'Enter the potential function V0(x,y): ';
V0_input = input(prompt);

landscape = input(['Enter the name of the landscape ...' ...
    'hexagonal/rectangle/ellipse/circle '],'s');
idx = landscape_f(landscape,X,Y);
% potential function
V1 = @(x,y) V0_input(x,y);
V0 = @(x,y) V0_input(x,y) + idx;
% Applying the potential function to the grid
V0_grid = V0(X, Y);
V0_grid = V0_grid - min(V0_grid(:));   % Setting the minimum value of the potential to 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FEM Method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
[E1, psi1] = Schroed2D_FEM_f(x, y, V0_grid, Mass, n);
disp(['-> Finite Elements method = ', num2str(toc), ' sec']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Display Results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

E = nan(n, 1);
E(1:length(E1), 1) = E1;

disp('=======================================');
disp('Results:');
disp('=======================================');
disp('E(eV)=');
disp(num2str(E));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot Wave Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on

% plotting of wave function
for i = 1:min(n, 200)  % Limiting to maximum of 200 subplots
    if i==m
    figure('Name', ['Wave Function ', num2str(i)], 'Position', [100 100 600 400]);
    surf(x*1e9, y*1e9, (psi1(:,:,i)));
    colormap(jet);
    colorbar;
    view(30, 30);
    xlabel('x (nm)');
    ylabel('y (nm)');
    zlabel('Psi');
    title(['Psi', E', num2str(i), ' = ', num2str(E(i, 1)*1000, '%.1f'), ' meV']);
    pause(5); % Adjust pause time as needed
    end
end
hold off
% plotting of probability function
for i = 1:min(n, 200)  % Limiting to maximum of 200 subplots
    if i==m
    figure('Name', ['Wave Function ', num2str(i)], 'Position', [100 100 600 400]);
    surf(x*1e9, y*1e9, abs(psi1(:,:,i)).^2);
    colormap(jet);
    colorbar;
    view(30, 30);
    xlabel('x (nm)');
    ylabel('y (nm)');
    zlabel('|Psi|^2');
    title(['|Psi|^2, E', num2str(i), ' = ', num2str(E(i, 1)*1000, '%.1f'), ' meV']);
    pause(5); % Adjust pause time as needed
    end
end
%plotEnergyAndDensity();
%Plotting the landscape
% Plotting of Potential Energy Landscape
[P, Q] = meshgrid(x, y);
figure('Name', 'Potential Energy Landscape', 'Position', [100 100 600 400]);
surf(P, Q, V1(P,Q));
colormap(jet);
colorbar;
view(30, 30);
xlabel('x (nm)');
ylabel('y (nm)');
zlabel('Potential Energy');
title('Potential Energy Landscape');
energy_at_point = energy_coordinate_cal(x,y,psi1,V0,E1)

