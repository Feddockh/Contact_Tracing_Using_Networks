classdef Environment
    properties (Access = private)
        Size_X
        Size_Y
        Steps
        Num_Users
        Users
    end
    methods
        function obj = Environment(x, y, steps, num_users)
            if nargin > 0
                obj.X = x;
                obj.Y = y;
                obj.Steps = steps;
                obj.Num_Users = num_users;
            end
        end
        
        function users = getUsers(obj, step)
            users = obj.Users;
        end
    end
end