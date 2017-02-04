%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simple Evolution Strategy applied to the optical lens
% optimization. Stategy type: (mu/mu_I, lambda)-CMSA-ES
% Scalarized minimization of quadratic focal point deviation and lens mass
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Copyright by Hans-Georg Beyer (HGB), 25.06.10. For non-commercial use
%% only. Commercial use requires written permission by Hans-Georg Beyer
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

iter = 1;

while( sigma > sigma_stop )
    for l=1:lambda
        sigmaTilde(l) = sigma * exp(tau*randn());
        sTilde(:, l) = (det(chol(C))^(-1/n)*chol(C)')*randn(n,1);
        xTilde(:, l) = x + sigmaTilde(l)*sTilde(:, l);
        fTilde(l) = f_ges(xTilde(:, l));
    end
    
    [fsorted, r] = sort(fTilde, 'ascend');
    BestResWithCovariance(iter) = fsorted(1);
    x = 1/mu * sum(xTilde(:, r(1:mu)), 2);
    sigma = 1/mu * sum(sigmaTilde(r(1:mu)));
    SumSS = zeros(n, n);
    
    for m = 1 : mu; 
        SumSS = SumSS + sTilde(:, r(m))*sTilde(:, r(m))'; 
    end;
    
    C = (1-1/tau_c)*C + (1/tau_c) * (1/mu)*SumSS;
    C = 0.5*(C+C');
    
    iter = iter + 1;
end

%reinital
iter = 1;
sigma = 1;
x = LensParms.x_init*ones(n,1);


while( sigma > sigma_stop && iter < 2000) %second and condtion -> backup
    for l=1:lambda
        sigmaTilde(l) = sigma * exp(tau*randn());
        sTilde(:, l) = randn(n,1); %without Covar.
        xTilde(:, l) = x + sigmaTilde(l)*sTilde(:, l);
        fTilde(l) = f_ges(xTilde(:, l));
    end
    
    [fsorted, r] = sort(fTilde, 'ascend');
    BestResWithoutCovariance(iter) = fsorted(1);
    x = 1/mu * sum(xTilde(:, r(1:mu)), 2);
    sigma = 1/mu * sum(sigmaTilde(r(1:mu)));
    
    iter = iter + 1;
end


semilogy(BestResWithoutCovariance, '-', 'Color', 'blue', 'linewidth', 2);
hold on;
semilogy(BestResWithCovariance, '-', 'Color', 'green', 'linewidth', 2);

ylabel('Fitness', 'FontSize', 12);
xlabel('Generations', 'FontSize', 12);

title('CMSA-ES', 'FontSize', 14);
legend('Without Covariance Matrix','With Covariance Matrix');