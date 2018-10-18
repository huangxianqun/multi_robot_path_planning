function [path_table] = exit_stop_state(path_table, robot, current_robot, map)

global acc_coef;
global global_time;

node_exit = robot(current_robot).position;
for i = 1:size(map(node_exit).adj_node, 2)
    node_s = min(node_exit, map(node_exit).adj_node(i));
    node_g = max(node_exit, map(node_exit).adj_node(i));
    temp_occupied_robot_len = size(path_table(node_s, node_g).robot, 2);
    for j = 1:temp_occupied_robot_len
        if(path_table(node_s, node_g).robot(j)==current_robot && path_table(node_s, node_g).goal_time(j) == inf)
            path_table(node_s, node_g).goal_time(j) =  ceil(global_time/acc_coef + 10);
        end
    end
end

end