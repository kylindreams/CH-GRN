%初始化及主函数
clear;
clc;
close all;

%% 初始化机器人
num_robot = 40;                     %初始化机器人（数量、初始位置、速度）
for id = 1:num_robot
    robot(id) = Robot(id,rand(),rand(),rand(),rand(),1);
end
theta=0:2*pi/(num_robot):2*pi;      %初始化机器人的坐标使它们在圆上
temp1(1,:)=10+10*cos(theta);
temp1(2,:)=10+10*sin(theta);
temp1(:,1)=[];
for id = 1:num_robot
    robot(id).nowx = temp1(1,id);
    robot(id).nowy = temp1(2,id);
end

%% 初始化目标
num_target = 3;                     %初始化目标（数量、初始位置、速度）
target(1) = Target(1,9,14.2,0,0,1);
target(2) = Target(2,6,7.5,0,0,1);
target(3) = Target(3,14.5,4,0,0,1);

%% 初始化障碍
num_barrier = 3;                     %初始化障碍（数量、初始位置、速度）
for id = 1:num_barrier
    barrier(id) = Barrier(id,rand(),rand(),rand(),rand(),0);
end
barrier(1).pointx = 4*[4,8,5;];                        %这边是碰撞判定的多边形顶点，一列是一个点的横纵坐标
barrier(1).pointy = 4*[4,4,8;]; 
barrier(2).pointx = 4*[15,17,17,15;];
barrier(2).pointy = 4*[4,4,13,13;];
barrier(3).pointx = 4*[4,4,10,10;];
barrier(3).pointy = 4*[15,17,17,15;];
simulation_robot = Barrier.init_barrier;
pattern_simulationrobot = Barrier.generate_simulatepattern(simulation_robot);      

%障碍物位置更新
pattern_barrier = renew_barrier(barrier);    

global cell_wid;
cell_wid = 0.25;                            %细胞的长宽

%% 循环绘图
N = 50;                             %循环次数
for i = 1:N
    clf
    %pattern形成
    [final_pattern,pattern_target] = cal_pattern(target,robot,pattern_simulationrobot);
    %机器人位置更新
    robot = renew_robot(robot,target,pattern_barrier,final_pattern,pattern_target);
    %机器人对目标的影响
    target = robot_control_target(robot,target);
    %目标位置更新
    target = renew_target(target,i,robot,simulation_robot);
    %画图
    Plot.plot_contour(final_pattern);
    Plot.plot_background();
    Plot.plot_barrier(barrier);
    Plot.plot_target(target);
    Plot.plot_organize(robot);
    Plot.plot_nonorganize(robot);
    hold off
    pause(0.03);
    %计算指标
    fitness(i) = calfitness(robot,target,pattern_barrier,simulation_robot);
end