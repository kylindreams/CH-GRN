%Ŀ���Լ������ܶ���͵ķ���
function  move = cal_density(target_now,robot, target, simulation_robot)
       

    density(1)=0;
    density(2)=0;
    flag = 0;
    for i=1:length(target_now.robotlist)%�����Χ�б���Ļ�����ռ��ĽǶ�
        i = target_now.robotlist(i);
        disx_target = robot(i).nowx-target(robot(i).task).nowx;
        disy_target = robot(i).nowy-target(robot(i).task).nowy;
        dis = (disx_target^2 + disy_target^2)^0.5;
        density(1)=density(1)+disx_target/dis;
        density(2)=density(2)+disy_target/dis;
    end
    
    for i = 1:length(simulation_robot)      %����ģ�������ռ��ĽǶ�
        disx_target = simulation_robot(i,1)-target_now.nowx;
        disy_target = simulation_robot(i,1)-target_now.nowy;
        dis = (disx_target^2 + disy_target^2)^0.5;
        if dis < 2.5
        density(1)=density(1)+disx_target/dis;
        density(2)=density(2)+disy_target/dis;
        flag = flag+1;
        end
    end
    move = density/(length(target_now.robotlist)+flag);
    
    theta = atand(move(2)/move(1));     %�����շ���
    if (move(1)<0 )
        theta = theta +180;
    elseif (move(1)==0 && move(2)>0)
        theta = 90;
    elseif (move(1)==0 && move(2)<=0)
        theta = 270;
    end
    move(1) = target_now.v * cosd(theta);          %�������ٶ�
    move(2) = target_now.v * sind(theta);
    
    move = -move;%���ܶȵ͵ķ���
    if target_now.surroundingtheta >= 0.5   %���˵�ܶ���͵ĽǶȶ���agent����Ŀ�겻����
        move = [0,0];
    end