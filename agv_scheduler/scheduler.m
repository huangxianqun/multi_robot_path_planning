function [success, path_table, robot] = scheduler(path_table, robot, current_robot, map)
%SCHEDULER ��һ���µ�·������Э��
%   �˴���ʾ��ϸ˵��
% success - ��ʾЭ���Ƿ�ɹ�
% path_table - ��ʾ·����
% robot - ��ʾ��������Ϣ
% current_robot - ��ʾ��ǰ��ҪЭ���Ļ�����

global acc_coef;
global global_time;


%���ֹͣ״̬����·�����и���ֹͣ���뿪ʱ�䣩
[path_table] = exit_stop_state(path_table, robot, current_robot, map);
while (1)   %ѭ�����н��ж�β��ҳ�ͻ��ֱ����ͻ��ȫ����
    %% ����Ƿ���ڳ�ͻ
    collision_robot = 0;
    collision_link = [];
    
    for i = 1:size(robot(current_robot).path, 1)-1
        p_start = min(robot(current_robot).path(i, 1), robot(current_robot).path(i+1, 1));
        p_end = max(robot(current_robot).path(i, 1), robot(current_robot).path(i+1, 1));
        t_start = robot(current_robot).path(i, 2);  %��ǰ��ռ����ʼʱ��
        t_end = robot(current_robot).path(i+1, 2);  %��ǰ��ռ����ֹʱ��
        if(~isempty(path_table(p_start, p_end).robot))  %�����·����������������ռ�õ����
            for j = 1:size(path_table(p_start, p_end).robot, 2)
                table_start = path_table(p_start, p_end).start_time(j);    %·�����е�ǰ��ռ����ʼʱ��
                table_end = path_table(p_start, p_end).goal_time(j);       %·�����е�ǰ��ռ����ֹʱ��
                if(~(t_end <= table_start || t_start >= table_end))  %���ڳ�ͻ
                    collision_robot = path_table(p_start, p_end).robot(j);
                    link_s = min(robot(current_robot).path(i, 1), robot(current_robot).path(i+1, 1));
                    link_e = max(robot(current_robot).path(i, 1), robot(current_robot).path(i+1, 1));
                    collision_link = [link_s, link_e];
                    disp('collision_link');
                    disp(collision_link);
                    break;
                end
            end
        end
        
        if(collision_robot)     %����⵽��ͻʱ��������ֹ�����̣�����Э��
            break;
        end

    end
    
    if(collision_robot == 0)   %�������·��֮������ײ���˳�
        success = true;
        disp('success');
        break;
    end
    
    if(isempty(robot(collision_robot).task) || size(robot(collision_robot).path, 1) ==  1 || collision_link(1) == robot(collision_robot).task(1) || collision_link(2) == robot(collision_robot).task(1) )  %�����ײ�ı���collision_robot��ֹͣ�㣬��ô�˴�Э��ʧ��
    temp_point = robot(current_robot).path(1, 1);
    robot(current_robot).path = [temp_point, ceil(global_time/acc_coef)];
    [path_table] = enter_stop_state(path_table, robot, current_robot, map);
    success  = false;
    break;
    
    end
    %% ��ʼЭ������
    %��ת��ǰ������·��
    current_path = robot(current_robot).path(:, 1);             %��ǰ������·��
    currrent_path_inv = flip(current_path);                     %��ǰ������·������
    collision_robot_path = robot(collision_robot).path(:, 1);   %��ͻ������·��
    disp(collision_robot);
    disp(collision_robot_path);
    %Ѱ����ʱ�ȴ���
    temp_start_node = collision_link(1);
    temp_staying_node = 0;
    [exist, loca_start] = ismember(temp_start_node, currrent_path_inv);
    sprintf('loca_start:%d', loca_start)
    if(exist)
        disp('current path');
        disp(current_path);
        for i = loca_start:size(currrent_path_inv, 1)
            if(~ismember(currrent_path_inv(i), collision_robot_path))
                temp_staying_node = currrent_path_inv(i);
                disp('is not a member');
                break;
            end
        end
    else
        disp('error');
    end
    sprintf('temp_staying_node:%d', temp_staying_node)
    
    
    if(temp_staying_node == 0)                 %��������ʱͣ���㣬��ֹ����Э��
        temp_point = robot(current_robot).path(1, 1);
        robot(current_robot).path = [temp_point, ceil(global_time/acc_coef)];
        [path_table] = enter_stop_state(path_table, robot, current_robot, map);
        success  = false;
        break;
    end
    
    %��õȴ�ʱ��
    [exist_in_current_path, loca_in_current_path] = ismember(temp_staying_node, current_path);  %����temp_staying_node��current_path��λ��
    sprintf('exist_in_current_path:%d', exist_in_current_path)
    sprintf('loca_in_current_path:%d', loca_in_current_path)
    wait_link = [current_path(loca_in_current_path), current_path(loca_in_current_path+1)];
    wait_link_t_start =  robot(current_robot).path(loca_in_current_path, 2);
    wait_link_t_end = wait_link_t_start;
    wait_link_start = min(wait_link(1), wait_link(2));
    wait_link_end = max(wait_link(1), wait_link(2));
    if(~isempty(path_table(wait_link_start, wait_link_end).robot))
        for i=1:size(path_table(wait_link_start, wait_link_end).robot, 2)
            if(path_table(wait_link_start, wait_link_end).goal_time(i) > wait_link_t_end && path_table(wait_link_start, wait_link_end).goal_time(i) > wait_link_t_start)
                wait_link_t_end = path_table(wait_link_start, wait_link_end).goal_time(i);
                disp(wait_link_t_end);
            end
        end
    else
        wait_link_t_end = robot(current_robot).path(loca_in_current_path+1, 2);
    end
    
    if(wait_link_t_start == wait_link_t_end)
        wait_link_t_end = robot(current_robot).path(loca_in_current_path+1, 2);
    end
        
     wait_add_time = wait_link_t_end - wait_link_t_start; %- (robot(current_robot).path(loca_in_current_path+1, 2) - wait_link_t_start);

    sprintf('wait_link_t_start__:%d', robot(current_robot).path(loca_in_current_path+1, 2))
    sprintf('wait_link_t_start:%d', wait_link_t_start)
    sprintf('wait_link_t_end:%d', wait_link_t_end)
    sprintf('wait_add_time:%d', wait_add_time)
    
    
    if(wait_add_time > 100)   %�ȴ�ʱ���������ֹ����Э��
        temp_point = robot(current_robot).path(1, 1);
        robot(current_robot).path = [temp_point, ceil(global_time/acc_coef)];
        [path_table] = enter_stop_state(path_table, robot, current_robot, map);
        success  = false;
        break;
    end
    
    %���µ�ǰ������·��

    for i = loca_in_current_path : size(robot(current_robot).path, 1)
        robot(current_robot).path(i, 2) = robot(current_robot).path(i, 2) + wait_add_time;
    end


