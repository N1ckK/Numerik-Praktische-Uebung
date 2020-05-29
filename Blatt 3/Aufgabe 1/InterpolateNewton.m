function lambdas = InterpolateNewton(x, y, n)

% y00  y01  ........................ y0n
% y10  y21   ................  y1(n-1)
% y20  y31   ............    .
% y30   .  ..........    .
% .     . .......    .
% .     . ....    .
% .    y(n-1)1 
% yn0

% lambda = [y00, y01, ..., y0n]

% list where coefficients will be stored
lambdas = [];

lambdas = [lambdas, y(1)];

for j=1:n
    for i=1:n-j+1
        y(i) = (y(i+1) - y(i)) / (x(i + j) - x(i));
    end
    lambdas = [lambdas, y(1)];
end