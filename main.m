@Parameters;
@particle;

Initalize();
ParticleSwarmOptimization();
%% Main

function Initalize()
    % Draw graph
    fcontour(Parameters.Function, ...
        [Parameters.GraphMin, Parameters.GraphMax+0.5, Parameters.GraphMin, Parameters.GraphMax+0.5], ...
        '--k', 'Fill','on');
    colorbar;
    
    % Safeguard: We need at least two particles for the algorithm to run
    if Parameters.NumberOfParticles < 2
        error("Not enough particles: [" + Parameters.NumberOfParticles ...
            + "] need at least 2.");
    end
end

function ParticleSwarmOptimization()
    % Create an array of particles, and determine current global best
    [p, gbest, gbest_pos] = createParticles();
    
    % Begin iterations and execute PSO
    for i = 1:Parameters.NumberOfIterations
      % Update ALL particles for each iteration
      for cur_p = p
          % Update current particle taking into account the global best
          cur_p.update(gbest_pos);
          [gbest, gbest_pos] = updateGlobal(gbest, gbest_pos, cur_p);
          pause(Parameters.Delay); % Add a delay (visual)
      end
    end
    % Display found value
    disp(gbest);
end

function [p, gbest, gbest_pos] = createParticles()
  % Create an empty array of particles
  p = particle.empty(Parameters.NumberOfParticles, 0);
    
  % Create the first particle so we can get the intial global best
  p(1) = particle(); 
  gbest = p(1).pbest;
  gbest_pos = p(1).pbest_pos;
    
  % Now create the rest of the particles
  for n = 2:Parameters.NumberOfParticles
      p(n) = particle();
      [gbest, gbest_pos] = updateGlobal(gbest, gbest_pos, p(n));
  end
end

function [best, best_pos] = updateGlobal(best, best_pos, p)
  % Communicate with the rest of the pack
  % check if we have a new global best
  if best*Parameters.MaxOrMin < p.pbest*Parameters.MaxOrMin
      best = p.pbest;
      best_pos = p.pbest_pos;
  end
end

   

