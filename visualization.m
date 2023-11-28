clear
clc

% Generate the X and Y grid arrays using the MESHGRID function.
r = zeros(50); % r will represent the input matrix. Current state is for demo purposes.

% Integers for item representation
person = 1;
accessPoint = 2;
rangeRadius = 3;

sensitivity = -50;

blue = 0.1

% Define colormap for different objects
colormap([1 1 1; 1 0 0; 0 1 0; 0 0 blue]); % Black, Red, Green, Blue

AccessPoints = [];
% also show users
Users = [];

imagesc(r);
axis xy;

% Update the plot in a loop
for i = 1:100
    % Generate new data (replace this with your data update logic)
    newData = rand(10, 10);
    
    % Update the image data
    [x,y] = ginput(1)
    blue = blue + 0.1;
    x = round(x)
    y = round(y)

    obj = AccessPoint(x, y, sensitivity);
    AccessPoints{end+1} = obj
    
    r(y, x) = accessPoint;
    
    
    
    % Force the figure to update
    imagesc(r);
    axis xy;
end