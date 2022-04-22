@particle;


% Plot graph
f = @(x,y) (x-3.14).^2 + (y-2.72).^2 + sin(3*x+1.41) + sin(4*y-1.73);
fcontour(f, [0,5,0,5], '--k', 'Fill','on');
colorbar


x = 0;
pos = [x 1 0.1 0.1];
test = rectangle('Position',pos,'Curvature',[1 1], 'FaceColor', 'm', 'EdgeColor', 'k');

for c = 0:0.05:5
  set(test, 'Position', [c 1 0.1 0.1])
  pause(0.01)
end