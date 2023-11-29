function [pCoordinates] = coordinateCalc(user, access_point, size, timestep)

    % Keep track of potential coordinates
    pCoordinates = [];

    % Compute the RX strength recieved by the AP in DB 
    % (we need to use the true user coordinates for this calculation)
    a = [access_point.getX(), access_point.getY()];
    b = [user.getX(timestep), user.getY(timestep)];
    f = 2.4*10^9;
    n = 2;
    path_loss = compute_loss(a, b, f, n);
    RX_db = user.getTX() - path_loss;

    % Check if the strength is above that required by the access point
    if (RX_db < access_point.getSensitivity())
        return;
    end

    % Determine the distance between the user and the access point
    r = compute_distance(f, n, path_loss);

    % find the coordinates within the plane that lie on the circle
    tolerance = 0.0001;
    for y = 1:size
        for x = 1:size
            d = sqrt((x - access_point.getX())^2 + (y - access_point.getY())^2);
            if (abs(r - d) < tolerance)
                pCoordinates = vertcat(pCoordinates, [x, y]);
            end
        end
    end
end