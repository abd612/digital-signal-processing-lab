function plot2Sin( f1,f2 )

x = linspace(0, 2*pi, f1*16+1);
figure

if nargin == 1
    plot(x, sin(f1*x))
elseif nargin == 2
    plot(x, sin(f1*x), x, sin(f2*x))
end
