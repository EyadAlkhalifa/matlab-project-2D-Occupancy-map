
function occupied = isOccupied(map, x, y)
    % Check if the point (x,y) is occupied in the map
    occupied = getOccupancy(map,[x y]) == 1;
end


