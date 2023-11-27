classdef ContactPoint
    properties (Access = private)
        Users
        Coordinate
        Certainty
        Time
    end
    methods
        function obj = ContactPoint(users, coordinate, certianty, time)
            if nargin > 0
                obj.Users = users;
                obj.Coordinate = coordinate;
                obj.Certainty = certianty;
                obj.Time = time;
            end
        end

        function users = getUsers(obj)
            users = obj.Users;
        end

        function coordinate = getCoordinate(obj)
            coordinate = obj.Coordinate;
        end

        function certainty = getCertainty(obj)
            certainty = obj.Certainty;
        end

        function time = getTime(obj)
            time = obj.Time;
        end
    end
end