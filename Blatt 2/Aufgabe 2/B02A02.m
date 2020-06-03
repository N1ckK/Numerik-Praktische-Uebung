function B02A02()
    part1();  
end

function part1()
    disp("Part 1: Approximation of sqrt(x) with a linear spline");
    disp("Please press enter to view the next step...");
    disp(" ");
    call_calc(@plot_linear_approximation_of_f, @eqidistant);
    call_calc(@plot_linear_approximation_of_f, @exponential);
end    

function part2()

end


function call_calc(calc, grid_points)
    if (isequal(grid_points, @eqidistant))
        disp("equidistant grid points:");
    else 
        disp("exponential-distant grid points x_i = (i/n)^4:");
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