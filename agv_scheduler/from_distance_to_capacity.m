function res = from_distance_to_capacity( distance )
%FROM_DISTANCE_TO_ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if(distance <= 600)
    res = 32;
elseif(distance <= 1200)
    res = 16;
else
    res = 8;
end


end

