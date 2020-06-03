function B02A02()
    % part1(); 
    part2(); 
end

function part1()
    disp("Part 1: Approximation of sqrt(x) with a linear spline");
    disp("Please press enter to view the next step...");
    disp(" ");
    call_calc(@plot_linear_approximation_of_f, @eqidistant);
    call_calc(@plot_linear_approximation_of_f, @exponential);
end    

function part2()
    call_calc(@cubic_spline_interpolation, @eqidistant);
end


function call_calc(calc, grid_points)
    if (isequal(grid_points, @eqidistant))
        disp("equidistant grid points:");
    else 
        disp("exponential-distant grid points x_i = (i/n)^4:");
    end
    for k=1:2
        n = 2^k;
        x = grid_points(n);
        calc(x);
    end
end

function x = eqidistant(n)
    x = zeros(n+1,0);
    for i=0:n
        x(i+1) = i/n;
    end 
end    

function x = exponential(n)
    x = zeros(n+1,0);
    for i=0:n
        x(i+1) = (i/n)^4;
    end  
end    


%% f: This is the function from part i)
function y = f(x)
    y = sqrt(x);
end

%% g: This is the function from part ii)
function y = g(x)
    y = sin(2*pi*x);
end

function plot_linear_approximation_of_f(x)
    n = length(x);
    fprintf("n = %d\n", n-1);
    y = f(x);
    plot(x, y);
    pause
end

function cubic_spline_interpolation(x)
    n = length(x)-1;
    fprintf("n = %d\n", n);
    y = f(x);
    % a_1, ..., a_n, b_1, ..., b_n, c_1, ..., c_n, d_1, ..., d_n
    A = zeros(4*n);
    b = zeros(4*n, 0);
    % grid points
    for i=1:n
        A(i, (i-1)*4+1) = x(i)^3;
        A(i, (i-1)*4+2) = x(i)^2;
        A(i, (i-1)*4+3) = x(i);
        A(i, (i-1)*4+4) = 1;

        b(i) = y(i);
    end
    % first derivatives
    for i=1:n-1
        A(i+n, (i-1)*4+1) = 3*x(i)^2 - 3*x(i+1)^2;
        A(i+n, (i-1)*4+2) = 2*x(i) - 2*x(i+1);
        A(i+n, (i-1)*4+3) = 1 - 1;

        b(i+n) = 0;
    end
    % second derivatives
    for i=1:n-1
        A(i+2*n-1, (i-1)*4+1) = 6*x(i) - 6*x(i+1);
        A(i+2*n-1, (i-1)*4+2) = 2 - 2;

        b(i+2*n) = 0;    
    end

    disp(A);
    disp(b);
end