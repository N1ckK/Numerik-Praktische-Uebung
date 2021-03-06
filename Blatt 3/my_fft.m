function b = my_fft(y)
    n = length(y);
    s = log2(n);
    if (s ~= floor(s))
        disp("my_fft() only support vectors with length n=2^s for some natural s.");
        return;
    end
    b = 1/n * conj(my_ifft(conj(y), s));
end

% n = 2^s is the size of T and b(eta)
function y = my_ifft(b, s)
    n = 2^s;
    T = calc_T(s); 
    if (s == 0)
        y = T*b;
        return;
    end
    s_new = s - 1;
    n_new = 2^s_new;
    % b_odd and b_even are interchanged in comparison to
    % the lecture because indexing starts at 1 in matlab
    b_even = zeros(n_new, 1);
    b_odd = zeros(n_new, 1);
    for i=1:n_new
        b_even(i) = b(2*i);
        b_odd(i) = b(2*i - 1);
    end
    D = zeros(n_new);
    for l=0:n_new-1
        exponent = 1i*2*pi*l/n;
        D(l+1, l+1) = exp(exponent);
    end
    res_1 = my_ifft(b_odd, s_new);
    res_2 = D*my_ifft(b_even, s_new);
    y_1 = res_1 + res_2;
    y_2 = res_1 - res_2;
    y = [y_1; y_2];
    return;
end

function T = calc_T(s)
    n = 2^s;
    x = zeros(n,1);
    for i=0:n-1
        x(i+1) = 2*pi*i/n;
    end
    T = zeros(n);
    for k=0:n-1
        for l=1:n
            exponent = 1i*k*x(l);
            T(l, k+1) = exp(exponent);
        end
    end
end