function res = path_with_time(current_time, path, map)
%该函数将规划的路径添加时间信息

vertics = map;                %输入地图
start_time = ceil(current_time + 10);     %将起点时刻设置为10s后
res = [path(1), start_time];              %起点的位置和时间
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

