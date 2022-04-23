classdef particle < handle
  properties
    x double; y double; % Particle position
    pbest double;   % Particle personal best
    pbest_pos(1,2) double; % Personal best location
    vel(1,2) double;    % Particle velocity
    rect matlab.graphics.primitive.Rectangle;
  end

  methods

    % Constructor
    function obj = particle
      % Set starting properties
      obj.x = Parameters.GraphMin+(Parameters.GraphMax-Parameters.GraphMin)*rand();
      obj.y = Parameters.GraphMin+(Parameters.GraphMax-Parameters.GraphMin)*rand();
      obj.vel = rand(1, 2)*0.1; % Particle speed?
      obj.pbest = Parameters.Function(obj.x, obj.y);
      obj.pbest_pos = [obj.x, obj.y];
      % Draw particle
      obj.rect = rectangle('Position', [obj.x, obj.y, 0.1, 0.1], ...
          'Curvature',[1 1], 'FaceColor', 'm', 'EdgeColor', 'k');
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
      set(obj.rect, 'Position', [obj.x, obj.y, 0.1, 0.1]);
      % Finally update our personal recods
      obj.updateRecords();
    end

    % Update personal best
    function updateRecords(obj)
      chck = Parameters.Function(obj.x, obj.y);
      if obj.pbest*Parameters.MaxOrMin < chck*Parameters.MaxOrMin
          obj.pbest = chck;
          obj.pbest_pos = [obj.x, obj.y];
      end
    end
  end
end