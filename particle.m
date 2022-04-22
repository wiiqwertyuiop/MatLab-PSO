classdef particle
  properties
    this matlab.graphics.primitive.Rectangle
  end

  methods
      function obj = particle(x, y)
        obj.this = rectangle('Position',[x y 0.1 0.1], 'Curvature',[1 1], 'FaceColor', 'm', 'EdgeColor', 'k');
     end
     function update(obj, x, y)
        set(obj.this, 'Position',[x y 0.1 0.1]);
     end
  end
end

