function y = get_output_system3(x)

    y = zeros(1, length(x));
    n = 1:floor(sqrt(length(y)));
    y(n) = x((n).*(n));
    y(floor(sqrt(length(y)))+1:length(y)) = 0;

end

