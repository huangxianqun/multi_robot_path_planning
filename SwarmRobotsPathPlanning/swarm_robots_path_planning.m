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
map_size = 50;
map = false(map_size);
% Add an obstacle
% map (1:20, 6) = true;
% map(20:30, 30:35) = true;
% map(45:50, 20:30) = true;
% map(30:35,1:5) = true;
% calculate the potential field for  robots
start_coords = [1, 1];
dest_coords  = [50, 50];
[distanceFromStart_ ] = DijkstraGrid (map,  dest_coords, start_coords);
distanceFromStart_(dest_coords(1), dest_coords(2)) = 0;
disp(distanceFromStart_ );
%% path planning for swarm robots using PSO
%Problem Defination

CostFunction = distanceFromStart_ ;   %CostFunction
nVar = 2;                                              %Number of Variables
VarSize = [1, nVar];                                %Matrix Size of Decision Variables

%Parameters of PSO
nPop = 20;                                             %Population Size(Robot Number)
w = 0;   %w = 1;                                                   %Intertia Coefficient
wdamp = 0.9;                                            %Damping Ratio of Inertia Coefficiennt
c1 = 0;  %c1 = 1.5                                                   %Personal Acceleration Coefficiennt
c2 = 2;                                                   %Social Acceleration Coefficient
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
%Initialize Population Members
%%Initialize Position and Goal
particle(1).Position = [1, 1];    particle(1).Goal   = [50, 50];
particle(2).Position = [1, 2];    particle(2).Goal   = [50, 49];
particle(3).Position = [1, 3];    particle(3).Goal   = [50, 48];
particle(4).Position = [1, 4];    particle(4).Goal   = [50, 47];
particle(5).Position = [2, 1];    particle(5).Goal   = [50, 46];
particle(6).Position = [2, 2];    particle(6).Goal   = [49, 50];
particle(7).Position = [2, 3];    particle(7).Goal   = [49, 49];
particle(8).Position = [2, 4];    particle(8).Goal   = [49, 48];
particle(9).Position = [3, 1];    particle(9).Goal   = [49, 47];
particle(10).Position = [3, 2];  particle(10).Goal = [49, 46];
particle(11).Position = [3, 3];  particle(11).Goal = [48, 50];
particle(12).Position = [3, 4];  particle(12).Goal = [48, 49];
particle(13).Position = [4, 1];  particle(13).Goal = [48, 48];
particle(14).Position = [4, 2];  particle(14).Goal = [48, 47];
particle(15).Position = [4, 3];  particle(15).Goal = [48, 46];
particle(16).Position = [4, 4];  particle(16).Goal = [47, 50];
particle(17).Position = [5, 1];  particle(17).Goal = [47, 49];
particle(18).Position = [5, 2];  particle(18).Goal = [47, 48];
particle(19).Position = [5, 3];  particle(19).Goal = [47, 47];
particle(20).Position = [5, 4];  particle(20).Goal = [47, 46];


%initial the map to show
     map_plot = zeros(map_size);
     map_plot(~map) = 1;   % Mark free cells
     map_plot(map)  = 2;   % Mark obstacle cells
 
for i = 1:nPop
    %Initialize Velocity
    particle(i).Velocity = zeros(VarSize);
    
    %Evaluation
    particle(i).Cost = CostFunction(particle(i).Position(1), particle(i).Position(2));
    
    %Update the Personal Best
    particle(i).Best.Position = particle(i).Position;
    particle(i).Best.Cost = particle(i).Cost;
    particle(i).Best.Index = i;
    map_plot(particle(i).Position(1), particle(i).Position(2)) = 4;
    
    %Update Global Best
    if (particle(i).Best.Cost < GlobalBest.Cost )
        GlobalBest = particle(i).Best;
    end
end
map_plot(GlobalBest.Position(1), GlobalBest.Position(2)) = 3;
ShowImage(map_plot);

 %% Main Loop of PSO
