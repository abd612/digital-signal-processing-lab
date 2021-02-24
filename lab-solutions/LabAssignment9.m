%% DSP Lab Assignment #9

%% Task #1

%%

[x,Fs] = audioread('almostcaught_noisy.wav');

X = fftshift(fft(x));
f = -length(X)/2:length(X)/2-1;
X_norm = abs(X)/max(abs(X));
X_dB = mag2db(X_norm);
figure, plot(f,abs(X)), title('Original Signal'), grid on;
figure, plot(f,X_dB), title('Original Signal (Normalized dB Scale)'), grid on;

sound(x,Fs);

%%

Wp = 15000;
Ws = 25000;
Rp = -3;
Rs = -30;

[num,den] = b_worth(Wp, Ws, Rp, Rs, Fs);

figure, impz(num,den), grid on;
figure, freqz(num,den), title('Frequency Response');

%%

y = filter(num,den,x);
Y = fftshift(fft(y));
f = -length(Y)/2:length(Y)/2-1;
figure, plot(f,abs(Y)), title('Signal after IIR Filter'), grid on;
sound(y,Fs);

%% Task #2

%%

h_d = impz(num,den)';

M = length(h_d);
m = 0:M-1;

w_b = zeros(1,M);
n = 0;
for k = 1:M
    if (n >= 0 && n <= (M-1)/2)
        w_b(k) = 2*n/(M-1);
    elseif (n > (M-1)/2 && n <= (M-1))
        w_b(k) = 2 - 2*n/(M-1);
    else
        w_b(k) = 0;
    end
    n = n + 1;
end

figure, stem(m,w_b), xlabel('n'), ylabel('w_b[n]'), title('Bartlett Window');
h = h_d.*w_b;

%%

y_f = conv(x,h,'same');
Y_f = fftshift(fft(y_f));
f = -length(Y_f)/2:length(Y_f)/2-1;
figure, plot(f,abs(Y_f)), title('Signal after FIR Filter'), grid on;
sound(y,Fs);

%% Butterworth Function
%
% function [num,den] = b_worth(Wp, Ws, Rp, Rs, Fs)
% 
%     N = ceil(mag2db((1/db2mag(Rs)^2-1)/(1/db2mag(Rp)^2-1))/(2*mag2db(Ws/Wp)))
%     Wc = Wp/((1/db2mag(Rp)^2-1)^(1/(2*N)));
%     
%     Fc = Fs/pi * tan(Wc/(2*Fs));
%     p = 2*pi*Fc*(1i*cos((2*(1:N)-1)*pi/(2*N))-sin((2*(1:N)-1)*pi/(2*N)));
%     
%     den = real(poly((1+p/(2*Fs))./(1-p/(2*Fs))));
%     num = poly(-ones(1,N))*sum(den)/sum(poly(-ones(1,N)));
% 
% end

%% Credits
% 
%  Made by:
%  Muhammad Abdlah
%  (2015-EE-166)
%