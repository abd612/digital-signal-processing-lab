%% DSP Lab Assignment #4

%% Task #1

for m = 1:4
    
    switch(m)
        case 1
            a = 1.0;
        case 2
            a = 0.9;
        case 3
            a = 0.5;
        case 4
            a = 0.1;
    end

    n = 1:50;
    w = -2*pi:4*pi/(length(n)-1):2*pi;
    
    u0 = n>=0;
    u30 = n>=30;
    h(n) = (a.^n).*(u0-u30);

    H(n) = (h(n)*(exp(-1i*w'*n))');
    H_ = fft(h);

    figure
    subplot(311), stem(n,real(h),'Linewidth',2), title(['System #1 h[n] with a = ' num2str(a)]), grid on;
    subplot(312), plot(w,abs(H),'Linewidth',2), title(['Fourier Transform H(w) with a = ' num2str(a)]), grid on;
    subplot(313), plot(w,abs(H_),'Linewidth',2), title(['Fast Fourier Transform H(w) with a = ' num2str(a)]), grid on;

end

%% Task #2

for m = 1:4
    
    switch(m)
        case 1
            a = 1.0;
        case 2
            a = 0.9;
        case 3
            a = 0.5;
        case 4
            a = 0.1;
    end

    n = 1:50;
    w = -2*pi:4*pi/(length(n)-1):2*pi;
    
    u0 = n>=0;
    u30 = n>=30;
    h(n) = (a.^n)+(1j.*((a/10).^n)).*(u0-u30);

    H(n) = (h(n)*(exp(-1i*w'*n))');
    H_ = fft(h);

    figure
    subplot(311), stem(n,real(h),'Linewidth',2), title(['System #2 h[n] with a = ' num2str(a)]), grid on;
    subplot(312), plot(w,abs(H),'Linewidth',2), title(['Fourier Transform Magnitude |H(w)| with a = ' num2str(a)]), grid on;
    subplot(313), plot(w,angle(H),'Linewidth',2), title(['Fourier Transform Phase <H(w) with a = ' num2str(a)]), grid on;
    
end

%% Task #3

[s,Fs] = audioread('almostcaught.wav');
sound(s,Fs);

n = 1:length(s);
delF = Fs/length(s);
f = -Fs/2:delF:Fs/2-delF;

S = fftshift(fft(s));

figure
subplot(311), stem(n,real(s),'Linewidth',2), title('Audio Signal s[n]'), grid on;
subplot(312), plot(f,abs(S),'Linewidth',2), title('Fourier Transform Magnitude |S(f)|'), grid on;
subplot(313), plot(f,angle(S),'Linewidth',2), title('Fourier Transform Phase <S(f)'), grid on;

%% Credits
% 
%  Muhammad Abdullah (2015-EE-166)
%  