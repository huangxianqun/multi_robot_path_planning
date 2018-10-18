clear all; clc; close all;
%��������
map = input_costmap_from_file();
Node_num = size(map, 1);
Robot_num = 5;
global acc_coef;
acc_coef = 0.5;
task_success = 0;
%������ģ��
empty_robot.index = 0;
empty_robot.position = 0;
empty_robot.velocity = 0;
empty_robot.velocity_limit = 0;
empty_robot.task = [];
empty_robot.path = [];
empty_robot.battery = 0;
robot = repmat(empty_robot, Robot_num, 1);

%·����ģ��
empty_path_table.start_time = 0;
empty_path_table.goal_time = 0;
empty_path_table.robot = 0;
path_table = repmat(empty_path_table, Node_num, Node_num);

%��ʼ��������
show_robot_pose = zeros(1, Robot_num);
[ robot, path_table ] = initial_robot_state( robot, path_table, Robot_num, map);

%��ʼ�����񼯺�
task_array = [38, 21, 16, 15, 1, 34,   36];
%��ʼ��ϵͳʱ��
global global_time;
global_time = 0;
tic;
%���������
while (1)
   %����ϵͳʱ��
    global_time = toc;
    %��ȡ��������ɣ�
    
    %������䣨����ɣ�
    current_robot = 0;                                 %ÿ��ѭ��Ϊһ�������˰�������current_robot��¼���ι滮�Ļ�����
%     robot_index = randperm(Robot_num);
    for i=1:Robot_num
        if(isempty(robot(i).task))
            current_robot = i;
            robot(current_robot).task = task_array(1);  %��task_array�е�һ����������current_robot
            break;
        end
    end
%     if(current_robot == 0)
%         continue;
%     end
    if(current_robot ~= 0)
        %�滮·��(�����)
        temp_path = Dijkstra(robot(current_robot).position, robot(current_robot).task(1), map);
        robot(current_robot).path = path_with_time(1/acc_coef*global_time, temp_path, map);
        %·��Э��(δ���)
        [success, path_table, robot] = scheduler(path_table, robot, current_robot, map);
        if(success)
            task_array = [task_array task_array(1)];
            task_array(1) = [];
            task_success = task_success + 1;
        else
            task_array = [task_array task_array(1)];
            task_array(1) = [];
            robot(i).path = [robot(i).path(1, 1), ceil(1/acc_coef*global_time)];
        end
    end

    
    
    %���»�����λ��
    for i = 1:Robot_num
        temp_path = robot(i).path;
        [row, col] = find(temp_path(:, 1) == robot(i).position);
        if(row == 0)                                               %δ��ȡ����������·����λ��
            
        elseif(row == size(temp_path(:, 1), 1))                    %��������·�����
            
        else                                                       %��������·���м� 
            if (acc_coef*temp_path(row, 2) < global_time)
                robot(i).position = temp_path(row+1, 1);           %�������ƶ�����һλ��
            end
        end
    end
    %��ʾ������λ��
    for i = 1:Robot_num
        show_robot_pose(i) = robot(i).position;
    end
    viewer(show_robot_pose, map, robot);
    pause(0.001);
    
    
    for i=1:Robot_num
        if(robot(i).position == robot(i).path(size(robot(i).path, 1)) )
            robot(i).task = [];
            robot(i).path = [];
            robot(i).path = [robot(i).position, ceil(1/acc_coef*global_time)];
        end
        
    end
    
%     if(isempty(task_array))
%         break;
%     end
end


    