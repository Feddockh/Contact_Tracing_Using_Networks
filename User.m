classdef User
    properties (Access = private)
        ID
        X
        Y
        TX_db
        Status
    end
    methods
        function obj = User(id, x, y, tx_db)
            if nargin > 0
                obj.ID = id;
                obj.X = x;
                obj.Y = y;
                obj.TX_db = tx_db;
            end
        end
        
        function id = getID(obj)
            id = obj.ID;
        end
        function x = getX(obj)
            x = obj.X;
        end
        function y = getY(obj)
            y = obj.Y;
        end
        function tx_db = getTX(obj)
            tx_db = obj.TX_db;
        end
        function status = getStatus(obj)
            status = obj.Status;
        end
    end
end