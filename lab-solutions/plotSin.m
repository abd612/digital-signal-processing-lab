function plotSin( f1 )

x = linspace(0, 2*pi, f1*16+1);
figure
plot(x, sin(f1*x))
end

