function plotUserPaths(n, users)
    
    % Create the space
    space = zeros(n);

    % Check indicies for exisiting user
    collisionCoordinates = [];
    
    % Loop through each user
    for (i = 1:length(users))
    
        % Retrieve the coordinates travelled by the user
        coordinates = users(i).getCoordinates();

        for (j = 1:length(sub2ind(size(space), coordinates(:, 1), coordinates(:, 2))))

            % Get the current index
            index = sub2ind(size(space), coordinates(:, 1), coordinates(:, 2));

            if (space(index(j)) > 0)
                collisionCoordinates = [collisionCoordinates; coordinates(j, :)]
            end

        end
    
        % Format the set of coordinates as indicies 
        space(sub2ind(size(space), coordinates(:, 1), coordinates(:, 2))) = i

    end

    space(sub2ind(size(space), collisionCoordinates(:, 1), collisionCoordinates(:, 2))) = length(users) + 1

    % 
    
    % blue_cells = [1 2; 3 4; 5 1];
    
    % grid(sub2ind(size(grid), blue_cells(:, 1), blue_cells(:, 2))) = 1;
    
    % grid(sub2ind(size(grid), blue_cells(:, 2), blue_cells(:, 1))) = 2;
    
    figure;
    imagesc(space);
    colormap(gca, [1 1 1; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0]);
    axis equal tight;
    grid on;

end