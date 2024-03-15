function idx = landscape_f(landscape,X,Y)
if strcmp(landscape,'hexagonal')

    a = input("Enter the parameter for hexagon : "); % Define the distance parameter 'a'
    idx1 = (abs(X) < a*sqrt(3)/2);
    idx2 = (tan(pi/6)*X + a > Y) .* (tan(pi/6)*X - a < Y) .* (-tan(pi/6)*X - a < Y) .* (-tan(pi/6)*X + a > Y);
    idx = idx1 .* idx2;
end
if strcmp(landscape,'rectangle')
    % Define the rectangular region
    Lx = input("Enter the length of the x axis of rectangle");       %2e-9;      % Well width X [m]
    Ly = input("Enter the width of the y axis of rectangle ");         %10e-9;      % Well width Y [m]
    x0 = 0;         % Center positions of the rectangle [m]
    y0 = 0;

    idx = (abs(X-x0) < Lx/2) .* (abs(Y-y0) < Ly/2);
end
if strcmp(landscape,'ellipse')
    Rx = input("Enter the radius of ellipse in x direction ");%2e-9;        % radius in the x-direction of the ellipse [m]
    Ry = input("Enter the radius of ellipse in y direction ");%40e-9;        % radius in the y-direction of the ellipse [m]
    x0 = 0;
    y0 = 0;   % center positions of the ellipse [m]
    idx = ((X - x0)/Rx).^2 + ((Y - y0)/Ry).^2 < 1;
end
if strcmp(landscape,'circle')
    R = input("Enter the radius of the circle box ");
    x0 = input("Enter the x coordinate of the centre of the circle box "); % Center of the circle
    y0 = input("Enter the y coordinate of the centre of the circle box");
    % Check if the distance from the center of the circle to each point (X,Y)
    % is less than or equal to the radius R
    idx = ((X - x0).^2 + (Y - y0).^2) <= R^2;
end


