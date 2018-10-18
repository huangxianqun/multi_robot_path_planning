clear all; clc; close all;
%参数输入
map = input_costmap_from_file();
Node_num = size(map, 1);
Robot_num = 5;
global acc_coef;
acc_coef = 0.5;
task_success = 0;
%机器人模板
empty_robot.index = 0;
empty_robot.position = 0;
empty_robot.velocity = 0;
empty_robot.velocity_limit = 0;
empty_robot.task = [];
empty_robot.path = [];
empty_robot.battery = 0;
robot = repmat(empty_robot, Robot_num, 1);

%路径表模板
empty_path_table.start_time = 0;
empty_path_table.goal_time = 0;
empty_path_table.robot = 0;
path_table = repmat(empty_path_table, Node_num, Node_num);

%初始化机器人
show_robot_pose = zeros(1, Robot_num);
[ robot, path_table ] = initial_robot_state( robot, path_table, Robot_num, map);

%初始化任务集合
task_array = [38, 21, 16, 15, 1, 34,   36];
%初始化系统时间
global global_time;
global_time = 0;
tic;
%主程序入口
while (1)
   %更新系统时间
    global_time = toc;
    %获取任务（已完成）
    
    %任务分配（已完成）
    current_robot = 0;                                 %每次循环为一个机器人安排任务，current_robot记录本次规划的机器人
%     robot_index = randperm(Robot_num);
    for i=1:Robot_num
        if(isempty(robot(i).task))
            current_robot = i;
            robot(current_robot).task = task_array(1);  %将task_array中第一个任务分配给current_robot
            break;
        end
    end
%     if(current_robot == 0)
%         continue;
%     end
    if(current_robot ~= 0)
        %规划路径(已完成)
        temp_path = Dijkstra(robot(current_robot).position, robot(current_robot).task(1), map);
        robot(current_robot).path = path_with_time(1/acc_coef*global_time, temp_path, map);
        %路径协调(未完成)
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

    
    
    %更新机器人位置
    for i = 1:Robot_num
        temp_path = robot(i).path;
        [row, col] = find(temp_path(:, 1) == robot(i).position);
        if(row == 0)                                               %未获取到机器人在路径中位置
            
        elseif(row == size(temp_path(:, 1), 1))                    %机器人在路径最后
            
        else                                                       %机器人在路径中间 
            if (acc_coef*temp_path(row, 2) < global_time)
                robot(i).position = temp_path(row+1, 1);           %机器人移动到下一位置
            end
        end
    end
    %显示机器人位置
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


    