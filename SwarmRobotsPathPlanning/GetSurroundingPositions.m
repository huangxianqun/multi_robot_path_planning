function [ res ] = GetSurroundingPositions( position )
%GETSURROUNDINGPOSITIONS 此处显示有关此函数的摘要
%   获取给定位置周围上下左右的四个点，不考虑越界和碰撞
    %Get the Surrouding Positions
    p_x = position(1);
    p_y = position(2);
    neighbours = [p_x-1, p_y;
                           p_x+1, p_y;
                           p_x, p_y-1;
                           p_x, p_y+1;
                           p_x, p_y];
     rowrank = randperm(size(neighbours, 1));
     res = neighbours(rowrank, :);
end

