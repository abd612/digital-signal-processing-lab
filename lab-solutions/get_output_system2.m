function y = get_output_system2(x)

    y = zeros(1,length(x));
    n = 1:length(x);
    y = cos(pi*n).*x;

end

