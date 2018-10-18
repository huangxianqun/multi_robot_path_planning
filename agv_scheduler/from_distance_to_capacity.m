function res = from_distance_to_capacity( distance )
%FROM_DISTANCE_TO_ 此处显示有关此函数的摘要
%   此处显示详细说明
if(distance <= 600)
    res = 32;
elseif(distance <= 1200)
    res = 16;
else
    res = 8;
end


end

