function [ res ] = ReadPictureForSketch( A, map_size )
%READPICTUREFORSKETCH 此处显示有关此函数的摘要
%   读取图片中文字信息，转化为规划地图的位置信息 
thresh = graythresh(A);     %自动确定二值化阈值  
BW1 = im2bw(A,thresh);       %对图像二值化 
BW1 = ~BW1;
BW2 = bwmorph(BW1,'thin',Inf); %骨架化
%imshow(BW2);
nPop = map_size;
map = zeros(nPop, nPop);
[row, column] = size(BW2);
scale_factor_float = max(row, column)/nPop;
map_1_row = floor(row/scale_factor_float);
map_1_column = floor(column/scale_factor_float);
map_1 = zeros(map_1_row, map_1_column);
for i = 1:map_1_row
    for j = 1:map_1_column
        exit_point = 0;
        for s_i = 1:ceil(scale_factor_float)
            for s_j = 1:ceil(scale_factor_float)
                if (BW2(floor((i-1)*scale_factor_float+s_i), floor((j-1)*scale_factor_float+ s_j)))
                    exit_point = exit_point + 1;
                end
            end
        end
        if(exit_point >0)
           map_1(i, j) =1;
        end
    end
end
if(size(map_1, 1) < size(map_1, 2))
    distance = fix((size(map, 1) - size(map_1, 1))/2);
    for i =1:size(map_1, 1)
        map(distance+i, :) = map_1(i, :);
    end
else
    distance = fix((size(map, 2) - size(map_1, 2))/2);
    for i =1:size(map_1, 2)
        map(:, distance+i) = map_1(:, i);
    end
end

%  imshow(map);
%   pause(10);
res = map;
end

