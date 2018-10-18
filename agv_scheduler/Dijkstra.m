function [ res ] = Dijkstra( point_start, point_goal, map )
%ASTAR 此处显示有关此函数的摘要
%   此处显示详细说明
%% 输入地图
vertics = map;
%% 初始化
map_size = size(vertics, 1);               %地图节点个数
vertics_cost = inf(map_size, 1);           %节点耗费值
vertics_parent = zeros(map_size, 1);       %节点的父节点
vertics_visit = false(map_size, 1);        %节点是否查看过

start = point_start;                       %起始点
goal = point_goal;                         %目标点

vertics_cost(start) = 0;                   %先将起始点加入open_list(修改权值从无穷大到有限值)
vertics_parent(start) = 0;                 %起始点无父节点
%% 循环体开始
while (true)
    [min_cost, current_vertics] = min(vertics_cost(:));   %选出open_list中cost值最小的节点
    if(current_vertics == goal || isinf(min_cost) )
        break;
    end
    vertics_cost(current_vertics) = inf;                   %将当前节点加入close_list
    vertics_visit(current_vertics) = true;
    %遍历当前点的相邻节点
    for i = 1:size(vertics(current_vertics).adj_node, 2)
        temp_vertics = vertics(current_vertics).adj_node(i);
        temp_cost = vertics(current_vertics).adj_weight(i);
        if(vertics_visit(temp_vertics) == false)           %该节点不在close_list中
            if(vertics_cost(temp_vertics) > min_cost + temp_cost)
                vertics_cost(temp_vertics) =  min_cost + temp_cost;
                vertics_parent(temp_vertics) = current_vertics;
            end
        end
    end
end

%% 输出路径
if(isinf(vertics_cost(goal)))
    route = [];
else
    route=[goal];
    while(vertics_parent(route(1)) ~= 0)
        route = [vertics_parent(route(1)), route];
    end
end

 res = route;%输出规划路径
end

