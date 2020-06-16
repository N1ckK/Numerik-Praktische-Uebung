function B0302()
    % number of support points
    n = 2 ^ 5;
    
    % plots f_2 with n support points
    plot_fourier(1, n);
    pause();
    clf('reset')
    plot_fourier(2, n);
    pause();
    clf('reset')
    plot_fourier(3, n);
    pause();
    clf('reset')
    plot_fourier(4, n);
end

function B = calc_beta_coeffs(i, n)
    % Calculates beta coefficients for the function f_i using
    % n+1 eqidistant support points
    % Returns these coefficients
    x = arrayfun(@(j) 2 * pi * j / n, 0:n-1);
    y = arrayfun(@(x) f(x, i), x);
    B = fft(y) / n;
end

function value = fourier_from_coefficients(B, n, x, part)
    % Calculates the imaginary part value at x of the fourier polynom
    % if part == 'r' -> real part, if part == 'i' -> imag part
    value = 0;
    for j = 0:n-1
        value = value + B(j + 1) * exp(1i * j * x);
    end
    
    % conditional assignment
    value = (part == 'r') .* real(value) + (part == 'i') .* imag(value);
end

function plot_fourier(i, n)
    B = calc_beta_coeffs(i, n);
    
    % support points
    supp = arrayfun(@(j) 2 * pi * j / n, 0:n-1);
    
    x = linspace(0, 2 * pi, 450);
    y_real = arrayfun(@(z) fourier_from_coefficients(B, n, z, 'r'), x);
    y_imag = arrayfun(@(z) fourier_from_coefficients(B, n, z, 'i'), x);
    
    % plot real part
    subplot(3, 1, 1);
    plot(x, y_real)
    hold on
    plot(x, arrayfun(@(z) real(f(z, i)), x));
    plot(supp, arrayfun(@(z) real(f(z, i)), supp), "ob");
    
    xlim([0 2*pi]);
    %ylim([-5 5]);
    title("real part")
    hold off
    
    % plot imag part
    subplot(3, 1, 2);
    plot(x, y_imag)
    hold on
    plot(x, arrayfun(@(z) imag(f(z, i)), x));
    plot(supp, arrayfun(@(z) imag(f(z, i)), supp), "ob");
    
    xlim([0 2*pi]);
    %ylim([-5 5]);
    title("imag part")
    hold off
    
    % plot spectrum
    hold on
    subplot(3, 1, 3);
    plot(0:n-1, abs(B));
    xlim([0 n-1]);
    title("spectrum")
    hold off
end