@particle;

% Number of particles
n_particles = 20;

% Function to graph
func = @(x,y) (x-3.14).^2 + (y-2.72).^2 + sin(3*x+1.41) + sin(4*y-1.73);

% Plot graph
fcontour(func, [0,5,0,5], '--k', 'Fill','on');
colorbar

particles = particle.empty(n_particles, 0);

for n = 1:n_particles
    particles(n) = particle (5*rand(1),5*rand(1));
end

