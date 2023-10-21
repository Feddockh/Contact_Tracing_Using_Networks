% Hayden Feddock
% 10/20/2023

% Pull in data from generator
size = 20;
num_people = 4;
time = 10;
user_positions = data_generator(size, num_people, time);

% Take in user input for placement of APs
ap1 = AccessPoint(10, 10, -50);


for t = 1:1

    % Get a list of the user's info at time t
    users = [];
    for x = 1:size
        for y = 1:size
            if (user_positions(x, y, t) > 0)
                id = user_positions(x, y, t);
                users = [users, User(id, x, y, 50)];
            end
        end
    end

    % Compute the rx power from each user (move later)
    RX_db = zeros(num_people);
    for n = 1:num_people
        a = [ap1.getX(), ap1.getY()];
        b = [users(n).getX(), users(n).getY()];
        path_loss = compute_loss(a, b, (2.4*10^9), 2);
        RX_db(n) = users(n).getTX() - path_loss;
    end

    % Check if people are near each other
    distances = [];
    for n = 1:num_people
        path_loss = users(n).getTX() - RX_db(n);
        d = compute_distance((2.4*10^9), 2, path_loss);
        distances = [distances, d];
    end

    % Contact list
    contacts = []
    for i = 1:num_people
        for j = i:num_people
            if (abs(distances(i) - distances(j)) < 1)
                contacts = 



end

% Compute the path loss between the users and the APs

% If the path loss is less than the 