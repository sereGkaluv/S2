% we use abs(x) instead of x in order to ensure positiveness of parameters
function qual = f_ges(x)
    global LensParms Weighting;
    n = length(x);
    f_fokus = sum( ( LensParms.R ...
    - ( LensParms.h*((1:n-1)-.5) + LensParms.b/LensParms.h * ...
    (LensParms.eps-1) * ...
    (abs(x(2:n)) - abs(x(1:n-1)))' ) ).^2 );
    f_masse = LensParms.h*(sum(abs(x(2:n-1))) + 0.5*(abs(x(1))+abs(x(n))));
    qual = Weighting*f_fokus + (1-Weighting)*f_masse; % weighting of goals
end