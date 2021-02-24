%% Fourier Series

%% 1000 harmonics

w = pi;
a0 = 1/2;
f = 0;
t = linspace(0,10);

for n = 1:1:1000
    an = (sin(n*pi/2))/(n*pi/2);
    bn = 0;
    f = f + an*cos(n*pi*t);
end

f = f + a0;

plot(t,f)

%%
% Made by: Muhammad Abdullah (2015-EE-166)