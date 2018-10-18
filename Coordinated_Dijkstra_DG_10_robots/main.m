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
weight = [0 1 0 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 0 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 0 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 0 0; 0 0 0 1;%��һ��
                0 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0 ;1 0 1 0 ; 1 0 0 1; %�ڶ���
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%������
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%������
                0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 0 0 1;%������ 
                0 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1;%������
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%������
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%�ڰ���
                0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 0 0 1;%�ھ��� 
                0 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 1;%��ʮ��
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%��ʮһ��
                0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 1;%��ʮ����
                0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1; 0 1 0 0; 0 1 0 0; 0 1 1 0; 0 0 0 1;%��ʮ����
                0 0 1 0; 1 0 0 0; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 0; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 0; 1 0 0 0; 1 0 0 0; 1 0 1 0; 1 0 0 0;%��ʮ����
                ] ;
 %start point array and destination point array
start_coords_array = [6,2;   1,1;     5,9;    9,14;    5,8;    12,10;    14,7;   3,14;   1,9;   14,10  ];
dest_coords_mark_array =[9 3 2 8 3 1 3 4 5 3];
FLAG = zeros(1, 10);
[map_color, route, dest_node] = multi_path_generation( start_coords_array,  dest_coords_mark_array, map, weight);
%��ʼ�������˿�ʼ��λ�ò�����ʾ����
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
    if (route(j, i+1))  %���δ�ﵽ�յ�
        [exist_robot, collision_robot_index, is_dest_node] = detect_robot_state(map_color, dest_coords_mark_array, route, [j, i], dest_node);
        if (~exist_robot)  %���·�����У���ֱ���ƶ�����һ��·����
            map_color(route(j, i+1)) = robot_color;
            map_color(route(j, i)) = 1;
        else                     %����·���ϴ��ڻ�����
            if (is_dest_node) %������������յ㣬����С���������Ϊ
                %�ϰ������������
               [route, dest_node] = desk_surround(map, route, collision_robot_index, j, i, dest_node, dest_coords_mark_array);
                %��ǰ�����˵ȴ�
                [nrows, ncols] = size(route);
                route(j, 1:ncols+1) = add_path_point(route(j, :), route(j, i),i+1);
                map_color(route(j, i+1)) = robot_color;
            else                 %����ϰ��ﲻ���յ㣬��ǰ�����˵ȴ�����
                %��ǰ�����˵ȴ�
                [nrows, ncols] = size(route);
                route(j, 1:ncols+1) = add_path_point(route(j, :), route(j, i),i+1);
                map_color(route(j, i+1)) = robot_color;
            end
        end
    else %����Ѿ��ﵽ�յ�,ԭ�صȴ����������һ��FLAG
        [nrows, ncols] = size(route);
        route(j, 1:ncols+1) = add_path_point(route(j, :), route(j, i),i+1);
        map_color(route(j, i+1)) = robot_color;
        FLAG(j) = 1;
    end
    %��ʾ����
    image(1.5, 1.5, map_color);
    grid on;
    axis image;
    pause(0.01);
   
    %��ֹ����
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
%     0.9 0.9 0.9;  %·��1
%     0.8 0.8 0.8;  %·��2
%     0.7 0.7 0.7;  %·��3
%     0.6 0.6 0.6;  %·��4
%     0.5 0.5 0.5;  %·��5
%     0.4 0.4 0.4;  %·��6
%     0.3 0.3 0.3; %·��7
%     0.2 0.2 0.2;  %·��8
%     0.1 0.1 0.1;   %·��9
%     0.05 0.05 0.05; %·��10
%     1 0.75 0.8;      %������1
%     0.86 0.08 0.24;      %������2
%     0.5 0 0.5;      %������3
%     0.25 0.4 0.86;      %������4
%     0.44 0.5 0.56;      %������5
%     0 1 1;      %������6
%     1 0.84 0;      %������7
%     1 0.55 0;      %������8
%     0.74 0.56 0.56;      %������9
%     0.12 0.56 1];     %������10
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