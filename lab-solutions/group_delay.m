function y = group_delay(w,ph)

    y = zeros(1,length(ph));
    for n = 2:length(ph)
        y(n) = -1*(ph(n)-ph(n-1))/(w(n)-w(n-1));
    end
    
    y(1) = y(length(ph));
    
end