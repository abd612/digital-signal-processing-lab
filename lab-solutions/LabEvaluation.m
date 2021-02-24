%% DSP Lab Evaluation (Midterm)
% |Muhammad Abdullah (2015-EE-166)|

%% Task #1

%%
syms n;
x = 0.5*heaviside(n-5) + 0.2*heaviside(2*n-10);
X = ztrans(x);
n = 1:20;
x = subs(x);
x = double(x);
figure, stem(n,x), title('Graph of x(n)');

%%
syms z;
H = (z^-1 - 1)*(z^-1 - 1)/(z^-3 + z^-2 + 1);
[a,b] = numden(H);
a = sym2poly(a);
b = sym2poly(b);
figure, zplane(a,b), title('Pole-Zero Plot of H(z)');

%%
Y = H*X;
syms w;
Y = subs(Y,z,exp(j*w));
w = 0.0001:2*pi/100:2*pi;
Y = subs(Y,w);
Y = double(Y);
figure, subplot(211), plot(w,abs(Y)), title('Magnitude Plot of Y(z)');
subplot(212), plot(w,angle(Y)), title('Phase Plot of Y(z)');

%% Task #2

%%
syms z;
H = (1 + 0.5*z^-1)*(1 + z^-2)/(1 + 10*z^-2);
h = iztrans(H);
n = 1:1000;
h = subs(h);
h = double(h);
nh = 1:length(h);
figure, stem(nh,h), title('Graph of h(n)');

%%
x = 1:1000;
y = conv(h,x);
nx = 1:length(x);
ny = 1:length(y);
figure, subplot(211), stem(nx,x), title('Graph of x(n) (Stability)');
subplot(212), stem(ny,y), title('Graph of y(n) (Stability)');
if(norm(y) < Inf)
    disp('System is stable');
else
    disp('System is unstable');
end
   
%% Task #3

%%
%   -----------------------------------------------------------
%   function y = get_output_system4(x,c)
%   
%   y = zeros(1,length(x));
%   y(1:21) = c;
%
%   for n = 22:length(x)
%       y(n) = 0.1*y(n-2) + 0.5*x(n-10) + 0.4*y(floor(n/2)-10);
%   end
%   
%   end
%   -----------------------------------------------------------
%%
x1 = zeros(1,21);
x2 = ones(1,29);
x = cat(2,x1,x2);
y = get_output_system4(x,0);
n = -21:length(x)-22;
figure, subplot(211), stem(n,x), title('Graph of x(n)');
subplot(212), stem(n,y), title('Graph of y(n)');

%%
xi = zeros(1,50);
xi(22) = 1;
h = get_output_system4(xi,0);
n = -21:length(xi)-22;
figure, stem(n,h), title('Graph of h(n)');

%%
x = 1:1000;
y = get_output_system4(x,0);
n = -21:length(x)-22;
figure, subplot(211), stem(n,x), title('Graph of x(n) (Stability)');
subplot(212), stem(n,y), title('Graph of y(n) (Stability)');
if(norm(y) < Inf)
    disp('System is stable');
else
    disp('System is unstable');
end

%%
x1 = zeros(1,21);
x2 = ones(1,29);
x = cat(2,x1,x2);
y = get_output_system4(x,0);
n = -21:length(x)-22;
figure, subplot(211), stem(n,x), title('Graph of x(n) (Causality)');
subplot(212), stem(n,y), title('Graph of y(n) (Causality)');
ind = min(find(x~=0))-1;
if(norm(y(1:ind)) == 0)
    disp('System is causal');
else
    disp('System is non-causal');
end

%% Credits
% 
%  Made by:
%  Muhammad Abdullah
%  (2015-EE-166)
%  