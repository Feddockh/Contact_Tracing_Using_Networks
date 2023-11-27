function [users] = data_generator(size, num_people, timesteps)

    users = [];
    TX_db = 50; % TODO: Set to random value in a range
    num_people = 4; % Expand to allow more than 4 people

    for i = 1:num_people
        users = [users, User(i, TX_db)];
    end

    % TODO: Replace with random movement function
    for (i = 1:timesteps)
        users(1) = users(1).addCoordinate(i, i); % Bottom left -> top right
        users(2) = users(2).addCoordinate(size-i, i); % Bottom right -> top left
        users(3) = users(3).addCoordinate(i, size-i); % Top left -> bottom right
        users(4) = users(4).addCoordinate(size-i, size-i); % Top right -> bottom left
    end
end