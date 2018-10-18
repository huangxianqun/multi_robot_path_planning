clc;
clear all;
close all;
cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0; ...
	0.5 0.5 0.5];

colormap(cmap);
%% Define a small map
map_size = 100;
map = false(map_size);
%% Read Picture For Goal Position
picture=imread('3.png');   %Read a picture 
GoalPosition = ReadPictureForSketch(picture, map_size);
%Problem Defination
nVar = 2;                                              %Number of Variables
VarSize = [1, nVar];                                %Matrix Size of Decision Variables
nPop = length(find(GoalPosition==1));                                             %Population Size(Robot Number)
%Initialization

%The Particle Template
empty_particle.Position = [];
empty_particle.NextPosition = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Goal = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];
empty_particle.Best.Index = [];

%Create Population Array
particle = repmat(empty_particle, nPop, 1);

%Initialize Global Best
GlobalBest.Cost = inf;

%%Initialize Position and Goal
[goal_location_x_array goal_location_y_array] = find(GoalPosition==1);
 for i = 1:nPop
     [start_x start_y] = ind2sub(size(map), i+0.5*size(map, 1)*size(map, 1));
     particle(i).Position  = [start_y start_x];
     particle(i).Goal = [goal_location_x_array(i)  goal_location_y_array(i)];
 end

%initial the map to show
 map_plot = zeros(map_size);
 map_plot(~map) = 1;   % Mark free cells
 map_plot(map)  = 2;   % Mark obstacle cells
 
%% 

while(1)
    for i = 1:nPop
             neighbours = GetSurroundingPositions(particle(i).Position);
             MinCost = inf;
             particle(i).NextPosition =zeros(VarSize);
             %Get the cloest point to goal
             for j = 1:size(neighbours, 1)
                 current_x = neighbours(j, 1);
                 current_y = neighbours(j, 2);
                 if (current_x >0 && current_x <= size(map, 1) && current_y >0 && current_y <= size(map, 1)) %the point in the field
                     if (map_plot(current_x, current_y) ~=2)                                                                               %the point is not collision
                         DistanceToGoal = abs(particle(i).Goal(1) - current_x) + abs(particle(i).Goal(2) - current_y);
                         if(DistanceToGoal < MinCost)       %the point is closer than others
                             particle(i).NextPosition(1) = current_x;
                             particle(i).NextPosition(2) = current_y;
                             MinCost = DistanceToGoal;
                         end
                     end
                 end
             end
    end
GoalExchangeArray = zeros(1, nPop);
for i = 1:nPop
        for j = i:nPop
            if(GoalExchangeArray(i) || GoalExchangeArray(j))
                break
            end
             GoalExchange = false;
             if (isempty(setdiff(particle(i).NextPosition,  particle(j).Position)) && isempty(setdiff(particle(j).NextPosition, particle(i).Position)))
                 GoalExchange = true;
             end
             
%               if (isempty(setdiff(particle(i).NextPosition, particle(j).Position)) && isempty(setdiff(particle(j).NextPosition, particle(j).Position)))
%                  GoalExchange = true;
%               end
%              
%               if (isempty(setdiff(particle(j).NextPosition, particle(i).Position)) && isempty(setdiff(particle(i).NextPosition,  particle(i).Position)))
%                  GoalExchange = true;
%               end
              if(GoalExchange && (mod(randperm(100,1), 10) > 5))
                  TempGoal = particle(i).Goal;                           %exchange the goal
                   particle(i).Goal =  particle(j).Goal;
                   particle(j).Goal =TempGoal;
                   particle(i).NextPosition = particle(i).Position;  %keep the particel static
                   particle(j).NextPosition = particle(j).Position;
                   GoalExchangeArray(i) = 1;
                   GoalExchangeArray(j) = 1;
              end
        end
end
  %check if the NextPosition will colllision with other particles  or not 
    for i= 1:nPop
        if(map_plot(particle(i).NextPosition(1), particle(i).NextPosition(2)) ~=1)
            particle(i).NextPosition = particle(i).Position;
        end
        %Update the map_plot
        map_plot(particle(i).Position(1), particle(i).Position(2)) = 1;
        particle(i).Position = particle(i).NextPosition;
        map_plot(particle(i).Position(1), particle(i).Position(2)) = 4;
    end
    %change the goal according to the position of the particle randomly 
    if (mod(randperm(100,1), 11) > 3)
        goal_assigned = GoalAssignment(reshape([particle(1:nPop).Position], 2, nPop)', reshape([particle(1:nPop).Goal], 2, nPop)', map_size);
        for i=1:nPop
            particle(i).Goal(:) = goal_assigned(i, :); 
        end
    end
    %Display
        ShowImage(map_plot);
    %check the task is finished or not
    
end
    
        
