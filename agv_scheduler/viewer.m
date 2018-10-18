function  viewer( pos_array, map, robot)
%VIEWER 此处显示有关此函数的摘要
%   此处显示详细说明

set(gcf,'outerposition',get(0,'screensize'));
%显示地图
map_alpha = 0:pi/20:2*pi;
vertics_r=0.3;%节点
% map_x = [0, 0, 2, 3, 3, 5, 6, 6, 8, 9, 9, 11, 12, 12, 14, 12, 12, 15, 15, 17, 15, 15, 18, 18, 20,...
%     18, 18, 21, 21, 23, 21, 21, 24, 24, 26, 24,24, 27, 27, 29, 27, 27, 30, 30, 32, 30, 30, 33,... 
%     33, 35, 33, 33, 36, 36, 38, 36, 36, 42, 42, 40, 45, 45, 43, 48, 48, 46, 51, 51, 49];
% map_y = [5, 2, 0, 5, 2, 0, 5, 2, 0, 5, 2, 0, 5, 2, 0, -2, -5,5, 2, 0, -2, -5,5, 2, 0, -2, -5,...
%     5, 2, 0, -2, -5,5, 2, 0, -2, -5,5, 2, 0, -2, -5,5, 2, 0, -2, -5,5, 2, 0, -2, -5,5, 2, 0, -2, -5,...
%     5, 2, 0,5, 2, 0,5, 2, 0,5, 2, 0];
for i =1:size(map, 1) 
    x = vertics_r*cos(map_alpha) + map(i).position(1);
    y = vertics_r*sin(map_alpha) + map(i).position(2);
    
    for j = 1:size(map(i).adj_node, 2)
        plot_line(map(i).position, map(map(i).adj_node(j)).position, 'k');
    end
    plot(x, y, 'k');
    fill(x,y,'k');
    axis equal;
    hold on;
    axis([-2 42 -2 42]);
end


