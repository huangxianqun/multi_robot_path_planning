function res = input_costmap_from_file( )

fidin=fopen('map.txt');              %���ļ�
infile = {};
while ~feof(fidin)                   %�ж��ǲ����ļ�ĩβ                                      
   tline=fgetl(fidin);               %��ȡһ�У�ע�⣬����һ�к󣬹��ͻ��Զ�����һ��
   infile = [infile tline];
   if isempty(tline)      %�ж��ǲ��ǿ���
       continue
   end
%    disp(int8(str2num(tline)));
end

vertics_num = size(infile, 2);
%Node Template
empty_node.index = 0;                %��ǰ�ڵ���
empty_node.adj_node = [];            %��ǰ�ڵ�����ڽڵ�
empty_node.adj_weight = [];          %��ǰ�ڵ㵽���ڽڵ�ߵ�Ȩֵ
empty_node.parent_node = 0;          %��ǰ�ڵ�ĸ��ڵ�
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

