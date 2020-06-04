function B02A02()
    part1(); 
    part2(); 
end

function part1()
    disp("Part 1: Approximation of sqrt(x) with a linear spline");
    disp("Please press enter to view the next step...");
    disp(" ");
    call_calc(@plot_linear_approximation_of_f, @eqidistant);
    call_calc(@plot_linear_approximation_of_f, @quartic);
end    

function part2()
    disp(" ");
    disp(" ");
    disp("Part 2: Approximation of sqrt(x) with a linear spline");
    disp("Please press enter to view the next step...");
    disp(" ");
    call_calc(@cubic_spline_interpolation_of_g, @eqidistant);
    call_calc(@cubic_spline_interpolation_of_g, @quartic);
end


function call_calc(calc, grid_points)
    if (isequal(grid_points, @eqidistant))
        disp("equidistant grid points:");
    else 
        disp(" ");
        disp("quartic-distant grid points:");
    end
    for k=1:4
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

function x = quartic(n)
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
    fprintf("\tn = %d\n", n-1);
    y = f(x);
    plot(x, y);
    pause;
end

function cubic_spline_interpolation_of_g(x)
    [A, b] = calc_conditions(x);
    coefficients = linsolve(A,b);
    plot_spline(x, coefficients);
end

function [A,b] = calc_conditions(x)
    n = length(x)-1;
    fprintf("\tn = %d\n", n);
    y = g(x);
    % a_1, ..., a_n, b_1, ..., b_n, c_1, ..., c_n, d_1, ..., d_n
    A = zeros(4*n);
    b = zeros(4*n, 1);
    % grid points left
    for i=1:n
        A(i, (i-1)*4+1) = x(i)^3;
        A(i, (i-1)*4+2) = x(i)^2;
        A(i, (i-1)*4+3) = x(i);
        A(i, (i-1)*4+4) = 1;

        b(i) = y(i);
    end
    % grid points right
    for i=1:n
        A(i+n, (i-1)*4+1) = x(i+1)^3;
        A(i+n, (i-1)*4+2) = x(i+1)^2;
        A(i+n, (i-1)*4+3) = x(i+1);
        A(i+n, (i-1)*4+4) = 1;

        b(i+n) = y(i+1);
    end
    % first derivatives
    for i=1:n-1
        A(i+2*n, (i-1)*4+1) = 3*x(i+1)^2;
        A(i+2*n, (i-1)*4+2) = 2*x(i+1);
        A(i+2*n, (i-1)*4+3) = 1;

        A(i+2*n, (i-1)*4+5) = - 3*x(i+1)^2;
        A(i+2*n, (i-1)*4+6) = - 2*x(i+1);
        A(i+2*n, (i-1)*4+7) = - 1;

        b(i+2*n) = 0;
    end
    % second derivatives
    for i=1:n-1
        A(i+3*n-1, (i-1)*4+1) = 6*x(i+1);
        A(i+3*n-1, (i-1)*4+2) = 2;

        A(i+3*n-1, (i-1)*4+5) = - 6*x(i+1);
        A(i+3*n-1, (i-1)*4+6) = - 2;

        b(i+3*n-1) = 0;    
    end
    % natural Randbedingungen
    A(4*n-1, 1) = 6*x(1);
    A(4*n-1, 2) = 2;
    b(4*n-1) = 0;
    A(4*n, 4*(n-1)+1) = 6*x(n+1);
    A(4*n, 4*(n-1)+2) = 2;
    b(4*n) = 0;
end


function plot_spline(x_grid, coefficients)
    n = 100;
    x = linspace(0,1,n);
    y = zeros(n,1);
    for i=1:n
        y(i) = evaluate_spline(x_grid, coefficients, x(i));
    end
    plot(x,y);
    pause;
end    

function y = evaluate_spline(x_grid, coefficients, x)
    n = length(x_grid)-1;
    for i=1:n
        if (x >= x_grid(i) && x <= x_grid(i+1))
            a = coefficients(4*(i-1)+1);
            b = coefficients(4*(i-1)+2);
            c = coefficients(4*(i-1)+3);
            d = coefficients(4*(i-1)+4);
            
            y = a*x^3+b*x^2+c*x+d;
            return;
        end
    end    
end