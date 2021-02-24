%% DSP Lab Assignment #2

%% Task #1

Fs = 11025;
nB = 8;
To = 5;
rec = audiorecorder(Fs,nB,1);
disp('Start Speaking');
recordblocking(rec,5);
disp('Stop Speaking');
length = rec.TotalSamples
play(rec);
recData = getaudiodata(rec);
plot(recData)

%% Questions
% 
%  Length of the sampled sequence can be calculated as:
%  length = sampling rate * recording time
%  length = 11025 * 5
%  length = 55125

%% Task #2

Fs = 8000;
nB = 8;
sound(recData,Fs,nB);

%% Questions
% 
%  The voice heard is not the same. It is quite muffled.
%  This is due to the different sampling rates of recording and playing.
%  The voice was recorded at 11025 samples per second.
%  Whereas it was played at 8000 samples per second.

%% Task #3

%% Function
%%
% 
%   function [y] = get_output_system(x, c, n1, n2)
%   
%       y = zeros(1,length(x));
%   	y(n1) = c;
%   
%       for n = 1:1:n2+1
%           y(n1+n) = x(n1+n) + 0.1*y(n1+n-1);
%       end
%   
%       for n = 1:1:n1-1
%           y(n1-n) = (y(n1-n+1) - x(n1-n+1))/0.1;
%       end
%   
%   end
% 


%% Linearity with zero ICs

x1 = [1 2 3 4 5 6];
x2 = [6 5 4 3 2 1];

y1 = get_output_system(x1,0,2,3);
y2 = get_output_system(x2,0,2,3);

x = 2*x1 + 3*x2;
y = get_output_system(x,0,2,3);

if(y == 2*y1+3*y2)
    disp('System in linear with zero ICs');
else
    disp('System is non-linear with zero ICs');
end

%% Linearity with ICs

x1 = [1 2 3 4 5 6];
x2 = [6 5 4 3 2 1];

y1 = get_output_system(x1,5,2,3);
y2 = get_output_system(x2,5,2,3);

x = 2*x1 + 3*x2;
y = get_output_system(x,5,2,3);

if(y == 2*y1+3*y2)
    disp('System in linear with ICs');
else
    disp('System is non-linear with ICs');
end

%% Causality with zero ICs

x = [0 0 1 1 1 1];
y = get_output_system(x,0,2,3);

if (y(1:2) == 0)
    disp('System is causal with zero ICs');
else
    disp('System is non-causal with zero ICs');
end

%% Causality with ICs

x = [0 0 1 1 1 1];
y = get_output_system(x,5,2,3);

if (y(1:2) == 0)
    disp('System is causal with ICs');
else
    disp('System is non-causal with ICs');
end

%% Task #4

%% With c = 1

c = 1;
n = 0:1:10;
h = (c.^n)/11;
x = ones(1,5);
y = conv(h,x);
yi = 0:1:14;
xi = 0:1:4;

figure;
hold;
stem(yi,y);
stem(xi,x);
legend('output','input');

%% With c = 0.9

c = 0.9;
n = 0:1:10;
h = (c.^n)/11;
x = ones(1,5);
y = conv(h,x);
yi = 0:1:14;
xi = 0:1:4;

figure;
hold;
stem(yi,y);
stem(xi,x);
legend('output','input');

%% With c = 0.8

c = 0.8;
n = 0:1:10;
h = (c.^n)/11;
x = ones(1,5);
y = conv(h,x);
yi = 0:1:14;
xi = 0:1:4;

figure;
hold;
stem(yi,y);
stem(xi,x);
legend('output','input');

%% With c = 0.5

c = 0.5;
n = 0:1:10;
h = (c.^n)/11;
x = ones(1,5);
y = conv(h,x);
yi = 0:1:14;
xi = 0:1:4;

figure;
hold;
stem(yi,y);
stem(xi,x);
legend('output','input');

%% Questions
% 
%  As evident from the graphs,
%  as the value of c decreases, the amplitude of output also decreases.
%  And for c = 1, it can be said that
%  the system is a 'moving average system'.

%% Credits
%
%  Made by:
%  Muhammad Abdullah
%  (2015-EE-166)