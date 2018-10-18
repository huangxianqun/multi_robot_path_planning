function res = path_with_time(current_time, path, map)
%�ú������滮��·�����ʱ����Ϣ

vertics = map;                %�����ͼ
start_time = ceil(current_time + 10);     %�����ʱ������Ϊ10s��
res = [path(1), start_time];              %����λ�ú�ʱ��
current_time = start_time;
for i= 1:size(path, 2) - 1
    [exist, loca] = ismember(path(i+1), vertics(path(i)).adj_node);
    if(exist)
        res = [res;[path(i+1), vertics(path(i)).adj_weight(loca)+current_time]];
        current_time = vertics(path(i)).adj_weight(loca)+current_time;
    else
        disp('The path with time information error!');
    end

end

