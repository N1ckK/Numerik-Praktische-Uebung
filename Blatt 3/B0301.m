function B0301()
    for r=1:4
        for s=1:5
            n = 2^s;
            y = zeros(n,1);
            for i=0:n-1
                y(i+1) = f(2*pi*i/n, r)
            end
            b = my_fft(y)
            b_ = fft(y)
            plot_f(r);
            hold on;
            plot_fourier(b);
            pause;
            hold off;
        end
    end
end

function y = evalute_trig_interpolation(b, x)
    n = length(b);
    y = 0;
    for k=0:n-1
        exponent = 1i*k*x;
        y = y+ b(k+1)*exp(exponent);
    end
end

function plot_f(r)
    x = linspace(0, 2*pi, 1000);
    y = zeros(1000);
    for i=1:1000
        y(i) = f(x(i), r);
    end
    plot(x,y);
end

function plot_fourier(b)
    x = linspace(0, 2*pi, 1000);
    y = zeros(1000);
    for i=1:1000
        y(i) = evalute_trig_interpolation(b, x(i));
    end
    plot(x,y);
end