while (GlobalBest.Position(1) ~= dest_coords(1)  || GlobalBest.Position(2) ~= dest_coords(2)  )
    for i = 1:nPop
        %Judge Leader
        if (i == GlobalBest.Index)
            %Get the Surrouding Positions
             neighbours = GetSurroundingPositions(particle(i).Position);
             p_x = particle(i).Position(1);
             p_y = particle(i).Position(2);
             MinCost = inf;
             NextPosition =zeros(VarSize);
              for j = 1:size(neighbours, 1)
                 current_x = neighbours(j, 1);
                 current_y = neighbours(j, 2);
                 if (current_x >0 && current_x <= size(map, 1) && current_y >0 && current_y <= size(map, 1)) %the point in the field
                     if (map_plot(current_x, current_y) ==1)                                                                               %the point is free space
                         if (CostFunction(current_x, current_y) < MinCost )
                             MinCost = CostFunction(current_x, current_y) ;
                             NextPosition(1) = current_x;
                             NextPosition(2) = current_y;
                         end
                     else
                         if (current_x == p_x && current_y == p_y)
                            if (CostFunction(current_x, current_y) < MinCost )
                             MinCost = CostFunction(current_x, current_y) ;
                             NextPosition(1) = current_x;
                             NextPosition(2) = current_y;
                            end
                         end
                     end
                 end
             end 
              particle(i).Position = NextPosition;
              %Evaluation
            particle(i).Cost = CostFunction(particle(i).Position(1), particle(i).Position(2));
            %Update Personal Best
            if (particle(i).Cost < particle(i).Best.Cost )
                particle(i).Best.Cost = particle(i).Cost;
                particle(i).Best.Position = particle(i).Position;

                %Update Global Best
                if (particle(i).Best.Cost < GlobalBest.Cost)
                    GlobalBest = particle(i).Best;
                end
            end
            %Update the map_plot
            map_plot(p_x, p_y) = 1;
            map_plot(particle(i).Position(1), particle(i).Position(2)) = 3;
        else
            %Update Velocity
            particle(i).Velocity = w*particle(i).Velocity + c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position) + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);
            FakePosition = particle(i).Position + particle(i).Velocity;
            %Get the Surrouding Positions
             neighbours = GetSurroundingPositions(particle(i).Position);
             p_x = particle(i).Position(1);
             p_y = particle(i).Position(2);
             DistanceToGlobalBest = inf;
             NextPosition =zeros(VarSize);
             for j = 1:size(neighbours, 1)
                 current_x = neighbours(j, 1);
                 current_y = neighbours(j, 2);
                 if (current_x >0 && current_x <= size(map, 1) && current_y >0 && current_y <= size(map, 1)) %the point in the field
                     if (map_plot(current_x, current_y) ==1)                                                                               %the point is free space
                         if (abs( FakePosition(1) - current_x) +abs( FakePosition(2) - current_y) <DistanceToGlobalBest )
                             DistanceToGlobalBest = abs( FakePosition(1) - current_x) +abs( FakePosition(2) - current_y);
                             NextPosition(1) = current_x;
                             NextPosition(2) = current_y;
                         end
                     else
                         if (current_x == p_x && current_y == p_y)
                             if (abs( FakePosition(1) - current_x) +abs( FakePosition(2) - current_y) <DistanceToGlobalBest )
                                 DistanceToGlobalBest = abs( FakePosition(1) - current_x) +abs( FakePosition(2) - current_y);
                                 NextPosition(1) = current_x;
                                 NextPosition(2) = current_y;
%                                  disp(NextPosition);
                             end
                         end
                     end
                 end
             end
            %Update Position
            particle(i).Position = NextPosition;

            %Evaluation
            particle(i).Cost = CostFunction(particle(i).Position(1), particle(i).Position(2));
            %Update Personal Best
            if (particle(i).Cost < particle(i).Best.Cost )
                particle(i).Best.Cost = particle(i).Cost;
                particle(i).Best.Position = particle(i).Position;

                %Update Global Best
                if (particle(i).Best.Cost < GlobalBest.Cost)
                    GlobalBest = particle(i).Best;
                end
            end
            %Update the map_plot
            map_plot(p_x, p_y) = 1;
            map_plot(particle(i).Position(1), particle(i).Position(2)) = 4;
        end
        
    end
    ShowImage(map_plot);

%    w = w * wdamp;
end
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
%             if(GoalExchangeArray(i) || GoalExchangeArray(j))
%                 break
%             end
             GoalExchange = false;
             if (isempty(setdiff(particle(i).NextPosition,  particle(j).Position)) && isempty(setdiff(particle(j).NextPosition, particle(i).Position)))
                 GoalExchange = true;
             end
             
              if (isempty(setdiff(particle(i).NextPosition, particle(j).Position)) && isempty(setdiff(particle(j).NextPosition, particle(j).Position)))
                 GoalExchange = true;
              end
             
              if (isempty(setdiff(particle(j).NextPosition, particle(i).Position)) && isempty(setdiff(particle(i).NextPosition,  particle(i).Position)))
                 GoalExchange = true;
              end
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
    if (mod(randperm(100,1), 10) > 4)
        goal_assigned = GoalAssignment(reshape([particle(1:nPop).Position], 2, nPop)', reshape([particle(1:nPop).Goal], 2, nPop)');
        for i=1:nPop
            particle(i).Goal(:) = goal_assigned(i, :); 
        end
    end
    %Display
    ShowImage(map_plot);
    %check the task is finished or not
    
end
    
        
