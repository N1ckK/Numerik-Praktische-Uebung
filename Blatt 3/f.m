function y = f(x, index)
    switch index
        case 1
            y = f_1(x);
        case 2
            y = f_2(x);
        case 3
            y = f_3(x);
        case 4
            y = f_4(x);
        otherwise
            y = 0;
            disp("selected wrong function")
    end
end

function y = f_1(x)
    sin(5*x) + 0.5i*cos(x);
end

function y = f_2(x)
    if (x<=pi+1/4 && x>=pi-1/4)
        y = 1;
    else 
        y = 0;
    end
end

function y = f_3(x)
    if (x<pi && x>=0)
        y = 1;
    else 
        y = -1;
    end
end

function y = f_4(x)
    if (x<pi && x>=0)
        y = x;
    else 
        y = 2*pi - x;
    end
end
