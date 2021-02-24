%% DSP Lab Assignment #8

%% Task #1

%%

syms z;

num = (z-0.9*exp(1j*0.6*pi))*(z-0.9*exp(-1j*0.6*pi))*(z-1.25*exp(1j*0.8*pi))*(z-1.25*exp(-1j*0.8*pi));
den = z^4;
H = num/den;

[a,b] = numden(H);
a = sym2poly(a);
b = sym2poly(b);

w = -pi:2*pi/1000:pi;

H = freqz(a,b,w);

figure
subplot(311), plot(w, abs(H)), title('Magnitude Response for H(z)');
subplot(312), plot(w, phase(H)), title('Phase Response for H(z)');
subplot(313), plot(w, group_delay(w,phase(H))), title('Group Delay for H(z)');

%%

n = 1:1000;
x = 1:1000;
h = impz(a,b);
y = conv(x,h,'same');

figure
subplot(211), stem(n,x, 'r'), title('Plot of x[n] for Stability');
subplot(212), stem(n,y, 'b'), title('Plot of y[n] for Stability');

if(norm(y) < Inf)
    disp('System  is stable');
else
    disp('System is unstable');
end

%%

x = [1 0 0 0 0 0];
y = conv(x,h,'same');
ind = min(find(x~=0))-1;
n = 0:length(x)-1;

figure
subplot(311), stem(n,x, 'r'), title('Plot of x[n] for Causality');
subplot(312), stem(n,y, 'b'), title('Plot of y[n] for Causality');
subplot(313), impz(a,b), title('Impulse Response h[n]');

if(norm(y(1:ind)) < 0.000001)
    disp('System is causal');
else
    disp('System is non-causal');
end

%%

n = 0:99;
syms w0;
x = sinc(pi*(n-50)/16).*cos(w0*n);

w01 = 0.1*pi;
w02 = 0.2*pi;
w03 = 0.4*pi;
w04 = 0.8*pi;

x1 = double(subs(x,w0,w01));
x2 = double(subs(x,w0,w02));
x3 = double(subs(x,w0,w03));
x4 = double(subs(x,w0,w04));

h = impz(a,b);

y1 = conv(x1,h);
y2 = conv(x2,h);
y3 = conv(x3,h);
y4 = conv(x4,h);

figure,
subplot(411), plot(abs(x1)), title('Plot of x[n] for w0 = 0.1*pi');
subplot(412), plot(abs(x2)), title('Plot of x[n] for w0 = 0.2*pi');
subplot(413), plot(abs(x3)), title('Plot of x[n] for w0 = 0.4*pi');
subplot(414), plot(abs(x4)), title('Plot of x[n] for w0 = 0.8*pi');

figure,
subplot(411), plot(abs(y1)), title('Plot of y[n] for w0 = 0.1*pi');
subplot(412), plot(abs(y2)), title('Plot of y[n] for w0 = 0.2*pi');
subplot(413), plot(abs(y3)), title('Plot of y[n] for w0 = 0.4*pi');
subplot(414), plot(abs(y4)), title('Plot of y[n] for w0 = 0.8*pi');

%%

disp('From the graphs, mag(y) = mag(x) * mag(H)');

Ha = abs(H);
H1 = Ha(max(find((w - 0.1*pi) < 0.0001)));
H2 = Ha(max(find((w - 0.2*pi) < 0.0001)));
H3 = Ha(max(find((w - 0.4*pi) < 0.0001)));
H4 = Ha(max(find((w - 0.8*pi) < 0.0001)));

X1 = max(abs(x1));
X2 = max(abs(x2));
X3 = max(abs(x3));
X4 = max(abs(x4));

Y1 = max(abs(y1));
Y2 = max(abs(y2));
Y3 = max(abs(y3));
Y4 = max(abs(y4));

disp(['At w = 0.1*pi, ' num2str(Y1) ' ~ ' num2str(X1*H1)]);
disp(['At w = 0.2*pi, ' num2str(Y2) ' ~ ' num2str(X2*H2)]);
disp(['At w = 0.4*pi, ' num2str(Y3) ' ~ ' num2str(X3*H3)]);
disp(['At w = 0.8*pi, ' num2str(Y4) ' ~ ' num2str(X4*H4)]);

%%

Hmin1 = (1-0.9*exp(1j*0.6*pi)*(z^-1));
Hmin2 = (1-0.9*exp(-1j*0.6*pi)*(z^-1));
Hmin3 = (1-0.8*exp(-1j*0.8*pi)*(z^-1));
Hmin4 = (1-0.8*exp(-1j*0.8*pi)*(z^-1));

