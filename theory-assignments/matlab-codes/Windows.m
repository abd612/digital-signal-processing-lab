%% Windows

%% Data

N = 51;
m = 0:N-1;

M = 256;
f = (-M/2:M/2-1)/M;
w = 2*pi*(-M/2:M/2-1)/M;

%% Rectangluar Window

w_g = zeros(1,N);
n = 0;
for k = 1:N
    if (n >= 0 && n <= (N-1))
        w_g(k) = 1;
    else
        w_g(k) = 0;
    end
    n = n + 1;
end

W_g = fftshift(fft(w_g,M));
W_g_dB = mag2db(abs(W_g));

figure,
subplot(211), stem(m,w_g), xlabel('n'), ylabel('w_g[n]'), title('Rectangular Window');
subplot(212), plot(w,W_g_dB), xlabel('w'), ylabel('|W_g(w)| (dB)'), title('Fourier Transform (dB)');

%% Bartlett Window

w_b = zeros(1,N);
n = 0;
for k = 1:N
    if (n >= 0 && n <= (N-1)/2)
        w_b(k) = 2*n/(N-1);
    elseif (n > (N-1)/2 && n <= (N-1))
        w_b(k) = 2 - 2*n/(N-1);
    else
        w_b(k) = 0;
    end
    n = n + 1;
end

W_b = fftshift(fft(w_b,M));
W_b_dB = mag2db(abs(W_b));

figure,
subplot(211), stem(m,w_b), xlabel('n'), ylabel('w_b[n]'), title('Bartlett Window');
subplot(212), plot(w,W_b_dB), xlabel('w'), ylabel('|W_b(w)| (dB)'), title('Fourier Transform (dB)');

%% Hanning Window

w_han = zeros(1,N);
n = 0;
for k = 1:N
    if (n >= 0 && n <= (N-1))
        w_han(k) = 0.5 - 0.5*cos(2*pi*n/(N-1));
    else
        w_han(k) = 0;
    end
    n = n + 1;
end

W_han = fftshift(fft(w_han,M));
W_han_dB = mag2db(abs(W_han));

figure,
subplot(211), stem(m,w_han), xlabel('n'), ylabel('w_h_a_n[n]'), title('Hanning Window');
subplot(212), plot(w,W_han_dB), xlabel('w'), ylabel('|W_h_a_n(w)| (dB)'), title('Fourier Transform (dB)');

%% Hamming Window

w_ham = zeros(1,N);
n = 0;
for k = 1:N
    if (n >= 0 && n <= (N-1))
        w_ham(k) = 0.54 - 0.46*cos(2*pi*n/(N-1));
    else
        w_ham(k) = 0;
    end
    n = n + 1;
end

W_ham = fftshift(fft(w_ham,M));
W_ham_dB = mag2db(abs(W_ham));

figure,
subplot(211), stem(m,w_ham), xlabel('n'), ylabel('w_h_a_m[n]'), title('Hamming Window');
subplot(212), plot(w,W_ham_dB), xlabel('w'), ylabel('|W_h_a_m(w)| (dB)'), title('Fourier Transform (dB)');

%% Blackman Window

w_bl = zeros(1,N);
n = 0;
for k = 1:N
    if (n >= 0 && n <= (N-1))
        w_bl(k) = 0.42 - 0.5*cos(2*pi*n/(N-1)) + 0.08*cos(4*pi*n/(N-1));
    else
        w_bl(k) = 0;
    end
    n = n + 1;
end

W_bl = fftshift(fft(w_bl,M));
W_bl_dB = mag2db(abs(W_bl));

figure,
subplot(211), stem(m,w_bl), xlabel('n'), ylabel('w_b_l[n]'), title('Blackman Window');
subplot(212), plot(w,W_bl_dB), xlabel('w'), ylabel('|W_b_l(w)| (dB)'), title('Fourier Transform (dB)');

%% Credits
% 
%  Made by:
%  Muhammad Abdullah
%  (2015-EE-166)
%  