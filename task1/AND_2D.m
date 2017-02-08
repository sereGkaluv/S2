% Example data 2D:
x = [ 0,0; 0,1; 1,0; 1,1];
d = [ -1; -1; -1; 1];
%
[w, nw, ni, nmis] = Perceptron_Learner(x, d);

subplot(2,1,1);
% Plotting:
plot(nmis) % dynamics of number of misclassifications
xlabel('Iterations');
ylabel('Misclassification');
tries = size(nmis, 2);
max_val = max(nmis);
axis([1 tries 0 max_val+0.5]);
% Show data points and decision boundary:
xl=min(x(:,1)); 
xu=max(x(:,1));
yl=min(x(:,2)); 
yu=max(x(:,2));

%clf()
subplot(2,1,2)
plot( x(1:3, 1), x(1:3, 2), 'ro', x(4:4, 1), x(4:4, 2), 'g+',...
    [xl, xu], [-(xl*w(1)+w(3))/w(2), -(xu*w(1)+w(3))/w(2)], 'linewidth', 2);
xlabel('Decision Boundary');
axis([xl-abs(0.1*(xu-xl)), xu+abs(0.1*(xu-xl)), yl-abs(0.1*(yu-yl)), yu+abs(0.1*(yu-yl))]);