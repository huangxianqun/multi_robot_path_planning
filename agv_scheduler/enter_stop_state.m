function [path_table] = enter_stop_state(path_table, robot, current_robot, map)

global acc_coef;
global global_time;

node_exit = robot(current_robot).position;
for i = 1:size(map(node_exit).adj_node, 2)
    node_s = min(node_exit, map(node_exit).adj_node(i));
    node_g = max(node_exit, map(node_exit).adj_node(i));
    temp_occupied_robot_len = size(path_table(node_s, node_g).robot, 2);
    path_table(node_s, node_g).start_time = [path_table(node_s, node_g).start_time, ceil(global_time/acc_coef)];
    path_table(node_s, node_g).goal_time= [path_table(node_s, node_g).goal_time, inf];
    path_table(node_s, node_g).robot = [ path_table(node_s, node_g).robot, current_robot];
end

end