end

%��ͻ����֮����Ҫ��Э�����·�������������Ϣ���Լ�·������
for i=1:size(robot(current_robot).path, 1)-1
    node_1 = robot(current_robot).path(i, 1);
    t_1 = robot(current_robot).path(i, 2);
    node_2 = robot(current_robot).path(i+1, 1);
    t_2 = robot(current_robot).path(i+1, 2);
    %��node_1�йصı�
    for j = 1:size(map(node_1).adj_node, 2)
        node_s = min(node_1, map(node_1).adj_node(j));
        node_g = max(node_1, map(node_1).adj_node(j));
        path_table(node_s, node_g).start_time = [path_table(node_s, node_g).start_time, t_1];
        path_table(node_s, node_g).goal_time = [path_table(node_s, node_g).goal_time, t_2];
        path_table(node_s, node_g).robot = [path_table(node_s, node_g).robot, current_robot];
%         disp('1');
%         disp(node_s);
%         disp(path_table(node_s, node_g).start_time);
%         disp(path_table(node_s, node_g).goal_time);
%         disp(path_table(node_s, node_g).robot);
%         disp(node_g);
%         disp('2');
    end
    
    %��node_2�йصı�
    for j = 1:size(map(node_2).adj_node, 2)
        if(map(node_2).adj_node(j) ~= node_1)
            node_s = min(node_2, map(node_2).adj_node(j));
            node_g = max(node_2, map(node_2).adj_node(j));
            path_table(node_s, node_g).start_time = [path_table(node_s, node_g).start_time, t_1];
            path_table(node_s, node_g).goal_time = [path_table(node_s, node_g).goal_time, t_2];
            path_table(node_s, node_g).robot = [path_table(node_s, node_g).robot, current_robot];
        end
    end 
end

%��ֹͣ����صıߵ��뿪ʱ������Ϊ�����


current_path_length = size(robot(current_robot).path, 1);
node_1 = robot(current_robot).path(current_path_length, 1);
t_1 = robot(current_robot).path(current_path_length, 2);

for i = 1:size(map(node_1).adj_node, 2)
    node_s = min(node_1, map(node_1).adj_node(i));
    node_g = max(node_1, map(node_1).adj_node(i));
    path_table(node_s, node_g).start_time = [path_table(node_s, node_g).start_time, t_1];
    path_table(node_s, node_g).goal_time = [path_table(node_s, node_g).goal_time, inf];
    path_table(node_s, node_g).robot = [path_table(node_s, node_g).robot, current_robot];
end


