%% DSP Lab Assignment #7

%% Task #1

%%

syms z;
num =  ((z^-1)-0.9*exp(-1j*0.2*pi))*((z^-1)-0.9*exp(1j*0.2*pi));             
den =  (1-0.9*exp(-1j*0.2*pi).*(z^-1))*(1-0.9*exp(1j*0.2*pi).*(z^-1));
H = num/den;

[a,b] = numden(H);
a = sym2poly(a);
b = sym2poly(b);

w = -pi:2*pi/1000:pi;

H = freqz(a,b,w);
figure
subplot(311), plot(w, abs(H)), title('Magnitude Response for H(z)');
subplot(312), plot(w, phase(H)), title('Phase Response (Unwrapped) for H(z)');
subplot(313), plot(w, angle(H)), title('Phase Response (Principal Value) for H(z)');

%%

gd = grpdelay(a,b,w);
figure, plot(w,gd), title('Group Delay for H(z)');

gd1 = gd(max(find((w - 0.2*pi) < 0.0001)));
gd2 = gd(max(find((w - 0.4*pi) < 0.0001)));
gd3 = gd(max(find((w - 0.9*pi) < 0.0001)));

disp(['For w = 0.2*pi, group delay is ' num2str(gd1)]);
disp(['For w = 0.4*pi, group delay is ' num2str(gd2)]);
disp(['For w = 0.9*pi, group delay is ' num2str(gd3)]);

%%

n = 0:60;
syms w0;
x = sinc(pi*(n-30)/16).*cos(w0*n);

w01 = 0.2*pi;
w02 = 0.4*pi;
w03 = 0.9*pi;

x1 = double(subs(x,w0,w01));
x2 = double(subs(x,w0,w02));
x3 = double(subs(x,w0,w03));

X1 = fftshift(fft(x1));
X2 = fftshift(fft(x2));
X3 = fftshift(fft(x3));

w  = linspace(-pi,pi,61);

figure,
subplot(311), plot(n,real(x1)), title('Plot of x[n] for w0 = 0.2*pi');
subplot(312), plot(n,real(x2)), title('Plot of x[n] for w0 = 0.4*pi');
subplot(313), plot(n,real(x3)), title('Plot of x[n] for w0 = 0.9*pi');

figure,
subplot(311), plot(w,abs(X1)), title('Spectrum of x[n] for w0 = 0.2*pi');
subplot(312), plot(w,abs(X2)), title('Spectrum of x[n] for w0 = 0.4*pi');
subplot(313), plot(w,abs(X3)), title('Spectrum of x[n] for w0 = 0.9*pi');

disp('Increasing the value of w0 shifts the spectrum of x[n] away from origin');

%%

h = impz(a,b);

y1 = conv(x1,h);
y2 = conv(x2,h);
y3 = conv(x3,h);

Y1 = fftshift(fft(y1));
Y2 = fftshift(fft(y2));
Y3 = fftshift(fft(y3));

w  = linspace(-pi,pi,153);
m = linspace(0,60, 153);

figure,
subplot(311), plot(m,real(y1)), title('Plot of y[n] for w0 = 0.2*pi');
subplot(312), plot(m,real(y2)), title('Plot of y[n] for w0 = 0.4*pi');
subplot(313), plot(m,real(y3)), title('Plot of y[n] for w0 = 0.9*pi');

figure,
subplot(311), plot(w,abs(Y1)), title('Spectrum of y[n] for w0 = 0.2*pi');
subplot(312), plot(w,abs(Y2)), title('Spectrum of y[n] for w0 = 0.4*pi');
subplot(313), plot(w,abs(Y3)), title('Spectrum of y[n] for w0 = 0.9*pi');

disp('By increasing the value of w0, the output compresses in time domain and expands in frequency domain');

%% Credits
% 
%  Made by:
%  Muhammad Abdlah
%  (2015-EE-166)
%