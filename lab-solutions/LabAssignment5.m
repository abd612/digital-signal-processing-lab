%% DSP Lab Assignment #5

%% Task #1

%%

syms z;
Fs = 11025;
w0 = 2000*pi/Fs;

H = (1 - (2*cos(w0)*(z^-1)) + (z^-2))/(1 + 0.5*(z^-1));
H = vpa(H,5)

h = iztrans(H);
h = vpa(h,5)

%%

a = [1 -2*cos(w0) 1];
b = [1 0.5 0];
w = -pi:2*pi/11025:pi;

[r,p,k] = residuez(b,a);
figure, zplane(a,b), title('Pole-Zero Plot');

%%

syms w;
H = (1-(2*cos(w0)*(exp(1j*w)^-1))+(exp(1j*w)^-2))/(1+.5*(exp(1j*w)^-1));
H = vpa(H,5);
w = -2*pi:0.01:2*pi;
H = subs(H);

figure
subplot(211), plot(w,real(abs(H)),'Linewidth',2), title('Magnitude Spectrum |H(w)|'), grid on;
subplot(212), plot(w,real(angle(H)),'Linewidth',2), title('Phase Spectrum <H(w)'), grid on;

figure, freqz(a,b,w),title('Actual Frequency Response');

%% Task #2

n1 = -2;
n2 = 9;
c = 0;
n = n1:n2;
x = n==0;

y = system_z(x,c,n1,n2);

figure
subplot(211), stem(n,y,'Linewidth',2), title('Impulse Response'), grid on;
subplot(212), impz(a,b),title('Actual Impulse Response');

%% Task #3

%%

[s,Fs] = audioread('almostcaught.wav');
sound(s,Fs);

n = 1:length(s);
delF = Fs/length(s);
f = -Fs/2:delF:Fs/2-delF;

S = fftshift(fft(s));

figure
subplot(311), stem(n,real(s),'Linewidth',2), title('Original Signal s[n]'), grid on;
subplot(312), plot(f,abs(S),'Linewidth',2), title('Fourier Transform Magnitude |S(f)|'), grid on;
subplot(313), plot(f,angle(S),'Linewidth',2), title('Fourier Transform Phase <S(f)'), grid on;

%%

n1 = -2;
n2 = length(s)-3;
c = 0;
t = system_z(s,c,n1,n2);
sound(t,Fs);

T = fftshift(fft(t));

figure
subplot(311), stem(n,real(t),'Linewidth',2), title('Filtered Signal t[n]'), grid on;
subplot(312), plot(f,abs(T),'Linewidth',2), title('Fourier Transform Magnitude |T(f)|'), grid on;
subplot(313), plot(f,angle(T),'Linewidth',2), title('Fourier Transform Phase <T(f)'), grid on;

%% Credits
% 
%  Made by:
%  Muhammad Abdullah
%  (2015-EE-166)
%  