function [route, dest_node] = desk_surround(map, route, collision_robot_index, row, column, dest_node, dest_coords_mark_array)

%获取绕桌的路径
%获取在障碍物在终点坐标数组中的位置。
collision_object_coords =  route(row, column+1);
dest_node_array = dest_mark_2_dest_coords(dest_coords_mark_array(collision_robot_index));
for index = 1:size(dest_node_array, 1)
    if (collision_object_coords == sub2ind(size(map), dest_node_array(index, 1), dest_node_array(index, 2))   )
        dest_node_old_index = index;
        break;
    else
        dest_node_old_index = 0;
    end
end
disp(dest_node_old_index);
for i = 1:1
    if (dest_node_old_index + i <=12)
        route_surround(i) =  sub2ind(size(map), dest_node_array(dest_node_old_index + i, 1), dest_node_array(dest_node_old_index + i, 2) );
    else
        route_surround(i) =  sub2ind(size(map), dest_node_array(dest_node_old_index + i-12, 1), dest_node_array(dest_node_old_index + i-12, 2) );
    end
end
dest_node(collision_robot_index) = route_surround(1); 
%将路径与之前的路径合并

if route(collision_robot_index, column+1)
    for k=1:size(route_surround, 2)
        route(collision_robot_index, column+k+1) = route_surround(k);
    end
else
    for k=1:size(route_surround, 2)
        route(collision_robot_index, column+k) = route_surround(k);
    end
end
end