function B0302()
    % number of support points
    n = 2 ^ 5;
      
    for i = 1:4
        % beta coefficients
        figure(1);
        plot_fourier(i, n, 'b');
        
        % delta coefficients
        figure(2);
        plot_fourier(i, n, 'd');
        
        pause();
        clf('reset')
    end
end

function B = calc_beta_coeffs(i, n)
    % Calculates beta coefficients for the function f_i using
    % n+1 eqidistant support points
    % Returns these coefficients
    x = arrayfun(@(j) 2 * pi * j / n, 0:n-1);
    y = arrayfun(@(x) f(x, i), x);
    B = fft(y) / n;
end

function D = calc_delta_coeffs(i, n)
    % Calculates delta coefficients for the function f_i using
    % n+1 eqidistant support points
    % Returns these coefficients
    B = calc_beta_coeffs(i, n);
    % ----------------------------- | ---------------------------
    % b_n/2 | b_n/2+1 | ... | b_n-1 | b_0 | b_1 | ... | b_n/2-1 
    % ----------------------------- | ---------------------------
    D = [B(n/2+1 : n), B(1 : n/2)];
end

function value = values_from_beta_coeffs(B, n, x, part)
    % Calculates the value at x of the fourier polynom
    % if part == 'r' -> real part, if part == 'i' -> imag part
    value = 0;
    for j = 0:n-1
        value = value + B(j + 1) * exp(1i * j * x);
    end
    
    % conditional assignment
    value = (part == 'r') .* real(value) + (part == 'i') .* imag(value);
end

function value = values_from_delta_coeffs(B, n, x, part)
    % Calculates the value at x of the fourier polynom
    % if part == 'r' -> real part, if part == 'i' -> imag part
    value = 0;
    for j = 0:n-1
        value = value + B(j + 1) * exp(1i * (j - n / 2) * x);
    end
    
    % conditional assignment
    value = (part == 'r') .* real(value) + (part == 'i') .* imag(value);
end

function plot_fourier(i, n, c)
    % plots with delta coeffs if c == 'd' and with beta coeffs if c == 'b'
    B = ((c == 'b') .* calc_beta_coeffs(i, n) ...
       + (c == 'd') .* calc_delta_coeffs(i, n));
    
    % support points
    supp = arrayfun(@(j) 2 * pi * j / n, 0:n-1);
    
    x = linspace(0, 2 * pi, 450);
    
    % choose values
    if c == 'b'
        y_real = arrayfun(@(z) values_from_beta_coeffs(B, n, z, 'r'), x);
        y_imag = arrayfun(@(z) values_from_beta_coeffs(B, n, z, 'i'), x);
    elseif c == 'd'
        y_real = arrayfun(@(z) values_from_delta_coeffs(B, n, z, 'r'), x);
        y_imag = arrayfun(@(z) values_from_delta_coeffs(B, n, z, 'i'), x);
    end
    
    % --- plot real part
    subplot(3, 1, 1);
    plot(x, y_real)
    
    hold on
    plot(x, arrayfun(@(z) real(f(z, i)), x), '--');
    plot(supp, arrayfun(@(z) real(f(z, i)), supp), "ob");

    xlim([0 2*pi]);
    title(['real part, n=', num2str(n), ', coeffs=', c]);
    hold off
    
    % --- plot imag part
    subplot(3, 1, 2);
    plot(x, y_imag)
    hold on
    plot(x, arrayfun(@(z) imag(f(z, i)), x), '--');
    plot(supp, arrayfun(@(z) imag(f(z, i)), supp), "ob");

    xlim([0 2*pi]);
    title(['imag part, n=', num2str(n), ', coeffs=', c]);
    hold off
    
    % plot spectrum
    subplot(3, 1, 3);
    plot(0:n-1, abs(B));
    
    xlim([0 n-1]);
    title("spectrum")
end