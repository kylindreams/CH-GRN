%��ʼ����������
clear;
clc;
close all;

%% ��ʼ��������
num_robot = 20;                     %��ʼ�������ˣ���������ʼλ�á��ٶȣ�
for id = 1:num_robot
    robot(id) = Robot(id,rand()*3+8.5,rand()*3+10.5,rand(),rand(),1);
end

%% ��ʼ��Ŀ��

num_target = 1;                     %��ʼ��Ŀ�꣨��������ʼλ�á��ٶȣ�
target(1) = Target(1,10,9,0,0,1);

%% ��ʼ���ϰ�
num_barrier = 2;                     %��ʼ���ϰ�����������ʼλ�á��ٶȣ�
for id = 1:num_barrier
    barrier(id) = Barrier(id,rand(),rand(),rand(),rand(),0);
end
global obstacle
obstacle = [5.8,0,2,20;12.2,0,2,20];%խ�����ᴩ���£�
barrier(1).pointx = 4*[obstacle(1,1),obstacle(1,1),obstacle(1,1)+obstacle(1,3),obstacle(1,1)+obstacle(1,3);];                        %�������ײ�ж��Ķ���ζ��㣬һ����һ����ĺ�������
barrier(1).pointy = 4*[obstacle(1,2),obstacle(1,2)+obstacle(1,4),obstacle(1,2)+obstacle(1,4),obstacle(1,2);]; 
barrier(2).pointx = 4*[obstacle(2,1),obstacle(2,1),obstacle(2,1)+obstacle(2,3),obstacle(2,1)+obstacle(2,3);];
barrier(2).pointy = 4*[obstacle(2,2),obstacle(2,2)+obstacle(2,4),obstacle(2,2)+obstacle(2,4),obstacle(2,2);];

global cell_wid;
cell_wid = 0.25;                            %ϸ���ĳ���

%% ѭ����ͼ
N = 50;                             %ѭ������
for i = 1:N
    %�ϰ���λ�ø���
    if i<=20
        change = -0.1;%changeΪ+�Ƿֿ�
    else
        change = 0.1;
    end   
    %�ϰ���λ�ø���
    [pattern_barrier,simulation_robot,pattern_simulationrobot,barrier] = renew_barrier(barrier,change);    
    %pattern�γ�
    [final_pattern,pattern_target] = cal_pattern(target,robot,pattern_simulationrobot);
    %������λ�ø���
    robot = renew_robot(robot,target,pattern_barrier,final_pattern,pattern_target);
    %�����˶�Ŀ���Ӱ��
    target = robot_control_target(robot,target);
    %Ŀ��λ�ø���
    target = renew_target(target,i);
    %��ͼ
    Plot.plot_all(final_pattern,barrier,target,robot);
    %����ָ��
    fitness(i) = calfitness(robot,target,pattern_barrier,simulation_robot);
end