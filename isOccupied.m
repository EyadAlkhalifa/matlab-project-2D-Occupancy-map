%% The isOccupied function takes a binary occupancy map map and a location loc
% specified by a pair of x and y coordinates as input arguments. The function 
% first retrieves the occupancy matrix of the map using the occupancyMatrix 
% method of the map object. The occupancy matrix is a 2D array that represents
% the occupancy state of each cell in the map, where a value of 1 indicates that
% the cell is occupied and a value of 0 indicates that the cell is unoccupied.

%% Next, the function determines the occupancy state of the cell at the specified
% location loc by indexing into the occupancy matrix using the round function to
% round the x and y coordinates to the nearest integer. The function returns the 
% occupancy state of the cell as a logical value, where true indicates that the 
% cell is occupied and false indicates that the cell is unoccupied.

%% For example, if map is a binary occupancy map and loc is [10.5 20.6], 
% the function would return the occupancy state of the cell at row 11 and column
% 21 of the occupancy matrix. If this cell has a value of 1 in the occupancy matrix,
% the function would return true, and if it has a value of 0, the function would return
% false.


% function occupied = isOccupied(map, x, y)
%     occupancy_matrix = map.occupancyMatrix;
%     occupied = occupancy_matrix(ceil(x), ceil(y));
% end

% 
function occupied = isOccupied(map, x, y)
    % Check if the point (x,y) is occupied in the map
    occupied = getOccupancy(map,[x y]) == 1;
end


