%����һ�������ϰ�����Ϣ��map����
keySet =   {'00100601', '00508902', '09807705', '06603398'};
valueSet = [1, 2, 3, 4];
mapObj = containers.Map(keySet,valueSet);
%����ӳ���е�ֵ
str = [num2str(5,'%03d'), num2str(89,'%03d'), num2str(2,'%02d')];
disp(str);
object_1 = mapObj('00508902');
disp(object_1);
object_1 = mapObj(str);
disp(object_1);
disp('hello');
%��ӳ������ӵ�������ֵ
mapObj('04408278') = 1;
%��ȡӳ���еļ���ֵ
allkeys = keys(mapObj);
disp(allkeys);
allvalues = values(mapObj);
disp(allvalues);
partvalues = values(mapObj, {'00100601', '00508902'});
disp(partvalues);
%ɾ������ֵ
remove(mapObj, {'00100601', '00508902'});
allvalues = values(mapObj);
disp(allvalues);

%double ת char
%str = num2str(A);
%str = [num2str(1,'%03d'), num2str(2,'%03d'), num2str(3,'%03d')]