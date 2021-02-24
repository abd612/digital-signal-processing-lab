%% DSP Lab Assignment #6

%% Task #1

%%

[s,Fs] = audioread('almostcaught_high.wav');
% sound(s,Fs);

n = 1:length(s);
delF = Fs/length(s);
f = -Fs/2:delF:Fs/2-delF;

S = fftshift(fft(s));

figure
subplot(311), stem(n,real(s),'Linewidth',2), title('Original Signal s[n]'), grid on;
subplot(312), plot(f,abs(S),'Linewidth',2), title('Fourier Transform Magnitude |S(f)|'), grid on;
subplot(313), plot(f,angle(S),'Linewidth',2), title('Fourier Transform Phase <S(f)'), grid on;

%%

a = 0.8;
Fc = 1000;
fn = Fc/Fs;
wn = 2*pi*fn;

syms z;
ga = (1 + a)/2;
nu = (z - exp(1i*wn))*(z - exp(-1i*wn));
de = (z - a*exp(1i*wn))*(z - a*exp(-1i*wn));

N = ga*nu/de;

[num,den] = numden(N);
num = sym2poly(num);
den = sym2poly(den);

t = filter(num,den,s);
% sound(t,Fs);

T = fftshift(fft(t));

figure
subplot(311), stem(n,real(t),'Linewidth',2), title('Filtered Signal t[n]'), grid on;
subplot(312), plot(f,abs(T),'Linewidth',2), title('Fourier Transform Magnitude |T(f)|'), grid on;
subplot(313), plot(f,angle(T),'Linewidth',2), title('Fourier Transform Phase <T(f)'), grid on;

%%

mults = length(impz(num,den))*Fs;
adds = (length(impz(num,den))-1)*Fs;

disp(['Multiplications: ' num2str(mults) ', Additions: ' num2str(adds)]);

%% Task 2

%%

[s,Fs] = audioread('almostcaught_high.wav');

M = 4;
Fs_ = Fs/4;
fn_ = Fc/Fs_;
wn = 2*pi*fn_;

ga = (1 + a)/2;
nu = (z - exp(1i*wn))*(z - exp(-1i*wn));
de = (z - a*exp(1i*wn))*(z - a*exp(-1i*wn));

N = ga*nu/de;

[num,den] = numden(N);
num = sym2poly(num);
den = sym2poly(den);

lp = fir1(22,1/M);

%%

figure, freqz(lp);

figure, impz(lp);

%%

sc = conv(s,impz(lp));
sd = decimate(sc,M,22,'fir');
u  = conv(sd,impz(num,den));

U = fftshift(fft(u));

n = 1:length(u);
delF = Fs_/length(u);
f = -Fs_/2:delF:Fs_/2-delF;

figure
subplot(311), stem(n,real(u),'Linewidth',2), title('Decimated Filtered Signal u[n]'), grid on;
subplot(312), plot(f,abs(U),'Linewidth',2), title('Fourier Transform Magnitude |U(f)|'), grid on;
subplot(313), plot(f,angle(U),'Linewidth',2), title('Fourier Transform Phase <U(f)'), grid on;

%%

mults = (length(impz(lp))+length(impz(num,den)))*Fs_;
adds = (length(impz(lp))+length(impz(num,den))-2)*Fs_;

disp(['Multiplications: ' num2str(mults) ', Additions: ' num2str(adds)]);

%%

[s,Fs] = audioread('almostcaught_high.wav');

a = 0.8;
M = 4;
ga = (1+a)/2;
Fc = 1000;
Fs_ = Fs/4;
fn_ = Fc/Fs;
wn = 2*pi*fn_;

lowpass = fir1(22,1/M);

sc  = conv(s,impz(lowpass));

num = [1*ga -2*cos(wn)*ga 1*ga];
den = [1 -2*a*cos(wn) a.^2];

hc = impz(num,den);

sc0 = delayseq(sc,0);
hc0 = delayseq(hc,0);
sd0 = downsample(sc0,M);
hd0 = downsample(hc0,M);
v0 = conv(sd0,hd0);

sc1 = delayseq(sc,1);
hc1 = delayseq(hc,-1);
sd1 = downsample(sc1,M);
hd1 = downsample(hc1,M);
v1 = conv(sd1,hd1);

sc2 = delayseq(sc,2);
hc2 = delayseq(hc,-2);
sd2 = downsample(sc2,M);
hd2 = downsample(hc2,M);
v2 = conv(sd2,hd2);

sc3 = delayseq(sc,3);
hc3 = delayseq(hc,-3);
sd3 = downsample(sc3,M);
hd3 = downsample(hc3,M);
v3 = conv(sd3,hd3);

v = v0 + v1 + v2 + v3;

V = fftshift(fft(v));

n = 1:length(v);
delF = Fs_/length(v);
f = -Fs_/2:delF:Fs_/2-delF;

figure
subplot(311), stem(n,real(v),'Linewidth',2), title('Polyphase Decimated Filtered Signal v[n]'), grid on;
subplot(312), plot(f,abs(V),'Linewidth',2), title('Fourier Transform Magnitude |v(f)|'), grid on;
subplot(313), plot(f,angle(V),'Linewidth',2), title('Fourier Transform Phase <V(f)'), grid on;

%%

mults = (length(impz(lp))+length(impz(num,den)))*Fs_;
adds = (length(impz(lp))+length(impz(num,den))/M+M-3)*Fs_;

disp(['Multiplications: ' num2str(mults) ', Additions: ' num2str(adds)]);
disp('Gain in number of computations is observed as additions are reduced');

%% Credits
% 
%  Made by:
%  Muhammad Abdlah
%  (2015-EE-166)
%  