% 
% % %% 画直线
% plot_line([map_x(1), map_y(1)], [map_x(2), map_y(2)]);
% plot_line([map_x(3), map_y(3)], [map_x(6), map_y(6)]);
% plot_line([map_x(4), map_y(4)], [map_x(5), map_y(5)]);
% plot_line([map_x(6), map_y(6)], [map_x(9), map_y(9)]);
% plot_line([map_x(7), map_y(7)], [map_x(8), map_y(8)]);
% plot_line([map_x(9), map_y(9)], [map_x(12), map_y(12)]);
% plot_line([map_x(10), map_y(10)], [map_x(11), map_y(11)]);
% plot_line([map_x(12), map_y(12)], [map_x(15), map_y(15)]);
% 
% plot_line([map_x(13), map_y(13)], [map_x(14), map_y(14)]);
% plot_line([map_x(15), map_y(15)], [map_x(20), map_y(20)]);
% plot_line([map_x(16), map_y(16)], [map_x(17), map_y(17)]);
% plot_line([map_x(18), map_y(18)], [map_x(19), map_y(19)]);
% plot_line([map_x(20), map_y(20)], [map_x(25), map_y(25)]);
% plot_line([map_x(21), map_y(21)], [map_x(22), map_y(22)]);
% plot_line([map_x(23), map_y(23)], [map_x(24), map_y(24)]);
% plot_line([map_x(25), map_y(25)], [map_x(30), map_y(30)]);
% plot_line([map_x(26), map_y(26)], [map_x(27), map_y(27)]);
% plot_line([map_x(28), map_y(28)], [map_x(29), map_y(29)]);
% plot_line([map_x(30), map_y(30)], [map_x(35), map_y(35)]);
% plot_line([map_x(31), map_y(31)], [map_x(32), map_y(32)]);
% plot_line([map_x(33), map_y(33)], [map_x(34), map_y(34)]);
% plot_line([map_x(35), map_y(35)], [map_x(40), map_y(40)]);
% plot_line([map_x(36), map_y(36)], [map_x(37), map_y(37)]);
% plot_line([map_x(38), map_y(38)], [map_x(39), map_y(39)]);
% plot_line([map_x(40), map_y(40)], [map_x(45), map_y(45)]);
% plot_line([map_x(41), map_y(41)], [map_x(42), map_y(42)]);
% plot_line([map_x(43), map_y(43)], [map_x(44), map_y(44)]);
% plot_line([map_x(45), map_y(45)], [map_x(50), map_y(50)]);
% plot_line([map_x(46), map_y(46)], [map_x(47), map_y(47)]);
% plot_line([map_x(48), map_y(48)], [map_x(49), map_y(49)]);
% plot_line([map_x(50), map_y(50)], [map_x(55), map_y(55)]);
% plot_line([map_x(51), map_y(51)], [map_x(52), map_y(52)]);
% plot_line([map_x(53), map_y(53)], [map_x(54), map_y(54)]);
% plot_line([map_x(55), map_y(55)], [map_x(60), map_y(60)]);
% plot_line([map_x(56), map_y(56)], [map_x(57), map_y(57)]);
% 
% plot_line([map_x(58), map_y(58)], [map_x(59), map_y(59)]);
% plot_line([map_x(60), map_y(60)], [map_x(63), map_y(63)]);
% plot_line([map_x(61), map_y(61)], [map_x(62), map_y(62)]);
% plot_line([map_x(63), map_y(63)], [map_x(66), map_y(66)]);
% plot_line([map_x(64), map_y(64)], [map_x(65), map_y(65)]);
% plot_line([map_x(66), map_y(66)], [map_x(69), map_y(69)]);
% plot_line([map_x(67), map_y(67)], [map_x(68), map_y(68)]);
% %% 画圆弧
% plot_circle([map_x(2), map_y(2)], [map_x(3), map_y(3)], [map_x(3), map_y(2)]);
% plot_circle([map_x(5), map_y(5)], [map_x(6), map_y(6)], [map_x(6), map_y(5)]);
% plot_circle([map_x(8), map_y(8)], [map_x(9), map_y(9)], [map_x(9), map_y(8)]);
% plot_circle([map_x(11), map_y(11)], [map_x(12), map_y(12)], [map_x(12), map_y(11)]);
% 
% plot_circle([map_x(14), map_y(14)], [map_x(15), map_y(15)], [map_x(15), map_y(14)]);
% plot_circle([map_x(15), map_y(15)], [map_x(16), map_y(16)], [map_x(15), map_y(16)]);
% plot_circle([map_x(19), map_y(19)], [map_x(20), map_y(20)], [map_x(20), map_y(19)]);
% plot_circle([map_x(20), map_y(20)], [map_x(21), map_y(21)], [map_x(20), map_y(21)]);
% plot_circle([map_x(24), map_y(24)], [map_x(25), map_y(25)], [map_x(25), map_y(24)]);
% plot_circle([map_x(25), map_y(25)], [map_x(26), map_y(26)], [map_x(25), map_y(26)]);
% plot_circle([map_x(29), map_y(29)], [map_x(30), map_y(30)], [map_x(30), map_y(29)]);
% plot_circle([map_x(30), map_y(30)], [map_x(31), map_y(31)], [map_x(30), map_y(31)]);
% plot_circle([map_x(34), map_y(34)], [map_x(35), map_y(35)], [map_x(35), map_y(34)]);
% plot_circle([map_x(35), map_y(35)], [map_x(36), map_y(36)], [map_x(35), map_y(36)]);
% plot_circle([map_x(39), map_y(39)], [map_x(40), map_y(40)], [map_x(40), map_y(39)]);
% plot_circle([map_x(40), map_y(40)], [map_x(41), map_y(41)], [map_x(40), map_y(41)]);
% plot_circle([map_x(44), map_y(44)], [map_x(45), map_y(45)], [map_x(45), map_y(44)]);
% plot_circle([map_x(45), map_y(45)], [map_x(46), map_y(46)], [map_x(45), map_y(46)]);
% plot_circle([map_x(49), map_y(49)], [map_x(50), map_y(50)], [map_x(50), map_y(49)]);
% plot_circle([map_x(50), map_y(50)], [map_x(51), map_y(51)], [map_x(50), map_y(51)]);
% plot_circle([map_x(54), map_y(54)], [map_x(55), map_y(55)], [map_x(55), map_y(54)]);
% plot_circle([map_x(55), map_y(55)], [map_x(56), map_y(56)], [map_x(55), map_y(56)]);
% 
% plot_circle([map_x(60), map_y(60)], [map_x(59), map_y(59)], [map_x(60), map_y(59)]);
% plot_circle([map_x(63), map_y(63)], [map_x(62), map_y(62)], [map_x(63), map_y(62)]);
% plot_circle([map_x(66), map_y(66)], [map_x(65), map_y(65)], [map_x(66), map_y(65)]);
% plot_circle([map_x(69), map_y(69)], [map_x(68), map_y(68)], [map_x(69), map_y(68)]);
% 



