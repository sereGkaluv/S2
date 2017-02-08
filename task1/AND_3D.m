% Example data 3D:
x = [ 0,0,0; 0,0,1; 0,1,0; 1,0,0; 0,1,1; 1,1,0; 1,0,1; 1,1,1];
d = [ -1; -1; -1; -1; -1; -1; -1; 1];
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


%clf()
subplot(2,1,2)
plot3(x(1:7, 1), x(1:7, 2), x(1:7, 3), 'ro', x(8:8, 1), x(8:8, 2), x(8:8, 3), 'g+', 'linewidth', 2);
%xlabel('Decision Boundary');
%axis([xl-abs(0.1*(xu-xl)), xu+abs(0.1*(xu-xl)), yl-abs(0.1*(yu-yl)), yu+abs(0.1*(yu-yl))]);

grid on
xlabel('x');
ylabel('y');
zlabel('z');