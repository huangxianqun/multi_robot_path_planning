function [ res ] = GoalAssignment( particle_postion_array, goal_position_array, map_size )
%GOALASSIGNMENT 此处显示有关此函数的摘要
%   根据粒子群位置，将任务点合理分配给每个粒子
%    sorted_goal_position = sortrows(reshape([goal_position_array(1:size(goal_position_array,1))], 2, nPop)', -2);
%     particle_postion_array = [    50    46;
%     48    49;
%     50    44;
%     50    47;
%     50    45;
%     49    45;
%     49    48;
%     50    48;
%     49    46;
%     49    47];
%   将粒子当前位置进行排序
    %将二维坐标转化为一维
    nPop = size( particle_postion_array, 1);
    res = zeros(nPop, 2);
    [sorted_current_position  particle_index] = sort(sub2ind([map_size map_size],  particle_postion_array(1:nPop, 1),  particle_postion_array(1:nPop, 2)));
%   计算目标点集合分成多少列，将列数和每列粒子个数用一个二维数组表示
%     goal_position_array =    [ 50    46;
%         49    46;
%         50    47;
%         49    47;
%         50    48;
%         49    48;
%         50    49;
%         49    49;
%         50    50;
%         49    50];
    sorted_goal_position = sortrows(goal_position_array, 2);
    count_num = 0;
    count_index = 0;
    goal_set_information = [];
    for i =1:size(sorted_goal_position, 1)
        if (i==1)
            count_num = 1;
            count_index = 1;
            goal_set_information(count_index, 1) = sorted_goal_position(i, 2);
            goal_set_information(count_index, 2) = count_num;
            continue;
        end
        
        if (sorted_goal_position(i, 2) == sorted_goal_position(i-1, 2))
            count_num = count_num + 1;
        else
            count_num = 1;
            count_index = count_index + 1;
        end
        goal_set_information(count_index, 1) = sorted_goal_position(i, 2);
        goal_set_information(count_index, 2) = count_num;
    end
    disp(goal_set_information);
    goal_index = 1;
    for i = 1:size(goal_set_information, 1)
        goal_num_one_column = goal_set_information(i, 2);                                         %记录每一列的目标点个数
        goal_one_column =sorted_goal_position(goal_index:goal_index+goal_num_one_column-1, :);       %找出该列的目标点集合
        goal_one_column = sortrows(goal_one_column, 1);
        current_position_index_one_column = particle_index(goal_index:goal_index+goal_num_one_column-1); %找出对应的粒子序列集合，准备下面的分配任务
        for j=1:goal_num_one_column
            res(current_position_index_one_column(j), :) = goal_one_column(j, :);
        end
        goal_index = goal_index + goal_num_one_column ;
    end
    disp(res);
% column_goal_position = sorted_goal_position(1,2);
% while(column_goal_position <= sorted_goal_position(nPop,2))
% 
end