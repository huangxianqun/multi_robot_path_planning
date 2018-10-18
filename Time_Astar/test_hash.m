%构造一个包含障碍物信息的map对象
keySet =   {'00100601', '00508902', '09807705', '06603398'};
valueSet = [1, 2, 3, 4];
mapObj = containers.Map(keySet,valueSet);
%查找映射中的值
str = [num2str(5,'%03d'), num2str(89,'%03d'), num2str(2,'%02d')];
disp(str);
object_1 = mapObj('00508902');
disp(object_1);
object_1 = mapObj(str);
disp(object_1);
disp('hello');
%向映射中添加单个键和值
mapObj('04408278') = 1;
%获取映射中的键或值
allkeys = keys(mapObj);
disp(allkeys);
allvalues = values(mapObj);
disp(allvalues);
partvalues = values(mapObj, {'00100601', '00508902'});
disp(partvalues);
%删除键和值
remove(mapObj, {'00100601', '00508902'});
allvalues = values(mapObj);
disp(allvalues);

%double 转 char
%str = num2str(A);
%str = [num2str(1,'%03d'), num2str(2,'%03d'), num2str(3,'%03d')]