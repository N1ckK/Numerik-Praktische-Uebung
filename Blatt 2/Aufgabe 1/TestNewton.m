% Define the functions
f = @(x) sin(pi * x);
g = @(x) 1 ./ (1 + 25 * x.^2);
h = @(x) abs(x);

% if set to 1, chebyshev partition is used; else equidistant partition
use_cheby = 0;

% loop through functions
for k=[1, 2, 3]
    % set figure for k-th function
    figure(k);
    % loop through amount of partition points
    for m=[1, 2, 3, 4]
        n = 2 ^ (m - 1);
        % set subplot for given function and given parition points
        subplot(4,1,m);
        
        % x axis for plot
        x = linspace(-1, 1, 101);
        % wait for plots to be plotted
        hold on
        
        % select function based on k
        if k == 1
            u = f;
        elseif k == 2
            u = g;
        elseif k == 3
            u = h;
        end
        
        % calculate the paritition and select desired parition
        if use_cheby == 0
            % tscheby
            partition = arrayfun((@(i) -1 + 2 * i / n), 0:n); 
        elseif use_cheby == 1
            % equidistant
            partition = arrayfun((@(i) cos( (2*i + 1) / (2 * (n+1)) * pi)), 0:n);
        end
        
        % calculate coefficients for interpolated polynom in newton base
        lambdas = InterpolateNewton(partition, arrayfun(u, partition), n);

        % list where values of the interpolated polynom at z_j will be
        % stored
        values = [];
        
        % loop through points where the interpolated polynom should be
        % evaluated
        for j=0:100
            z_j = -1 + 2 * j / 100;
            % calculate value at z_j
            values = [values, HornerEval(lambdas, partition, z_j)];
        end
        % plot the true function
        plot(x,u(x));
        % plot the interpolated function
        plot(x, values);
    end
end

% plot functions
hold off