Hmin  = (1.25^2)*(Hmin1*Hmin2*Hmin3*Hmin4);
Hmine = (1/Hmin);

gain = 1/(1.25^2);

den1 = [1 -0.9*exp(1j*0.6*pi)];
den2 = [1 -0.9*exp(-1j*0.6*pi)];
den3 = [1 -0.8*exp(1j*0.8*pi)];
den4 = [1 -0.8*exp(-1j*0.8*pi)];

denin1 = conv(den1,den2);
denin2 = conv(den3,den4);

denin = conv(denin1,denin2);

numin = [1 0 0 0];

w = linspace(-pi,pi,1000);

new = freqz(gain*numin,denin,w);

figure
subplot(311),plot(w,abs(new)),title('Magnitude Response for Hi(z)');
subplot(312),plot(w,phase(new)), title('Phase Response for Hi(z)');
subplot(313),plot(w,grpdelay(numin,denin,w)), title('Group Delay for Hi(z)');

%%

hin = impz(gain*numin,denin);

yin1 = conv(hin,y1);
yin2 = conv(hin,y2);
yin3 = conv(hin,y3);
yin4 = conv(hin,y4);

figure
subplot(411),plot(abs(yin1)),title('Plot of x_[n] at w = 0.1*pi');
subplot(412),plot(abs(yin2)),title('Plot of x_[n] At w = 0.2*pi');
subplot(413),plot(abs(yin3)),title('Plot of x_[n] At w = 0.4*pi');
subplot(414),plot(abs(yin4)),title('Plot of x_[n] At w = 0.9*pi');

%%

Hap1 = ((z^-1)-0.8*exp(-1j*0.8*pi));
Hap2 = ((z^-1)-0.8*exp(1j*0.8*pi));
Hap3 = (1-(z^-1)*0.8*exp(-1j*0.8*pi));
Hap4 = (1-(z^-1)*0.8*exp(1j*0.8*pi));

Hap = (Hap1*Hap2)/(Hap3*Hap4);

H = Hmin*Hap*Hmine;

nm1 = [-0.8*exp(-1j*0.8*pi) 1];
nm2 = [-0.8*exp(1j*0.8*pi) 1];
dn1 = [1 -0.8*exp(-1j*0.8*pi)];
dn2 = [1 -0.8*exp(1j*0.8*pi)];

nm = conv(nm1,nm2);
dn = conv(dn1,dn2);

w = linspace(-pi,pi,1000);

bk = freqz(nm,dn,w);

figure
subplot(311),plot(w,abs(bk)),title('Magnitude Response for Hc(z)');
subplot(312),plot(w,phase(bk)),title('Phase Response for Hc(z)');
subplot(313),plot(w,group_delay(w,phase(bk))),title('Group Delay for Hc(z)');

%%

n = 1:100;

Wc1 = 0.1*pi;
Wc2 = 0.2*pi;
Wc3 = 0.4*pi;
Wc4 = 0.8*pi;

x1 = sinc(pi*(n-50)/16).*cos(Wc1*n);
x2 = sinc(pi*(n-50)/16).*cos(Wc2*n);
x3 = sinc(pi*(n-50)/16).*cos(Wc3*n);
x4 = sinc(pi*(n-50)/16).*cos(Wc4*n);

nm1 = [-0.8*exp(-1j*0.8*pi) 1];
nm2 = [-0.8*exp(1j*0.8*pi) 1];
dn1 = [1 -0.8*exp(-1j*0.8*pi)];
dn2 = [1 -0.8*exp(1j*0.8*pi)];

nm = conv(nm1,nm2);
dn = conv(dn1,dn2);

bh = impz(nm,dn);

yb1 = conv(bh,x1);
yb2 = conv(bh,x2);
yb3 = conv(bh,x3);
yb4 = conv(bh,x4);

figure
subplot(411),plot(abs(yb1)),title('Cascaded y[n] at w = 0.1*pi');
subplot(412),plot(abs(yb2)),title('Cascaded y[n] at w = 0.2*pi');
subplot(413),plot(abs(yb3)),title('Cascaded y[n] at w = 0.4*pi');
subplot(414),plot(abs(yb4)),title('Cascaded y[n] at w = 0.8*pi');

%% Credits

% 
%  Made by:
%  Muhammad Abdlah
%  (2015-EE-166)
%