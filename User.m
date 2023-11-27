classdef User
    properties (Access = private)
        ID
        Coordinates
        TX_db
        Status
    end
    methods
        function obj = User(id, tx_db)
            if nargin > 0
                obj.ID = id;
                obj.TX_db = tx_db;
                obj.Coordinates = [];
            end
        end
        
        function id = getID(obj)
            id = obj.ID;
        end

        function tx_db = getTX(obj)
            tx_db = obj.TX_db;
        end

        % Add new coordinate to coordinate list
        % TODO: Check if valid coordinate
        function obj = addCoordinate(obj, x, y)
            obj.Coordinates = [obj.Coordinates; x, y];
        end

        % Get the coordinate of the user
        function x = getX(obj, t)
            x = obj.Coordinates(t, 1);
        end

        function y = getY(obj, t)
            y = obj.Coordinates(t, 2);
        end

        function coordinates = getCoordinates(obj)
            coordinates = obj.Coordinates;
        end

        function status = getStatus(obj)
            status = obj.Status;
        end
    end
end