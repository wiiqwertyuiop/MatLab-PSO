classdef Parameters
  properties(Constant, GetAccess='public')

     % Function
     Function = @(x,y) (sin(x)).^2 +(sin(y)).^2 + sin(x) .* sin(y);
         %(x-3.14).^2 + (y-2.72).^2 + sin(3*x+1.41) + sin(4*y-1.73);

     MaxOrMin = 1; % Set 1 if you wish to find the maximum.
                    % Set to -1 to find the minimum.

     % Graph area
     GraphMin = 0;
     GraphMax = 5;
    
     % Area where particle are allowed to spawn
     ParticleSpawnArea = [0, 5];
     ParticleSize = abs(Parameters.GraphMax-Parameters.GraphMin)/50;

     % Algorithm parameters
     ParticleWeight = 0.8; % w
     ParticleExplotation = 0.1; % c1
     ParticleExploration = 0.1; % c2
     
     NumberOfParticles = 20; % Size of "flock"
     NumberOfIterations = 50; % How many iterations is PSO to execute

     Delay = 0.01; % Delay between particle updates.
  end
end