function[accessPoints] = visualization(dim, numPoints)
    % Generate the X and Y grid arrays using the MESHGRID function.
    r = zeros(dim); % r will represent the input matrix. Current state is for demo purposes.
    
    sensitivity = -50;
    % Define colormap for different objects
    colormap([1 1 1; 1 0 0; 0 1 0; 0 0 1]); % Black, Red, Green, Blue
    
    accessPoints = {};
    
    imagesc(r);
    axis xy;
    
    % Update the plot in a loop
    for i = 1:numPoints
        % Update the image data
        [x,y] = ginput(1); % NOTE: Not sure how to exit the input window?
        x = round(x);
        y = round(y);
    
        obj = AccessPoint(x, y, sensitivity);
        accessPoints{end+1} = obj;
        
        r(y, x) = 3;
        
        % Force the figure to update
        imagesc(r);
        axis xy;
    end

