function [ res ] = GetSurroundingPositions( position )
%GETSURROUNDINGPOSITIONS �˴���ʾ�йش˺�����ժҪ
%   ��ȡ����λ����Χ�������ҵ��ĸ��㣬������Խ�����ײ
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

