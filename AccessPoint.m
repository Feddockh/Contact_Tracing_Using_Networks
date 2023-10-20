classdef AccessPoint
    properties (Access = private)
        X
        Y
        Sensitivity
    end
    methods
        function obj = AccessPoint(x, y, sensitivity)
            if nargin > 0
                obj.X = x;
                obj.Y = y;
                obj.Sensitivity = sensitivity;
            end
        end
        
        function x = getX(obj)
            x = obj.X;
        end
        function y = getY(obj)
            y = obj.Y;
        end
        function sensitivity = getSensitivity(obj)
            sensitivity = obj.Sensitivity;
        end
    end
end
