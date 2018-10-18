function [ res ] = ReadPictureForSketch( A, map_size )
%READPICTUREFORSKETCH �˴���ʾ�йش˺�����ժҪ
%   ��ȡͼƬ��������Ϣ��ת��Ϊ�滮��ͼ��λ����Ϣ 
thresh = graythresh(A);     %�Զ�ȷ����ֵ����ֵ  
BW1 = im2bw(A,thresh);       %��ͼ���ֵ�� 
BW1 = ~BW1;
BW2 = bwmorph(BW1,'thin',Inf); %�Ǽܻ�
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

