%1 - white - clear cell
%2 - black - obstacle
%3 - red - visited
%4 - blue - on list
%5 - green - start
%6 - yellow - destination
cmap = [1 1 1;
        0 0 0;
        1 0 0;
        0 0 1;
        0 1 0;
        1 1 0;
        0.5 0.5 0.5];
    colormap(cmap);
    space_time_map = ones(10, 10, 100);
    space_map = ones(10, 10);
    
    [nrows, ncols] = size(space_map);
   start_coords = [5, 3];
   dest_coords = [10, 5];
   %construct the graph
   space_time_map(start_coords(1), start_coords(2), :) = 5;
   space_time_map(dest_coords(1), dest_coords(2), :) = 6;
   for t=1:100
       tt = rem(t, 10);
       switch tt
            case 0
                space_time_map(4, 1:5, t) = 2*ones(1,5);
                space_time_map(7, 6:10, t) = 2*ones(1,5);
           case 1
               space_time_map(4, 2:6, t) = 2*ones(1,5);
                space_time_map(7, 5:9, t) = 2*ones(1,5);
            case 2
               space_time_map(4, 3:7, t) = 2*ones(1,5);
                space_time_map(7, 4:8, t) = 2*ones(1,5);
            case 3
               space_time_map(4, 4:8, t) = 2*ones(1,5);
                space_time_map(7, 3:7, t) = 2*ones(1,5);
            case 4
               space_time_map(4, 5:9, t) = 2*ones(1,5);
                space_time_map(7, 2:6, t) = 2*ones(1,5);
            case 5
               space_time_map(4, 6:10, t) = 2*ones(1,5);
                space_time_map(7, 1:5, t) = 2*ones(1,5);
            case 6
               space_time_map(4, 5:9, t) = 2*ones(1,5);
                space_time_map(7, 2:6, t) = 2*ones(1,5);
            case 7
               space_time_map(4, 4:8, t) = 2*ones(1,5);
                space_time_map(7, 3:7, t) = 2*ones(1,5);
            case 8
               space_time_map(4, 3:7, t) = 2*ones(1,5);
                space_time_map(7, 4:8, t) = 2*ones(1,5);
            case 9
               space_time_map(4, 2:6, t) = 2*ones(1,5);
                space_time_map(7, 5:9, t) = 2*ones(1,5);
                
       end
        
   end
   
  %initial parent array, and H 
   parent = zeros(10, 10, 100);
   [X, Y] = meshgrid(1:ncols, 1:nrows);
   xd = dest_coords(1);
   yd = dest_coords(2);
   H =abs(X-xd) + abs(Y-yd);
   H = H';
   %initial cost arrays
   g = inf(10, 10, 100);
   f = inf(10, 10, 100);
   g(start_coords(1), start_coords(2), 1) = 0;
   f(start_coords(1), start_coords(2), 1) = H(start_coords(1), start_coords(2));

   end_time = 1;
   while true

       %find the node with the minimum f values
       [min_f, current] = min(f(:));
       [current_x, current_y, current_t] = ind2sub(size(space_time_map), current);
       if((current_x == dest_coords(1) && current_y == dest_coords(2)) || isinf(min_f))
           end_time = current_t;
           break;
       end
       %add it to close list
       space_time_map(current) = 3;
       f(current) = Inf;
       %compute row, column, layer
       [i, j, k] = ind2sub(size(space_time_map), current);
       neighbours = [i-1, j, k+1;
                     i+1, j, k+1;
                     i, j-1, k+1;
                     i, j+1, k+1;
                     i, j, k+1];
       for index = 1:size(neighbours, 1)
           px = neighbours(index, 1);
           py = neighbours(index, 2);
           pt = neighbours(index, 3);
           if (px > 0 && px < 11 && py > 0 && py < 11  )
               sub_neighbours = sub2ind(size(space_time_map), px, py, pt);
               if (space_time_map(sub_neighbours) ~= 2 && space_time_map(sub_neighbours) ~= 5 && space_time_map(sub_neighbours) ~= 3)
                   if(g(current) + H(px, py) < f(sub_neighbours) )
                       if (px ==i && py ==j)
                           g(sub_neighbours) = g(current) + 0.5;
                       else
                           g(sub_neighbours) = g(current) + 1;
                       end
                       f(sub_neighbours) = g(sub_neighbours) +  H(px, py);
                       parent(sub_neighbours) = current;
                       space_time_map(sub_neighbours) = 4;
                   end
               end
           end
       end
       
       
   end
   for h = 1:end_time-1
       image(1.5, 1.5, space_time_map(:, :, h));
       grid on;
       axis image;
       drawnow;
       pause(0.1);
   end
   
   
   %show the route
   dest_node = sub2ind(size(space_time_map), dest_coords(1), dest_coords(2), end_time);
   route = [];
   route = [dest_node];
   while (parent(route(1)) ~= 0)
       route = [parent(route(1)), route];
   end
   
   for i = 1:size(route, 2)-1
       [temp1, temp2, temp3]  = ind2sub(size(space_time_map), route(i));
       temp = [temp1, temp2, temp3];
       space_map(start_coords(1), start_coords(2)) = 5;
       space_map(dest_coords(1), dest_coords(2)) = 6;
       temp_array_1 = space_time_map(4, :, i);
       temp_array_2 = space_time_map(7, :, i);
       for j = 1:size(temp_array_1, 2)
           if temp_array_1(j) ~=2
               temp_array_1(j) =1;
           end
           if temp_array_2(j) ~=2
               temp_array_2(j) =1;
           end
           
       end
       space_map(4, :) = temp_array_1;
       space_map(7, :) = temp_array_2;
       space_map(temp1, temp2) = 7;
       image(1.5, 1.5, space_map);
       grid on;
       axis image;
       drawnow;
       pause(1);
       disp(temp);
   end