%% 
%显示机器人位置
robot_pose = pos_array;
alpha = 0:pi/20:2*pi;
R=0.5;%机器人半径
robot_color = ['r','g','b','c','y', 'm', 'k','b'];
for i=1:size(pos_array, 2)
    x = R*cos(alpha) + map(robot_pose(i)).position(1);
    y = R*sin(alpha) + map(robot_pose(i)).position(2);
    plot(x, y, robot_color(i));%画机器人当前位置
    if(~isempty(robot(i).task))
        x_d = R*cos(alpha) + map(robot(i).task(1)).position(1);
        y_d = R*sin(alpha)+ map(robot(i).task(1)).position(2);
        plot(x_d, y_d,  robot_color(i),'LineWidth',5); %画机器人目标点
    end
    
    for j = 1:size(robot(i).path, 1) - 1
        plot_line(map(robot(i).path(j, 1)).position, map(robot(i).path(j+1, 1)).position, robot_color(i));
    end
    
    axis equal;
    hold on;
    axis([-2 42 -2 42]);
    fill(x,y,robot_color(i));
end
hold off;

end

function  plot_line( point_1, point_2 , color)
x = [point_1(1), point_2(1)];
y = [point_1(2), point_2(2)];
plot(x, y, color,'LineWidth',1.5);
axis equal;
hold on;
axis([-2 42 -2 42]);
end

function plot_circle(point_start, point_end, point_center)
theta_start = 0;
theta_end = 0;
if(point_start(1) >point_center(1) &&point_start(2) == point_center(2) &&  point_end(1) == point_center(1)&& point_end(2) > point_center(2) )
    theta_start = 0;
    theta_end = 0.5*pi;
elseif(point_start(1) == point_center(1) && point_start(2) > point_center(2) && point_end(2) == point_center(2) && point_end(1) < point_center(1))
    theta_start = 0.5*pi;
    theta_end = pi;
elseif(point_start(1) < point_center(1) && point_start(2) == point_center(2)&& point_end(1) == point_center(1) && point_end(2) < point_center(2))
    theta_start = pi;
    theta_end = 1.5*pi;
elseif(point_start(1) == point_center(1) && point_start(2) < point_center(2) && point_end(2) == point_center(2) && point_end(1) > point_center(1))
    theta_start = 1.5*pi;
    theta_end = 2*pi;
end

circle_r = 2;
circle_theta = theta_start:0.2:theta_end;
x = circle_r*cos(circle_theta) + point_center(1);
y = circle_r*sin(circle_theta) + point_center(2);
plot(x, y, 'k','LineWidth',1.5);
axis equal;
hold on;
axis([-2 52 -10 10]);

end


           

