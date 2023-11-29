function [users] = data_generator(size, num_people, timesteps, testcase)

    users = [];
    TX_db = 0; % Predetermined value
    num_people = 4;

    for i = 1:num_people
        users = [users, User(i, TX_db)];
    end

    %% TESTCASE 1 %%
    if (testcase == 1)
        for (i = 1:timesteps)
            users(1) = users(1).addCoordinate(i, i); % Bottom left -> top right
            users(2) = users(2).addCoordinate(size-i, i); % Bottom right -> top left
            users(3) = users(3).addCoordinate(i, size-i); % Top left -> bottom right
            users(4) = users(4).addCoordinate(size-i, size-i); % Top right -> bottom left
        end

    %% TESTCASE 2 %%
    elseif (testcase == 2)
        for (i = 1:timesteps)
            users(1) = users(1).addCoordinate(i, round(0.5*i)); % Bottom left -> top right
            users(2) = users(2).addCoordinate(size - i, round(0.5*i));
            users(3) = users(3).addCoordinate(i, size-i); % Top left -> bottom right
            users(4) = users(4).addCoordinate(size-i, size-i); % Top right -> bottom left
        end
    elseif (testcase == 3)
        for (i = 1:timesteps)
            users(1) = users(1).addCoordinate(i, round(0.8*i)); % Bottom left -> top right
            users(2) = users(2).addCoordinate(size - i, i);
            users(3) = users(3).addCoordinate(i, round(0.3*(size-i))); % Top left -> bottom right
            users(4) = users(4).addCoordinate(size-i, size-i); % Top right -> bottom left
        end
    end
end