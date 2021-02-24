function [y] = four_tran(x,N)

    y = zeros(1,N);
    L = length(x);
    
    for m = 1:N
        y(m) = 0;
        for n = 1:L
            y(m) = y(m) + x(n).*exp(-1j.*2.*pi.*(n-1).*(m-1)./L);
        end
    end
    
end