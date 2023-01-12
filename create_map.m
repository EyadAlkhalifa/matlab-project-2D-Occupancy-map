function [map, x_start, y_start, x_target, y_target] = create_map(x_map, y_map)
%% Define binary occupancy map

%% Create a map of x*y meters with a resolution of 1 cell per meter.

map = binaryOccupancyMap(x_map, y_map, 1); 

%% Define walls

walls = occupancyMatrix(map); % or: walls = zeros(x_map,y_map);
walls(1:3,:) = 1; % Top wall
walls(end-2:end,:) = 1; % Bottom wall
walls(:,1:3) = 1; % Left wall
walls(:,end-2:end) = 1; % Right wall

%% Add walls (shelves) inside the map
spacing = 20; % define spacing between shelves
num_shelves = x_map/spacing; % calculate number of shelves
for i = 1:num_shelves
    walls(10:y_map-10, i*spacing-2:i*spacing+2) = 1;
end


%% Add obstacles using walls function
spacing = 10; % define spacing between obstacles
num_obstacles = x_map/spacing; % calculate number of obstacles
for i = 1:2:num_obstacles
    walls(i*spacing-2:i*spacing+2, i*spacing-2:i*spacing+2) = 1;
end

%% Assign Array to Occupancy Values
setOccupancy(map,[1 1],walls,"grid");

%% Display the map
figure; % create a new figure window
map_matrix = occupancyMatrix(map); % Convert the map to a matrix
%imagesc(map_matrix); % plot the map using the imagesc function

map_matrix_flipped = flipud(map_matrix);
imagesc(map_matrix_flipped);

colormap(flipud([0 0 1; 1 1 1])); % use a blue-to-white colormap
axis equal; % set the axis to be equal
title('occupancy map'); % add a title to the plot
xlabel('X (meters)'); % add an x-axis label
ylabel('Y (meters)'); % add a y-axis label
axis([0 x_map 0 y_map]); % set the axis limits
axis("xy")
grid minor


%% Allow the user to select the start and target points interactively

% Define the map limits as a polygon
map_limits_x = [0 x_map x_map 0 0];
map_limits_y = [0 0 y_map y_map 0];

while true
    % Allow the user to select the start point interactively
    disp('Select the start point by clicking on the map')
    [x_start, y_start] = ginput(1);
    if ~inpolygon(x_start, y_start, map_limits_x, map_limits_y) % Check if the start point is inside the map limits
        disp("Error: The start point is outside the map limits. Please select a different location inside the boundaries of the map.")
    elseif (isOccupied(map, x_start-1, y_start) || isOccupied(map, x_start+1, y_start) ...
            || isOccupied(map, x_start, y_start-1) || isOccupied(map, x_start, y_start+1)) % Check if the start point is closer than one cell to any obstacles
        disp("Error: The start point is too close to an obstacle. Please select a different location farther away from obstacles.")
    else
        break
    end
end

hold on
plot(x_start, y_start, 'go', 'MarkerSize', 5, 'LineWidth', 2) % Plot start point on top of the map
text(x_start, y_start, 'Start', 'Color', 'g', 'FontSize', 11,'FontWeight','bold','Position',[x_start-7 y_start-3 0]) % Add name to the start point
fprintf('(x_start, y_start) = (%.1f, %.1f)\n\n', x_start, y_start)


while true
    % Allow the user to select the target point interactively
    disp('Select the target point by clicking on the map')
    [x_target, y_target] = ginput(1);
    if ~inpolygon(x_target, y_target, map_limits_x, map_limits_y) % Check if the target point is inside the map limits
        disp("Error: The target point is outside the map limits. Please select a different location inside the boundaries of the map.")
    elseif (isOccupied(map, x_target-1, y_target) || isOccupied(map, x_target+1, y_target) ...
            || isOccupied(map, x_target, y_target-1) || isOccupied(map, x_target, y_target+1)) % Check if the target point is closer than one cell to any obstacles
        disp("Error: The target point is too close to an obstacle. Please select a different location farther away from obstacles.")
    else
        break
    end
end

plot(x_target, y_target, 'ro', 'MarkerSize', 5, 'LineWidth', 2) % Plot target point on top of the map
text(x_target, y_target, 'Target', 'Color', 'r', 'FontSize', 11,'FontWeight','bold','Position',[x_target y_target-3 0]) % Add name to the target point
fprintf('(x_target, y_target) = (%.1f, %.1f)\n\n', x_target, y_target)