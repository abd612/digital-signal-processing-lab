function y = get_output_system4(x,c)

    y = zeros(1,length(x));
    y(1:21) = c;
    
    for n = 22:length(x)
        y(n) = 0.1*y(n-2) + 0.5*x(n-10) + 0.4*y(floor(n/2)-10);
    end
end