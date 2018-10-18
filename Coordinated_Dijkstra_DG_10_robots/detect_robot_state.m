function [exist_robot, collision_robot_index, is_dest_node] = detect_robot_state(map_color, dest_coords_mark_array, route, robot_position, dest_node)
exist_robot = false;
collision_robot_index = 0;
is_dest_node = false;
row = robot_position(1); %�����˵ĵ�ǰ·���㣬��route�е�����
column = robot_position(2);
%�ж���һ���Ƿ���ڻ�����
if (route(row, column+1))
    if ( ismember( map_color( route( row, column+1 ) ), [17:26]) ) 
        exist_robot = true;
    else
        exist_robot = false;
    end
else
    exist_robot = false;
end

%�ж���һ·�����ϵĻ��������ĸ�������
if (exist_robot)
    collision_robot_index = map_color(route(row, column+1)) -16;
else
    collision_robot_index = 0;
end
%�ж��ϰ���������Ƿ����յ�
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