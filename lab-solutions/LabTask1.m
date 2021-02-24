%% DSP Lab Task #1

%% Part A: Functions

plotSin(2)

plot2Sin(4)

plot2Sin(2,4)

%% Part B: Matrices

A = [1, 2, 3; 4, 5, 6; 7, 8, 9]

B = rand(5)

A(2,:)

B(5,5)

%% Part C: Line Plot

t = -pi:pi/100:pi

y = sin(t)

plot(t, y, '*', 'Linewidth', 2)

%% Part D: 3D Plot

z = 0:pi/100:5*pi

x = sin(z)
y = cos(z)

plot3(x, y, z, 'b', 'Linewidth', 1)

%% Part E: Surface Plot

x = -pi:0.1:pi
y = -pi:0.1:pi

[X,Y] = meshgrid(x,y)

Z = sin(X).*cos(Y)

surf(X,Y,Z)