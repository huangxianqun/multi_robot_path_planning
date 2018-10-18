function [ robot, path_table ] = initial_robot_state( robot, path_table, Robot_num, map)


%初始化机器人位置和路径数组
    robot(1).position = 1;
    robot(1).task = [];
    robot(1).path = [1, 0];

    robot(2).position = 25;
    robot(2).task = [];
    robot(2).path = [25, 0];

    robot(3).position = 30;
    robot(3).task = [];
    robot(3).path = [30, 0];

    robot(4).position = 32;
    robot(4).task = [];
    robot(4).path = [32, 0];

    robot(5).position = 21;
    robot(5).task = [];
    robot(5).path = [21, 0];
% 
%     robot(6).position = 53;
%     robot(6).task = [];
%     robot(6).path = [53, 0];
% 
%     robot(7).position = 67;
%     robot(7).task = [];
%     robot(7).path = [67, 0];
% 
%     robot(8).position = 38;
%     robot(8).task = [];
%     robot(8).path = [38, 0];
    
%初始化路径表
    for i=1:Robot_num
        node_exit = robot(i).position;
        for j = 1:size(map(node_exit).adj_node, 2)
            node_s = min(node_exit, map(node_exit).adj_node(j));
            node_g = max(node_exit, map(node_exit).adj_node(j));
            path_table(node_s, node_g).start_time = 0;
            path_table(node_s, node_g).goal_time = inf;
            path_table(node_s, node_g).robot = i;
        end
    end
end

