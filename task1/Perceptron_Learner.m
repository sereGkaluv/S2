% input x: made of K feature row vectors of dimension M
% input d = {-1,1}^K: column vector of dimension K
% output w: (normalized) weight vector the M+1st component is theta
% output n_w_changes: number of weight changes
% output n_iter: number of for-loop cycles
% output n_misclassified: dynamics of number of misclassified data
function [w, n_w_changes, n_iter, n_misclassified] = Perceptron_Learner(x, d, max_iter)
    if nargin == 2
        max_iter = 1000;
    end
        
    [K, M] = size(x);
    w = rand(1, M+1); % (L1)
    phi = x; % (L2-4)
    phi(:,M+1)=ones(K,1); % (L2-4)
    n_w_changes = 0;
    n_misclassified = [];
    for n_iter=1:max_iter
        n_miscl = 0; % (L6)
        for k=1:K % (L7)
            if (sign( w*phi(k,:)') ~= d(k)) % (L8) //!= is in mathlab ~=
                w = w + d(k)*phi(k,:); % (L9)
                n_w_changes = n_w_changes + 1;
                n_miscl = n_miscl + 1; % (L10)
             end % (L11)
        end % (L12)
        n_misclassified(n_iter) = sum((d' ~= sign( w*phi' )));
        if (n_miscl == 0) % (L13)
            break; % (L13)
        end % (L13)
    end % (L13)
    w = w/norm(w);
end
