%% Notch Filter

%% Data

digits(12);

T = 0.001;
D = 0.001*pi;

f1 = 50;
f2 = 70;
f3 = 30;

w0 = 2*pi*f1*T;

t = 0:T:1-T;
Fs = 1/T;
delF = Fs/length(t);
f = -Fs/2:delF:Fs/2-delF;

%% Input

x = sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t);
X = fftshift(fft(x));
figure, plot(t,x);
figure, plot(f,abs(X));

%% Required Output

z = sin(2*pi*f2*t) + sin(2*pi*f3*t);
Z = fftshift(fft(z));
figure, plot(t,z);
figure, plot(f,abs(Z));

%% Poles Calculations

p1 = (cos(w0) - D*cos(w0-2*pi/5)) + 1i*(sin(w0) - D*sin(w0-2*pi/5));
p2 = (1-D)*cos(w0) + 1i*(1-D)*sin(w0);
p3 = (cos(w0) - D*cos(w0+2*pi/5)) + 1i*(sin(w0) - D*sin(w0+2*pi/5));

p1c = conj(p1);
p2c = conj(p2);
p3c = conj(p3);

%% First Filter

y1 = o2filter(x,w0,p1,p1c);
Y1 = fftshift(fft(y1));
figure, plot(t,y1);
figure, plot(f,abs(Y1));

%% Second Filter

y2 = o2filter(y1,w0,p2,p2c);
Y2 = fftshift(fft(y2));
figure, plot(t,y2);
figure, plot(f,abs(Y2));

%% Third Filter

y3 = o2filter(y2,w0,p3,p3c);
Y3 = fftshift(fft(y3));
figure, plot(t,y3);
figure, plot(f,abs(Y3));

%% Function

% Create a separate function file and paste the below function there.

% function y = o2filter(x, w0, p, pc)
% 
%     y = 1:length(x);
%     y(1:2) = 0;
% 
%     for n = 3:length(x)
%         y(n) = x(n) - 2*cos(w0)*x(n-1) + x(n-2) + (p+pc)*y(n-1) - p*pc*y(n-2);
%     end
%     
% end

%% Credits
% 
%  Made by:
%  Muhammad Abdullah
%  (2015-EE-166)
%  