function y = system_z(x, c, n1, n2)

    w0=(2000*pi/11025);
    y(-n1) = c;

    for n = -n1+1:-n1+n2+1
        y(n) = -2*cos(w0)*x(n-1) - 0.5*y(n-1) + x(n) + x(n-2);
    end

end

