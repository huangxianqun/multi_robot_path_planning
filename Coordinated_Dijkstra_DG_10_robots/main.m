%define a map
close all ; clear all ;
map = false(14) ;
map(3,3:4) = true ; map(3,7:8) = true ; map(3,11:12) = true ;
map(4,3:4) = true ; map(4,7:8) = true ; map(4,11:12) = true ;
map(7,3:4) = true ; map(7,7:8) = true ; map(7,11:12) = true ;
map(8,3:4) = true ; map(8,7:8) = true ; map(8,11:12) = true ;
map(11,3:4) = true ; map(11,7:8) = true ; map(11,11:12) = true ;
map(12,3:4) = true ; map(12,7:8) = true ; map(12,11:12) = true ;
%define the weight of node 
weight = [0 1 0 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 0 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 0 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 0 0; 0 0 0 1;%第一列
                0 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0 ;1 0 1 0 ; 1 0 0 1; %第二列
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%第三列
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%第四列
                0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 0 0 1;%第五列 
                0 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1;%第六列
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%第七列
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%第八列
                0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 0 0 1;%第九列 
                0 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1;%第十列
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%第十一列
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%第十二列
                0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 0 0 1;%第十三列
                0 0 1 0; 1 0 0 0; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 0; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 0; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 0;%第十四列
                ] ;
 %start point array and destination point array
start_coords_array = [6,2;   1,1;     5,9;    9,14;    5,8;    12,10;    14,7;   3,14;   1,9;   14,10  ];
dest_coords_mark_array =[9 3 2 8 3 1 3 4 5 3];
FLAG = zeros(1, 10);
[map_color, route, dest_node] = multi_path_generation( start_coords_array,  dest_coords_mark_array, map, weight);
%初始化机器人开始的位置并且显示出来
for j = 1:10
    robot_color = 16+j;
    map_color(route(j, 1)) = robot_color;
end
    image(1.5, 1.5, map_color);
    grid on;
    axis image;
    pause(0.5);
for i = 1:100
    for j = 1:10
    robot_color = 16+j;
    if (route(j, i+1))  %如果未达到终点
        [exist_robot, collision_robot_index, is_dest_node] = detect_robot_state(map_color, dest_coords_mark_array, route, [j, i], dest_node);
        if (~exist_robot)  %如果路径可行，则直接移动到下一个路径点
            map_color(route(j, i+1)) = robot_color;
            map_color(route(j, i)) = 1;
        else                     %否则路径上存在机器人
            if (is_dest_node) %如果机器人在终点，则进行“绕桌”行为
                %障碍物机器人绕桌
               [route, dest_node] = desk_surround(map, route, collision_robot_index, j, i, dest_node, dest_coords_mark_array);
                %当前机器人等待
                [nrows, ncols] = size(route);
                route(j, 1:ncols+1) = add_path_point(route(j, :), route(j, i),i+1);
                map_color(route(j, i+1)) = robot_color;
            else                 %如果障碍物不在终点，当前机器人等待即可
                %当前机器人等待
                [nrows, ncols] = size(route);
                route(j, 1:ncols+1) = add_path_point(route(j, :), route(j, i),i+1);
                map_color(route(j, i+1)) = robot_color;
            end
        end
    else %如果已经达到终点,原地等待，并且添加一个FLAG
        [nrows, ncols] = size(route);
        route(j, 1:ncols+1) = add_path_point(route(j, :), route(j, i),i+1);
        map_color(route(j, i+1)) = robot_color;
        FLAG(j) = 1;
    end
    %显示过程
    image(1.5, 1.5, map_color);
    grid on;
    axis image;
    pause(0.01);
   
    %终止条件
    if FLAG == ones(1, 10)
        disp(route');
        success = true;
        [row, col] = size(route);
        for n = 1:col
            if route(:, n) ==zeros(10,1)
                break;
            end
            for m = 1:row
                if route(m,n)
                    route_final(m, n)= route(m, n);
                else
                    route_final(m, n) = route_final(m, n-1);
                end
            end
        end
        disp(route_final);
        route_final = route_final';
        fid = fopen('path_point.txt', 'wt');
        [row, col] = size(route_final);
        disp(row);
        for m = 1:row
            for n = 1:col
                if route_final(m, n)
                    fprintf(fid, '%g\t', route_final(m,n));
                end
            end
            fprintf(fid, '\n');
        end
        return;
    end
    [nrows, ncols] = size(route);
    if (ncols > 500)
        success = false;
        disp('FAILED..........................!');
        return;
    end
    end
end 


% cmap = [1 1 1; ...
%     0 0 0; ...
%     1 0 0; ...
%     0 0 1; ...    
%     0 1 0; ...
%     1 1 0; ...
%     0.9 0.9 0.9;  %路径1
%     0.8 0.8 0.8;  %路径2
%     0.7 0.7 0.7;  %路径3
%     0.6 0.6 0.6;  %路径4
%     0.5 0.5 0.5;  %路径5
%     0.4 0.4 0.4;  %路径6
%     0.3 0.3 0.3; %路径7
%     0.2 0.2 0.2;  %路径8
%     0.1 0.1 0.1;   %路径9
%     0.05 0.05 0.05; %路径10
%     1 0.75 0.8;      %机器人1
%     0.86 0.08 0.24;      %机器人2
%     0.5 0 0.5;      %机器人3
%     0.25 0.4 0.86;      %机器人4
%     0.44 0.5 0.56;      %机器人5
%     0 1 1;      %机器人6
%     1 0.84 0;      %机器人7
%     1 0.55 0;      %机器人8
%     0.74 0.56 0.56;      %机器人9
%     0.12 0.56 1];     %机器人10
% colormap(cmap);

% for i = 1:9
%     dest_coords = dest_mark_2_dest_coords(i);
%     for j = 1: length(dest_coords)
%         map(dest_coords(j,1) , dest_coords(j,2)) = i+1;
% 
%     end
%     
% end
% image(1.5, 1.5, map);
% grid on;
% axis image;
% disp(map)