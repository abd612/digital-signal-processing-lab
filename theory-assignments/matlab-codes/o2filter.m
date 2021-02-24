function y = o2filter(x, w0, p, pc)

    y = 1:length(x);
    y(1:2) = 0;

    for n = 3:length(x)
        y(n) = x(n) - 2*cos(w0)*x(n-1) + x(n-2) + (p+pc)*y(n-1) - p*pc*y(n-2);
    end
    
end