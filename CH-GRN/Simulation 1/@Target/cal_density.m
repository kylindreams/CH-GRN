%目标自己计算密度最低的方向
function  move = cal_density(target_now,robot, target, simulation_robot)
       

    density(1)=0;
    density(2)=0;
    flag = 0;
    for i=1:length(target_now.robotlist)%计算包围列表里的机器人占领的角度
        i = target_now.robotlist(i);
        disx_target = robot(i).nowx-target(robot(i).task).nowx;
        disy_target = robot(i).nowy-target(robot(i).task).nowy;
        dis = (disx_target^2 + disy_target^2)^0.5;
        density(1)=density(1)+disx_target/dis;
        density(2)=density(2)+disy_target/dis;
    end
    
    for i = 1:length(simulation_robot)      %计算模拟机器人占领的角度
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
    
    theta = atand(move(2)/move(1));     %求最终方向
    if (move(1)<0 )
        theta = theta +180;
    elseif (move(1)==0 && move(2)>0)
        theta = 90;
    elseif (move(1)==0 && move(2)<=0)
        theta = 270;
    end
    move(1) = target_now.v * cosd(theta);          %求最终速度
    move(2) = target_now.v * sind(theta);
    
    move = -move;%向密度低的方向
    if target_now.surroundingtheta >= 0.5   %如果说密度最低的角度都有agent，则目标不动了
        move = [0,0];
    end