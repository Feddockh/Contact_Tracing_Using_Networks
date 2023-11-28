% Hayden Feddock
% 10/20/2023

clear all;

% Set data generation parameters
space = 20;
num_people = 4;
timesteps = 10;

% Get the true (simulated) user information
users = data_generator(space, num_people, timesteps);

% Take in user input for placement of APs
% access_points = [AccessPoint(10, 10, -100)];
numPoints = input("How many access points do you want? ");
access_points = visualization(space, numPoints);

% Create a record of contacts
contacts = [];

%% Compute the potential coordinates for each user at each time step %%

% Iterate through each time step
for t = 1:timesteps

    % Keep track of all user potential coordinates using each access point
    pCoordinates = {};

    % Iterate through each user
    for userID = 1:length(users)

        % Keep track of the potential coordinates for the user
        pCoordinates1 = [];

        % Find the first access point that is in range
        apID = 1;
        while (isempty(pCoordinates1) && apID <= length(access_points))

            % Compute the potential coordinates
            pCoordinates1 = coordinateCalc(users(userID), access_points(apID), space, t);
        
            % Increment the access point ID counter
            apID = apID + 1;
        end

        % Iterate through each access point
        for i = apID:length(access_points)
    
            % Determine the potential coordinates
            pCoordinates2 = coordinateCalc(users(userID), access_points(i), space, t);

            % Remove non-overlapping coordinates from the original list
            if (~isempty(pCoordinates2))

                % Find the indicies in list 1 that has overlapping members
                % with list 2
                [~, indicesInList1] = ismember(pCoordinates1, pCoordinates2, 'rows');
                
                % Use logical indexing to keep only overlapping members
                pCoordinates1 = pCoordinates1(indicesInList1 > 0, :);
            end
        end

        % Append the pcoordinates for the user to the overall pcoordinates
        % for this timestep
        pCoordinates{userID} = pCoordinates1;

    end


    %% Identify potential collisions %%
    
    % Create an open list to keep track of already recorded colliding coordinates
    openList = [];

    % Iterate up to the last user's coordinate list
    for i = 1:(length(users)-1)

        % Record the dimensions of the coordinate array
        dims = size(pCoordinates{i});

        % Iterate through each row of the coordinate array
        for row = 1:dims(1)

            % Keep track of the users in collision with at this cell
            usersInCollision = [users(i)];

            % Keep track of the certainty to which user i might be here
            certainty = [1/dims(1)];

            % Extract the coordinate that this collision may occur at
            coordinate = pCoordinates{i}(row, :);

            % Check if this coordinate already exists in the open list
            if (isempty(openList))
                inOpenList = false;
            else
                if (ismember(coordinate, openList, 'rows'))
                    inOpenList = true;
                else
                    inOpenList = false;
                end
            end

            % Skip if this coordinate exists in the open list
            if (inOpenList)
                continue;
            end

            % Iterate the comparison coordinate list
            for j = (i+1):length(users)

                % Record the dimensions of the second coordinate array
                dims2 = size(pCoordinates{i});

                % Iterate through each row of the second coordinate array
                for row2 = 1:dims2(1)

                    % If there is a matching coordinate in the comparison
                    % list then add that user to the list of users
                    if (coordinate == pCoordinates{j}(row2, :))
                        usersInCollision = [usersInCollision, users(j)];
                        certainty = [certainty, 1/dims2(1)];
                        break;
                    end
                end
            end

            % If there was a collision, then add to the open list and make
            % a contact point
            if (length(usersInCollision) > 1)
                display(coordinate);
                contacts = [contacts, ContactPoint(usersInCollision, coordinate, certainty, t)];
                openList = [openList; coordinate];
            end
        end
    end
end


%% Compute the the contact likelihood for a user %%

% Retrieve input to select which user to trace
% TODO: Add input checking
trace_userID = input('Please enter a user: ');

% Format output data as an array of percentages coresponding to the 
% likelihood that the user was in contact with the traced user
perContact = zeros(1, num_people);

% Iterate through the length of the contact list
for i = 1:length(contacts)

    % Extract the list of the users in contact at the point
    contactedUsers = contacts(i).getUsers();
    
    % Check to see if the traced user is in the collision
    for j = 1:length(contactedUsers)
        if (trace_userID == contactedUsers(j).getID())

            % Retrieve the certainties that the user is at that location
            certainties = contacts(i).getCertainty();

            % If the traced user is in the collision, then add the collision
            % confidences to the overall contact percentage for the remaining users
            for k = 1:length(contactedUsers)
    
                % Skip over the traced user
                if (j ~= k)

                    % Get the ID of the current user
                    userID = contactedUsers(k).getID();

                    % Compute the certainty of contact by multiplying the
                    % certainties that either of the users are at that coordinate
                    certainty = certainties(j) * certainties(k);

                    % Add the certainty of this contact to the overall certainty
                    perContact(userID) = perContact(userID) + certainty/timesteps;
                end
            end
        end

        % Jump out of for loop
        break;

    end
end

display(perContact);


