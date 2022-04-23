classdef particle < handle
  properties
    x double; y double; % Particle position
    pbest double;   % Particle personal best
    pbest_pos(1,2) double; % Personal best location
    vel(1,2) double;    % Particle velocity
    circle matlab.graphics.primitive.Rectangle;
  end

  methods

    % Constructor
    function obj = particle
      % Set starting properties
      obj.x = Parameters.ParticleSpawnArea(1)+(Parameters.ParticleSpawnArea(2)-Parameters.ParticleSpawnArea(1))*rand();
      obj.y = Parameters.ParticleSpawnArea(1)+(Parameters.ParticleSpawnArea(2)-Parameters.ParticleSpawnArea(1))*rand();
      obj.vel = rand(1, 2)*0.1; % Particle speed?
      obj.pbest = Parameters.Function(obj.x, obj.y);
      obj.pbest_pos = [obj.x, obj.y];
      % Define Circle
      obj.circle = rectangle('Curvature', [1, 1], 'FaceColor', 'm', 'EdgeColor', 'k');
      obj.drawSelf(); % Draw
    end

    % Update position
    function update(obj, gbest_pos)
      % Update velocity
      obj.vel = obj.vel.*Parameters.ParticleWeight ...
          + Parameters.ParticleExplotation*rand().*(obj.pbest_pos - [obj.x, obj.y]) ...
          + Parameters.ParticleExploration*rand().*(gbest_pos - [obj.x, obj.y]);
      % Update position
      obj.x = obj.x + obj.vel(1);
      obj.y = obj.y + obj.vel(2);
      % Update our personal recods
      obj.updateRecords();
      obj.drawSelf(); % Draw
    end

    % Update personal best
    function updateRecords(obj)
      % Get the value of our pos from the function
      chck = Parameters.Function(obj.x, obj.y);
      % Check if it is better than our personal best, if so, update it
      if obj.pbest*Parameters.MaxOrMin < chck*Parameters.MaxOrMin
          obj.pbest = chck;
          obj.pbest_pos = [obj.x, obj.y];
      end
    end

    % Draw particle
    function drawSelf(obj)
      % If we are out of bounds anywhere, make us not visible
      if obj.x > Parameters.GraphMax || obj.x < Parameters.GraphMin || ...
              obj.y > Parameters.GraphMax || obj.y < Parameters.GraphMin
          % If this is our first time off screen let us know
          if get(obj.circle, 'Visible') == 1
            disp("Particle off-screen.")
          end
          set(obj.circle, 'Visible', 0);
      else
          % otherwise make us visible
          set(obj.circle, 'Visible', 1);
      end
      % Move particle to position
      set(obj.circle, 'Position', [obj.x, obj.y, Parameters.ParticleSize, Parameters.ParticleSize]);
    end
  end
end