function y = get_output_system1(x,c)

    y = zeros(1,length(x));
    y(1) = c;
    y(2) = c;

    for n = 3:length(x)
        y(n) = 3*x(n) + y(n-1)/4 + y(n-2)/8;
    end
end

