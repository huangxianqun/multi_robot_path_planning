close all; clear all;
k_time = 0.1;
robot_pose = [ ];

start = 1;
goal = 69;
map = input_costmap();
route = Dijkstra(start, goal);
for i =1:size(route, 2)
    robot_pose = [route(i)];
    if(i < size(route, 2))
        [row, column] = find(map(route(i)).adj_node == route(i+1));
        viewer(robot_pose);
        pause(k_time * map(route(i)).adj_weight(column));
    end
    viewer(robot_pose);
end



