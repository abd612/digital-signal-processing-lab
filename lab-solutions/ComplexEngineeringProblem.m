%% DSP Complex Engineering Problem

%% Clearing the Junk

clear;
clc;

%% Importing the Data

x = loadFile('rf_data.dat');
Fs = 2048000;

%% Normalizing

x_norm = x./max(x);

%% Filtering and Decimating

M = 8;
wc = 1/M;
f_len = 80;
n = 0:1:f_len;

h_filt = wc*(sinc((wc)*(n-(f_len/2))));
x_filt = conv(x_norm,h_filt,'same');

x_deci = x_filt(1:M:length(x_filt));
Fs = Fs/M;

%% Differentiating

M = f_len-1;
n = 0:M;

h_diff = cos(pi*(n-M/2))./(n-M/2) - sin(pi*(n-M/2))./(pi*((n-M/2).^2));
x_diff = conv(x_deci,h_diff,'same');

%% Demodulating

m = imag((x_diff).*conj(x_deci));

%% Normalizing

m_norm = m./max(m);

%% Filtering and Decimating

M = 16;
wc = 1/M;
f_len = 80;
n = 0:1:f_len;

h_filt = wc*(sinc((wc)*(n-(f_len/2))));
m_filt = conv(m_norm,h_filt,'same');

m_deci = m_filt(1:M:length(m_filt));
Fs = Fs/M;

%% Playing the Audio

sound(m_deci,Fs);

%% Displaying the Retrieved Signal

M_deci = fftshift(fft(m_deci));
f = -length(M_deci)/2:length(M_deci)/2-1;
figure;
subplot(211), plot(m_deci), title('Retrieved Signal'), grid on;
subplot(212), plot(f,abs(M_deci)), title('Spectrum of Retrieved Signal'), grid on;

%%  Frequency Response of Differentiator

H_diff = fftshift(fft(h_diff));
f = -length(H_diff)/2:length(H_diff)/2-1;
figure,
subplot(311), plot(f,abs(H_diff)), title('Magnitude Response of Differentiator'), grid on;
subplot(312), plot(f,phase(H_diff)), title('Phase Response of Differentiator'), grid on;
subplot(313), plot(grpdelay(H_diff)), title('Group Delay of Differentiator'), grid on;

%% Credits
% 
%  Made by:
%  Muhammad Abdlah
%  (2015-EE-166)
%