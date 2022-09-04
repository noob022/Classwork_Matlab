% Here we enter the commands to clear the command window, figure window and
% workspace variables respectively


clc
clf
clear


%%
% STEP 1: Create random array of +1 and -1 which will be indicative of the
% direction the ants are facing on the line--------------------------------


Random_dir = ones(1,25);

for k = 1:25
    rk = rand(1,1);
    if (rk >= 0) && (rk < 0.5)
        Random_dir(k) = -1;
    end
end


%%
% STEP 2: Determine the initial position and initial speeds of the ant. We
% have randomly generated numbers as input for speed & position of ants.
% We have two cases here:
%CASE 1: Where the ants can only take speeds of 1 cm/s.
%CASE 2: Where the ants can take speeds between 0 to 1 cm/s


Velocity_Input = [Random_dir, 0];%----------------------------------CASE 1

%Velocity_Input = [0.1*randi(10,1,25), 0].*[Random_dir, 0];%---------CASE 2

Position_Input = [sort(randperm(100,25)), 101];


%%
% STEP 3: Here we set up the initial parameters for the problem.For CASE 1,
% it is good enoung to take time step as 1 s. In CASE 2, time step has been
% taken as 0.1 s. In general the smaller time step we take the more
% accurate results we will obtain but will increase the number of
% iterations. Track_Index variable stores the index of the ant under
% investigation. In this case it is the 12th ant, Alice.


Init_Pos = Position_Input;
Init_Vel = Velocity_Input;
Time_step =    1;
Track_Index = 12;


%%
% STEP 4: Two arrays have been set up for storing the position of Alice at
% each iteration and the corresponding timestep. This is later used to plot
% the positon vs time graph for Alice.


Pos_Map = zeros(1,10000);
Time_Map = zeros(1,10000);

Curr_Pos = Init_Pos;
Curr_Vel = Init_Vel;
t = 0;
k = 1;


%%
% STEP 5: Here we run the main loop till the exit condition of having Alice
% crossing one of the two ends of the ruler. The loop updates the position 
% of each ant according to their corresponding velocity and facing.
% Update_Velocity2 is a defined function is used to detect collision 
% between two ants and change their facing accordingly.


%CASE 1:--------------------------------------------------SPEED ONLY 1 CM/S


while (Curr_Pos(Track_Index) > 0) && (Curr_Pos(Track_Index) < 100)
    
    Curr_Vel = Update_Velocity2(Curr_Pos, Curr_Vel, Time_step);
    Curr_Pos = Curr_Pos + Curr_Vel*Time_step;
    t = t + Time_step;
    
    Pos_Map(k)= Curr_Pos(Track_Index);
    Time_Map(k) = t;
    k = k+1;
    
end


%CASE 2:-----------------------------------------SPEED BETWEEN 0 AND 1 CM/S


% while sum(Curr_Vel ~= zeros(1,length(Init_Vel))) > 0
%     
%     Curr_Vel = Update_Velocity2(Curr_Pos, Curr_Vel, Time_step);
%     Curr_Pos = Curr_Pos + Curr_Vel*Time_step;
%     t = t + Time_step;
%     
% end


%%
% STEP 6: We obtain the final output by taking out the updated time and
% plotting the position vs time graph.


disp(t)%---------------------------------------------------------time taken
plot([0, Time_Map(1:k-1)], [Init_Pos(Track_Index), Pos_Map(1:k-1)])
xlabel('Time(in s)')
ylabel('Position of Alice(in cm)')


