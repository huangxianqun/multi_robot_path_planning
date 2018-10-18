function [ res ] = Dijkstra( point_start, point_goal, map )
%ASTAR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%% �����ͼ
vertics = map;
%% ��ʼ��
map_size = size(vertics, 1);               %��ͼ�ڵ����
vertics_cost = inf(map_size, 1);           %�ڵ�ķ�ֵ
vertics_parent = zeros(map_size, 1);       %�ڵ�ĸ��ڵ�
vertics_visit = false(map_size, 1);        %�ڵ��Ƿ�鿴��

start = point_start;                       %��ʼ��
goal = point_goal;                         %Ŀ���

vertics_cost(start) = 0;                   %�Ƚ���ʼ�����open_list(�޸�Ȩֵ�����������ֵ)
vertics_parent(start) = 0;                 %��ʼ���޸��ڵ�
%% ѭ���忪ʼ
while (true)
    [min_cost, current_vertics] = min(vertics_cost(:));   %ѡ��open_list��costֵ��С�Ľڵ�
    if(current_vertics == goal || isinf(min_cost) )
        break;
    end
    vertics_cost(current_vertics) = inf;                   %����ǰ�ڵ����close_list
    vertics_visit(current_vertics) = true;
    %������ǰ������ڽڵ�
    for i = 1:size(vertics(current_vertics).adj_node, 2)
        temp_vertics = vertics(current_vertics).adj_node(i);
        temp_cost = vertics(current_vertics).adj_weight(i);
        if(vertics_visit(temp_vertics) == false)           %�ýڵ㲻��close_list��
            if(vertics_cost(temp_vertics) > min_cost + temp_cost)
                vertics_cost(temp_vertics) =  min_cost + temp_cost;
                vertics_parent(temp_vertics) = current_vertics;
            end
        end
    end
end

%% ���·��
if(isinf(vertics_cost(goal)))
    route = [];
else
    route=[goal];
    while(vertics_parent(route(1)) ~= 0)
        route = [vertics_parent(route(1)), route];
    end
end

 res = route;%����滮·��
end

