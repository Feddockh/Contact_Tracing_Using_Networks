classdef AccessPointPlacementApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure           matlab.ui.Figure
        GridLayout         matlab.ui.container.GridLayout
        UIAxes             matlab.ui.control.UIAxes
        PlaceButton        matlab.ui.control.Button
        CoordinatesLabel   matlab.ui.control.Label
        AccessPoints       cell = {} % Initialize with an empty matrix for access points
    end


    % Callbacks that handle component events
    methods (Access = public)

        % Button pushed function: PlaceButton
        function PlaceButtonPushed(app, ~)
            % Allow user to click on the UIAxes to place access points

            % Get user input
            [x, y] = ginput(1);
            sensitivity=0;
            obj=AccessPoint(x,y,sensitivity);

            % Update access points matrix
            app.AccessPoints{end+1} = obj;
            %plot(app.UIAxes, x, y, 'ro', 'MarkerSize', 10);
            %plot3(app.UIAxes, x, y, z, 'ro', 'MarkerSize', 10);
            disp('here')
            % Update the coordinates label
            app.CoordinatesLabel.Text = sprintf('Coordinates: %.2f, %.2f ,%.2f', x, y ,sensitivity);
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = AccessPointPlacementApp

            % Create and configure components
            createComponents(app)

            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

% Display access point locations when closing the app
    methods (Access = private)
        function UIFigureCloseRequest(app, ~)   

            disp(app.AccessPoints);
            for i = 1:length(app.AccessPoints)
                currentAccessPoint = app.AccessPoints{i};
                x=getX(currentAccessPoint);
                y=getY(currentAccessPoint);
                sensitivity=getSensitivity(currentAccessPoint);

                fprintf('Access Point %d: X = %d, Y = %d, Sensitivity = %d\n', i, x,y,sensitivity);
            end
            
            delete(app.UIFigure);
        end
    end


    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100, 100, 640, 480];
            app.UIFigure.Name = 'Access Point Placement';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, '3D Grid');
            xlabel(app.UIAxes, 'X');
            ylabel(app.UIAxes, 'Y');
            zlabel(app.UIAxes, 'Z');
            app.UIAxes.DataAspectRatio = [1, 1, 1];
            app.UIAxes.XLim = [-10, 10];
            app.UIAxes.YLim = [-10, 10];
            app.UIAxes.ZLim = [-10, 10];
            app.UIAxes.Box = 'on';
            app.UIAxes.CameraViewAngle = 11;
            app.UIAxes.CameraTarget = [0, 0, 0];
            app.UIAxes.CameraUpVector = [0, 0, 1];
            app.UIAxes.Position = [1, 1, 480, 480];

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {'1x'};
            app.GridLayout.RowHeight = {'1x', 'fit'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;

            % Create PlaceButton
            app.PlaceButton = uibutton(app.GridLayout, 'push');
            app.PlaceButton.ButtonPushedFcn = createCallbackFcn(app, @PlaceButtonPushed, true);
            app.PlaceButton.Layout.Row = 1; % Fix: Set Layout.Row instead of GridLayout.Position
            app.PlaceButton.Layout.Column = 1;

            % Create CoordinatesLabel
            app.CoordinatesLabel = uilabel(app.GridLayout);
            app.CoordinatesLabel.Layout.Row = 2;
            app.CoordinatesLabel.Layout.Column = 1;
            app.CoordinatesLabel.Text = 'Coordinates:';

            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Show the figure after all components are created
            
            app.UIFigure.Visible = 'on';

        end
    end
end



