%% DSP Lab Assignment #3

%% Task #1

%% Linearity

for m = 1:3
    
    switch(m)
        case 1
            c = 0.5;
        case 2
            c = 0.3;
        case 3
            c = 0;
    end

    x1 = [1 2 3 4 5 6];
    x2 = [6 5 4 3 2 1];

    y1 = get_output_system1(x1,c);
    y2 = get_output_system1(x2,c);

    x = 2*x1 + 3*x2;
    y = get_output_system1(x,c);

    if(norm(y - (2*y1 + 3*y2)) < 0.001)
        disp(['System is linear with c = ' num2str(c)]);
    else
        disp(['System is non-linear with c = ' num2str(c)]);
    end
end

%% Causality

for m = 1:3
    
    switch(m)
        case 1
            c = 0.5;
        case 2
            c = 0.3;
        case 3
            c = 0;
    end

    x = [0 0 0 1 1 1];
    y = get_output_system1(x,c);
    ind = min(find(x~=0))-1;
    
    n = -2:length(x)-3;
    
    figure
    subplot(211), stem(n,x, 'r');
    subplot(212), stem(n,y, 'b');
    
    if(norm(y(1:ind)) < 0.000001)
        disp(['System is causal with c = ' num2str(c)]);
    else
        disp(['System is non-causal with c = ' num2str(c)]);
    end
end

%% Impulse Response

for m = 1:3
    
    switch(m)
        case 1
            c = 0.5;
        case 2
            c = 0.3;
        case 3
            c = 0;
    end

    x = [0 0 1 0 0 0];
    n = -2:length(x)-3;
    y = get_output_system1(x,c);
    
    figure
    subplot(211), stem(n,x, 'r');
    subplot(212), stem(n,y, 'b');
    
end

%% Task #2

%% Linearity

for m = 1:2
    
    x1 = [1 2 3 4 5 6];
    x2 = [6 5 4 3 2 1];
    x = 2*x1 + 3*x2;
    
    switch(m)
        case 1
            y1 = get_output_system2(x1);
            y2 = get_output_system2(x2);
            y = get_output_system2(x);
        case 2
            y1 = get_output_system3(x1);
            y2 = get_output_system3(x2);
            y = get_output_system3(x);
    end

    if(norm(y - (2*y1 + 3*y2)) < 0.001)
        disp(['System ' num2str(m) ' is linear']);
    else
        disp(['System ' num2str(m) ' is non-linear']);
    end
end

%% Stability

for m = 1:2
    
    x = 1:1000;
    
    switch(m)
        case 1
            y = get_output_system2(x);
        case 2
            y = get_output_system3(x);
    end
    
    n = 1:1000;
    
    figure
    subplot(211), stem(n,x, 'r');
    subplot(212), stem(n,y, 'b');
    
    if(norm(y) < Inf)
        disp(['System ' num2str(m) ' is stable']);
    else
        disp(['System ' num2str(m) ' is unstable']);
    end
end

%% Causality

for m = 1:2
    
    x = [0 0 0 1 0 0];
    
    switch(m)
        case 1
            y = get_output_system2(x);
        case 2
            y = get_output_system3(x);
    end

    ind = min(find(x~=0))-1;

    n = 1:length(x);
    
    figure
    subplot(211), stem(n,x, 'r');
    subplot(212), stem(n,y, 'b');
    
    if(norm(y(1:ind)) < 0.000001)
        disp(['System ' num2str(m) ' is causal']);
    else
        disp(['System ' num2str(m) ' is non-causal']);
    end
end

%% Time Invariance

for m = 1:2
    
    x = [1 2 3 0 0 0];
    x1 = [0 0 0 1 2 3];
    
    switch(m)
        case 1
            y = get_output_system2(x);
            y1 = get_output_system2(x1);
            y2 = [0 0 0 y(1:length(y)-3)];
        case 2
            y = get_output_system3(x);
            y1 = get_output_system3(x1);
            y2 = [0 0 0 y(1:length(y)-3)];
    end

    n = 1:length(x);
    
    figure
    subplot(211), stem(n,y1, 'r');
    subplot(212), stem(n,y2, 'b');
    
    if(norm(y1-y2) < 0.001)
        disp(['System ' num2str(m) ' is time invariant']);
    else
        disp(['System ' num2str(m) ' is time variant']);
    end
end

%% Task #3

n = 0:1:100;
x = (1/6).^n;
w = -pi:(2*pi/100):pi;

X = fft(x);

subplot(411), stem(w,abs(X),'r'); title('Magnitude Response');
subplot(412), stem(w,angle(X),'b'); title('Phase Response');
subplot(413), stem(w,real(X),'r'); title('Real Response');
subplot(414), stem(w,imag(X),'b'); title('Imaginary Response');

disp('Magnitude response is even');
disp('Phase response is odd');
disp('Real response is even');
disp('Imaginary response is odd');
disp('Fourier transform is conjugate symmetric');

%% Credits
% 
%  Made by:
%  Muhammad Abdullah
%  (2015-EE-166)
%  