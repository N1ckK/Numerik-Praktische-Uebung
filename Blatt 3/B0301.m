function B0301()
    disp("For performance improvements the plotting accuracy is limited.")
    disp("Press enter to show the next iteration...");
    for r=1:4
        fprintf("\nFunction f_r(x), r = %d\n", r);
        for s=1:5
            n = 2^s;
            fprintf("\tn = %d\n" , n);
            y = zeros(n,1);
            x = zeros(n,1);
            for i=0:n-1
                x(i+1) = 2*pi*i/n;
                y(i+1) = f(x(i+1), r);
            end
            b = my_fft(y);
            plot_fourier(b, r, x, y);
            pause;
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

function plot_fourier(b, r, x_, y_)
    x = linspace(0, 2*pi, 300);
    y = zeros(300);
    y1 = zeros(300);
    for i=1:300
        y(i) = evalute_trig_interpolation(b, x(i));
        y1(i) = f(x(i), r);
    end
    subplot(2,1,1);
    plot(x, real(y));
    xlim([0 2*pi]);
    ylim([-5 5]);
    title("Real part");
    hold on
    plot(x, real(y1));
    plot(x_, real(y_), "ob");
    hold off
    subplot(2,1,2);
    plot(x, imag(y));
    xlim([0 2*pi]);
    ylim([-5 5]);
    title("Complex part");
    hold on
    plot(x, imag(y1));
    plot(x_, imag(y_), "ob");
    hold off
end