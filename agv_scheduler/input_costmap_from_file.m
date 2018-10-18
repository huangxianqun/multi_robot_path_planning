function res = input_costmap_from_file( )

fidin=fopen('map.txt');              %打开文件
infile = {};
while ~feof(fidin)                   %判断是不是文件末尾                                      
   tline=fgetl(fidin);               %读取一行，注意，读文一行后，光标就会自动到下一行
   infile = [infile tline];
   if isempty(tline)      %判断是不是空行
       continue
   end
%    disp(int8(str2num(tline)));
end

vertics_num = size(infile, 2);
%Node Template
empty_node.index = 0;                %当前节点编号
empty_node.adj_node = [];            %当前节点的相邻节点
empty_node.adj_weight = [];          %当前节点到相邻节点边的权值
empty_node.parent_node = 0;          %当前节点的父节点
empty_node.position = [];

node = repmat(empty_node, vertics_num, 1);
format short g;
for i =1:vertics_num
    temp_array = str2num(infile{i});
    for j = 1:size(temp_array, 2)
        if(j == 1)
            node(i).index = temp_array(j);
        elseif(j <= (size(temp_array, 2) - 1)/2)
            node(i).adj_node = [node(i).adj_node temp_array(j)];
        elseif(j <= size(temp_array, 2) - 2)
            node(i).adj_weight = [node(i).adj_weight temp_array(j)];
        else
            node(i).position = [node(i).position temp_array(j)];
        end
    end
end

res = node;

end

