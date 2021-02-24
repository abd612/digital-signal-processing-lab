function [y] = get_output_system(x, c, n1, n2)
    
    y = zeros(1,length(x));
    y(n1) = c;
    
    for n = 1:1:n2+1
        y(n1+n) = x(n1+n) + 0.1*y(n1+n-1);
    end
    
    for n = 1:1:n1-1
        y(n1-n) = (y(n1-n+1) - x(n1-n+1))/0.1;
    end
    
end

