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
    else if (testcase == 2)
        for (i = 1:timesteps)
            if i <= size/2
                users(1) = users(1).addCoordinate(i, 1); %  top left -> top minddle
                users(2) = users(2).addCoordinate(1, size-i); % Bottom left -> left middle
                users(3) = users(3).addCoordinate(size-i, size); %  bottom right ->bottle middle
                users(4) = users(4).addCoordinate(size, i); % top right -> right middle
            else
                users(1) = users(1).addCoordinate(size/2, i-(size/2)+1); % top middle -> centre
                users(2) = users(2).addCoordinate(i-(size/2)+1, size/2); % left middle -> centre
                users(3) = users(3).addCoordinate(size/2, size-(i-(size/2))); % bottom middle -> centre
                users(4) = users(4).addCoordinate(size-(i-(size/2)), size/2); % right middle -> centre
            end
        end
    end
end