close all; clear all;
%initial the map size
size_x = 10;
size_y = 10;
size_t = 100;
%1 - white - clear cell
%2 - black - obstacle
%3 - Grayish blue   - robot 1
%4 - Reddish blue - robot 2
%5 - purple - robot 3
%6 - vivid green - robot 4
%7 - Plum red - robot 5
cmap = [1 1 1;
              0 0 0;
              0.69 0.87 0.90;
              0.25 0.41 0.88;
              0.63 0.13 0.94;
              0 1 0.5;
              0.87 0.63 0.87;
              ];
colormap(cmap);
%initial the space_time_map and reservation table
space_map = ones(size_x, size_y);
space_time_map = ones(size_x, size_y, size_t);
reservation_table = zeros(size_x, size_y, size_t);
%add the static obstacle
space_time_map(1:5, 5, :) = 2*ones(5,1, size_t);
reservation_table(1:5, 5, :) = 2*ones(5,1, size_t);
%the start point array and end point array
start_points= [2 4; 5 1; 1 1; 9 6;7 3 ];
end_points = [8 7; 10 10; 7 3; 3 2; 1 1];
len_route_max = 0;
route_all = [];
for index = 1:5
%initial the start point and the end point
route = [];
start_coords =start_points(index, :);
disp(start_coords);
end_coords = end_points(index, :);
disp(end_coords);
[route] = Time_Astar_For_Cooperative_Path_Finding(start_coords, end_coords, space_time_map, reservation_table);
route_all(index, 1:length(route)) =route; 
disp(route);
    if (length(route) >len_route_max)
        len_route_max = length(route);
    end
    for i = 1:size(route, 2)
        reservation_table(route(i)) =index+2;
    end

end

%show  the moving process
for i = 1:len_route_max
        show_map = ones(size_x, size_y);
        show_map(1:5, 5) = 2*ones(5,1);
       for j = 1:5
            if (route_all(j, i))
                [x, y, t] = ind2sub(size(space_time_map), route_all(j, i));
                show_map(x, y) = j+2;
            else
                route_all(j, i) = route_all(j, i-1);
                [x, y, t] = ind2sub(size(space_time_map), route_all(j, i));
                show_map(x, y) = j+2;
             end
        end
       image(1.5, 1.5, show_map)
       grid on;
       axis image;
       drawnow;
       pause(2);

end



