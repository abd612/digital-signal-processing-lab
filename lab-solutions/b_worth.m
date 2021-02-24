function [num,den] = b_worth(Wp, Ws, Rp, Rs, Fs)

    N = ceil(mag2db((1/db2mag(Rs)^2-1)/(1/db2mag(Rp)^2-1))/(2*mag2db(Ws/Wp)))
    Wc = Wp/((1/db2mag(Rp)^2-1)^(1/(2*N)));
    
    Fc = Fs/pi * tan(Wc/(2*Fs));
    p = 2*pi*Fc*(1i*cos((2*(1:N)-1)*pi/(2*N))-sin((2*(1:N)-1)*pi/(2*N)));
    
    den = real(poly((1+p/(2*Fs))./(1-p/(2*Fs))));
    num = poly(-ones(1,N))*sum(den)/sum(poly(-ones(1,N)));

end

