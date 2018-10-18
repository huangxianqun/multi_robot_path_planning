clear all; clc; close all;
Node_num = 69;
Robot_num = 3;
show_robot_pose = zeros(1, Robot_num);
acc_coef = 0.2;
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
empty_path_table.start_time = [];
empty_path_table.goal_time = [];
empty_path_table.robot = [];
path_table = repmat(empty_path_table, Node_num, Node_num);

%��ʼ��������
robot(1).position = 1;
robot(1).task = [];
robot(1).path = [];

robot(2).position = 7;
robot(2).task = [];
robot(2).path = [];

robot(3).position = 28;
robot(3).task = [];
robot(3).path = [];

%��ʼ�����񼯺�
task_array = [33, 1, 7];

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
    for i=1:Robot_num
        if(isempty(robot(i).task))
            current_robot = i;
            robot(current_robot).task = task_array(1);  %��task_array�е�һ����������current_robot
            break;
        end
    end
    if(current_robot == 0)
        continue;
    end
    %�滮·��(�����)
    temp_path = Dijkstra(robot(current_robot).position, robot(current_robot).task(1));
    robot(current_robot).path = path_with_time(global_time, temp_path);
    %·��Э��(δ���)
    [success, path_table, robot] = scheduler(path_table, robot, current_robot);
    if(success)
        task_array(1) = [];
    end
    if(isempty(task_array))
        break;
    end
end


    