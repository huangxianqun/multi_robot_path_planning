function [exist_robot, collision_robot_index, is_dest_node] = detect_robot_state(map_color, dest_coords_mark_array, route, robot_position, dest_node)
exist_robot = false;
collision_robot_index = 0;
is_dest_node = false;
row = robot_position(1); %机器人的当前路径点，在route中的坐标
column = robot_position(2);
%判断下一点是否存在机器人
if (route(row, column+1))
    if ( ismember( map_color( route( row, column+1 ) ), [17:26]) ) 
        exist_robot = true;
    else
        exist_robot = false;
    end
else
    exist_robot = false;
end

%判断下一路径点上的机器人是哪个机器人
if (exist_robot)
    collision_robot_index = map_color(route(row, column+1)) -16;
else
    collision_robot_index = 0;
end
%判断障碍物机器人是否在终点
if (collision_robot_index)
    disp(collision_robot_index);
    if route(row, column+1)==dest_node(collision_robot_index)
        is_dest_node = true;
    else
        is_dest_node = false;
    end
else
    is_dest_node = false;
end