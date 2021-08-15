%��ʼ����������
clear;
clc;
close all;

%% ��ʼ��������
num_robot = 40;                     %��ʼ�������ˣ���������ʼλ�á��ٶȣ�
for id = 1:num_robot
    robot(id) = Robot(id,rand(),rand(),rand(),rand(),1);
end
theta=0:2*pi/(num_robot):2*pi;      %��ʼ�������˵�����ʹ������Բ��
temp1(1,:)=10+10*cos(theta);
temp1(2,:)=10+10*sin(theta);
temp1(:,1)=[];
for id = 1:num_robot
    robot(id).nowx = temp1(1,id);
    robot(id).nowy = temp1(2,id);
end

%% ��ʼ��Ŀ��
num_target = 3;                     %��ʼ��Ŀ�꣨��������ʼλ�á��ٶȣ�
target(1) = Target(1,9,14.2,0,0,1);
target(2) = Target(2,6,7.5,0,0,1);
target(3) = Target(3,14.5,4,0,0,1);

%% ��ʼ���ϰ�
num_barrier = 3;                     %��ʼ���ϰ�����������ʼλ�á��ٶȣ�
for id = 1:num_barrier
    barrier(id) = Barrier(id,rand(),rand(),rand(),rand(),0);
end
barrier(1).pointx = 4*[4,8,5;];                        %�������ײ�ж��Ķ���ζ��㣬һ����һ����ĺ�������
barrier(1).pointy = 4*[4,4,8;]; 
barrier(2).pointx = 4*[15,17,17,15;];
barrier(2).pointy = 4*[4,4,13,13;];
barrier(3).pointx = 4*[4,4,10,10;];
barrier(3).pointy = 4*[15,17,17,15;];
simulation_robot = Barrier.init_barrier;
pattern_simulationrobot = Barrier.generate_simulatepattern(simulation_robot);      

%�ϰ���λ�ø���
pattern_barrier = renew_barrier(barrier);    

global cell_wid;
cell_wid = 0.25;                            %ϸ���ĳ���

%% ѭ����ͼ
N = 50;                             %ѭ������
for i = 1:N
    clf
    %pattern�γ�
    [final_pattern,pattern_target] = cal_pattern(target,robot,pattern_simulationrobot);
    %������λ�ø���
    robot = renew_robot(robot,target,pattern_barrier,final_pattern,pattern_target);
    %�����˶�Ŀ���Ӱ��
    target = robot_control_target(robot,target);
    %Ŀ��λ�ø���
    target = renew_target(target,i,robot,simulation_robot);
    %��ͼ
    Plot.plot_contour(final_pattern);
    Plot.plot_background();
    Plot.plot_barrier(barrier);
    Plot.plot_target(target);
    Plot.plot_organize(robot);
    Plot.plot_nonorganize(robot);
    hold off
    pause(0.03);
    %����ָ��
    fitness(i) = calfitness(robot,target,pattern_barrier,simulation_robot);
end