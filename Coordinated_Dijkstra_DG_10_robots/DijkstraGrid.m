function [dest_node_1,route,numExpanded] = DijkstraGrid (input_map, start_coords, dest_coords_mark,weight)
% Run Dijkstra's algorithm on a grid.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%   the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%   respectively, the first entry is the row and the second the column.
% Output :
%    route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route. This is a single dimensional vector
%    numExpanded: Remember to also return the total number of nodes
%    expanded during your search. Do not count the goal node as an expanded node.


% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
    0 0 0; ...
    1 0 0; ...
    0 0 1; ...    
    0 1 0; ...
    1 1 0; ...
    0.9 0.9 0.9;  %路径1
    0.8 0.8 0.8;  %路径2
    0.7 0.7 0.7;  %路径3
    0.6 0.6 0.6;  %路径4
    0.5 0.5 0.5;  %路径5
    0.4 0.4 0.4;  %路径6
    0.3 0.3 0.3  %路径7
    0.2 0.2 0.2;  %路径8
    0.1 0.1 0.1;   %路径9
    0.05 0.05 0.05; %路径10
    1 0.75 0.8;      %机器人1
    0.86 0.08 0.24;      %机器人2
    0.5 0 0.5;      %机器人3
    0.25 0.4 0.86;      %机器人4
    0.44 0.5 0.56;      %机器人5
    0 1 1;      %机器人6
    1 0.84 0;      %机器人7
    1 0.55 0;      %机器人8
    0.74 0.56 0.56;      %机器人9
    0.12 0.56 1];     %机器人10

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = true;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_coords=dest_mark_2_dest_coords(dest_coords_mark);
for i=1:size(dest_coords,1)
dest_node(i)  = sub2ind(size(map), dest_coords(i,1),  dest_coords(i,2));
end

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distanceFromStart = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

distanceFromStart(start_node) = 0;

% keep track of number of nodes expanded 
numExpanded = 0;

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
        
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
%     if (drawMapEveryTime)
%         image(1.5, 1.5, map);
%         grid on; 
%         axis image;
%         drawnow;
%     end
   
    % Find the node with the minimum distance
    [min_dist, current] = min(distanceFromStart(:));
    
    if (ismember(current,dest_node) || isinf(min_dist))
        dest_node_1=current;
        break;
    end;
    
    % Update map
    map(current) = 3;         % mark current node as visited
    distanceFromStart(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distanceFromStart), current); 
    
   % ********************************************************************* 
    % YOUR CODE BETWEEN THESE LINES OF STARS
   
    % Visit each neighbor of the current node and update the  map,distances
    % and parent tables appropriately.

        numExpanded=numExpanded+1;
        if (weight(current,1))    %向上存在路径
            if(map(i-1,j)~=3&&map(i-1,j)~=5)   %该点既不是已经观察过的，也不是起点
                if(min_dist+1<distanceFromStart(i-1,j))    %如果从（i，j）出发距离小
                    distanceFromStart(i-1,j)=min_dist+1;   %修改权值
                    parent(i-1,j)=sub2ind(size(distanceFromStart),i,j);  %更改父节点
                    map(i-1,j)=4;                                        %加入open集合
                end
            end
        end
        
        if (weight(current,2))    %向下存在路径
            if(map(i+1,j)~=3&&map(i+1,j)~=5)   %该点既不是已经观察过的，也不是起点
                if(min_dist+1<distanceFromStart(i+1,j))    %如果从（i，j）出发距离小
                    distanceFromStart(i+1,j)=min_dist+1;   %修改权值
                    parent(i+1,j)=sub2ind(size(distanceFromStart),i,j);  %更改父节点
                    map(i+1,j)=4;                                        %加入open集合
                end
            end
        end
        
        if (weight(current,3))    %向左存在路径
            if(map(i,j-1)~=3&&map(i,j-1)~=5)   %该点既不是已经观察过的，也不是起点
                if(min_dist+1<distanceFromStart(i,j-1))    %如果从（i，j）出发距离小
                    distanceFromStart(i,j-1)=min_dist+1;   %修改权值
                    parent(i,j-1)=sub2ind(size(distanceFromStart),i,j);  %更改父节点
                    map(i,j-1)=4;                                        %加入open集合
                end
            end
        end
        
        if (weight(current,4))    %向右存在路径
            if(map(i,j+1)~=3&&map(i,j+1)~=5)   %该点既不是已经观察过的，也不是起点
                if(min_dist+1<distanceFromStart(i,j+1))    %如果从（i，j）出发距离小
                    distanceFromStart(i,j+1)=min_dist+1;   %修改权值
                    parent(i,j+1)=sub2ind(size(distanceFromStart),i,j);  %更改父节点
                    map(i,j+1)=4;                                        %加入open集合
                end
            end
        end
        
            
        
    %*********************************************************************

end

%% Construct route from start to dest by following the parent links
if (isinf(distanceFromStart(dest_node_1)))
    route = [];
else
    route = [dest_node_1];
    
    while (parent(route(1)) ~=0)
        route = [parent(route(1)), route];
    end
    
        %Snippet of code used to visualize the map and the path
%     for k = 2:length(route) - 1        
%         map(route(k)) = 7;
%         pause(0.5);
%         image(1.5, 1.5, map);
%         grid on;
%         axis image;
%     end
end

end
