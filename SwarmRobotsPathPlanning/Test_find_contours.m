clear all;
close all;
A=imread('2.jpg');   %读取到一张图片   
thresh = graythresh(A);     %自动确定二值化阈值  
BW1 = im2bw(A,thresh);       %对图像二值化 
BW1 = ~BW1;
BW2 = bwmorph(BW1,'thin',Inf); %骨架化
%imshow(BW2);
nPop = 100;
map = zeros(nPop, nPop);
[row, column] = size(BW2);
scale_factor = fix(max(row, column)/nPop);
scale_factor_float = max(row, column)./nPop;
map_1 = zeros(round(row/scale_factor_float), round(column/scale_factor_float));
for i = 1:round(row/scale_factor_float)
    for j = 1:round(column/scale_factor_float)
        exit_point = 0;
        for s_i = 1:scale_factor
            for s_j = 1:scale_factor
                if (BW2((i-1)*scale_factor+s_i, (j-1)*scale_factor+ s_j))
                    exit_point = exit_point + 1;
                end
            end
        end
        if(exit_point >0)
           map_1(i, j) =1;
        end
    end
end
% distance = fix((size(map, 1) - size(map_1, 1))/2);
% for i =1:size(map_1, 1)
%     map(distance+i, :) = map_1(i, :);
% end

imshow(map_1);
