%初始化及主函数
clear;
clc;
close all;

%% 初始化机器人
num_robot = 20;                     %初始化机器人（数量、初始位置、速度）
for id = 1:num_robot
    robot(id) = Robot(id,rand()*3+8.5,rand()*3+10.5,rand(),rand(),1);
end

%% 初始化目标

num_target = 1;                     %初始化目标（数量、初始位置、速度）
target(1) = Target(1,10,9,0,0,1);

%% 初始化障碍
num_barrier = 2;                     %初始化障碍（数量、初始位置、速度）
for id = 1:num_barrier
    barrier(id) = Barrier(id,rand(),rand(),rand(),rand(),0);
end
global obstacle
obstacle = [5.8,0,2,20;12.2,0,2,20];%窄道（贯穿上下）
barrier(1).pointx = 4*[obstacle(1,1),obstacle(1,1),obstacle(1,1)+obstacle(1,3),obstacle(1,1)+obstacle(1,3);];                        %这边是碰撞判定的多边形顶点，一列是一个点的横纵坐标
barrier(1).pointy = 4*[obstacle(1,2),obstacle(1,2)+obstacle(1,4),obstacle(1,2)+obstacle(1,4),obstacle(1,2);]; 
barrier(2).pointx = 4*[obstacle(2,1),obstacle(2,1),obstacle(2,1)+obstacle(2,3),obstacle(2,1)+obstacle(2,3);];
barrier(2).pointy = 4*[obstacle(2,2),obstacle(2,2)+obstacle(2,4),obstacle(2,2)+obstacle(2,4),obstacle(2,2);];

global cell_wid;
cell_wid = 0.25;                            %细胞的长宽

%% 循环绘图
N = 50;                             %循环次数
for i = 1:N
    %障碍物位置更新
    if i<=20
        change = -0.1;%change为+是分开
    else
        change = 0.1;
    end   
    %障碍物位置更新
    [pattern_barrier,simulation_robot,pattern_simulationrobot,barrier] = renew_barrier(barrier,change);    
    %pattern形成
    [final_pattern,pattern_target] = cal_pattern(target,robot,pattern_simulationrobot);
    %机器人位置更新
    robot = renew_robot(robot,target,pattern_barrier,final_pattern,pattern_target);
    %机器人对目标的影响
    target = robot_control_target(robot,target);
    %目标位置更新
    target = renew_target(target,i);
    %画图
    Plot.plot_all(final_pattern,barrier,target,robot);
    %计算指标
    fitness(i) = calfitness(robot,target,pattern_barrier,simulation_robot);
end