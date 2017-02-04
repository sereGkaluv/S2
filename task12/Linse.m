%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simple Evolution Strategy applied to the optical lens
% optimization. Stategy type: (mu/mu_I, lambda)-CMSA-ES
% Scalarized minimization of quadratic focal point deviation and lens mass
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global LensParms; % physical parameters of the geometrical system
LensParms.h = 1; 
LensParms.b = 20; 
LensParms.R = 7; 
LensParms.eps = 1.5;
LensParms.x_init = 3; % initial lens geometry (being rectangular)
global Weighting; % scalarization factor for bi-objective problem
Weighting =.9;
n = 15; % number of free geometry parameters to be optimized

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here starts the CMSA-ES (cf. Pseudocode)
% initialization
mu = 5; 
lambda = 20; %Offspring
x = LensParms.x_init*ones(n,1); %
sigma = 1; %MutationStrength
sigma_stop = 1e-6; %MinMutation i.e. MutationThreshold
C = eye(n); %Identity Matrix = Einheitsmatrix
tau = 1/sqrt(2*n); %n = search space; tau = constant 
tau_c = 1 + n*(n+1)/(2*mu); % (L1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% here starts generation loop
while( sigma > sigma_stop ) % (L2)
    for l=1:lambda
        sigmaTilde(l) = sigma * exp(tau*randn()); % (L3)
        sTilde(:, l) = (det(chol(C))^(-1/n)*chol(C)')*randn(n,1); % (L4)
        xTilde(:, l) = x + sigmaTilde(l)*sTilde(:, l); % (L5)
        fTilde(l) = f_ges(xTilde(:, l)); % (L6)
    end
    [fsorted, r] = sort(fTilde, 'ascend'); % (L7)
    x = 1/mu * sum(xTilde(:, r(1:mu)), 2); % (L8)
    sigma = 1/mu * sum(sigmaTilde(r(1:mu))); % (L9)
    SumSS = zeros(n, n); % (L10)
    for m=1:mu; SumSS = SumSS + sTilde(:, r(m))*sTilde(:, r(m))'; end; % (L10)
    C = (1-1/tau_c)*C + (1/tau_c) * (1/mu)*SumSS; % (L10)
    C = 0.5*(C+C'); % ensure symmetry of C-matrix
end % (L11)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% after termination, abs(x) returns the x-coordinates (thicknesses)
% of the optimized lens geometry