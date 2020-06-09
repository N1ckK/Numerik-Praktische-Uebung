function B0301()
    for r=1:4
        for s=1:5
            n = 2^s;
            y = zeros(n,1);
            for i=0:n-1
                y(i+1) = f(2*pi*i/n, r)
                b = my_fft(y)
            end
        end
    end
end
