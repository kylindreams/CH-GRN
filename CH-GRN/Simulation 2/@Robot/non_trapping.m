%非组织机器人的运动规则：跟随旁边的机器人
function [move,die] = non_trapping(captor_now,robot,target,pattern_barrier)
  %% 初始化

    flag1 = 0;                               %系数：是否存在这种情况
    flag2 = 0;
    flag3 = 0;
    
    acceleration=zeros(6,2);                 %影响因子【远离目标，远离同类，跟随目标，跟随g3最大的,去密度低的方向，避障】
    factors=[1,1,1,10;
            1,1,0,10;
            0,0,1,10];               
        
    factor=factors(1,:);                     %默认使用规则1
  %  factor=[1 1 1 0 0.5];                         %影响因子【远离目标，远离同类，跟随目标，跟随g3最大的,去密度低的方向】
    [~,num_target] = size(target); 
    [~,num_robot] = size(robot);
    %% 在目标安全距离以内:立即远离
    for j=1:num_target
        if(((captor_now.nowx-target(j).nowx)^2+(captor_now.nowy-target(j).nowy)^2)^0.5 < captor_now.distent_fish )
            acceleration(1,1) = acceleration(1,1) + (captor_now.nowx-target(j).nowx)/((captor_now.nowx-target(j).nowx)^2+(captor_now.nowy-target(j).nowy)^2)^0.5;
            acceleration(1,2) = acceleration(1,2) + (captor_now.nowy-target(j).nowy)/((captor_now.nowx-target(j).nowx)^2+(captor_now.nowy-target(j).nowy)^2)^0.5;  
            flag1 = flag1 + 1;
        end
    end
        if flag1~=0                                              %如果存在:加速度归一
                acceleration(1,1) = acceleration(1,1)/flag1/2;
                acceleration(1,2) = acceleration(1,2)/flag1/2;
                factor=factors(2,:);                             %使用规则2
        end
    
%% 在周围机器人安全距离以内:立即远离     
    for j=1:num_robot
        if(j~=captor_now.id)                            %不判断自己
            if(((captor_now.nowx-robot(j).nowx)^2+(captor_now.nowy-robot(j).nowy)^2)^0.5 < captor_now.distent_capter)
                acceleration(2,1) = acceleration(2,1) + (captor_now.nowx-robot(j).nowx)/((captor_now.nowx-robot(j).nowx)^2+(captor_now.nowy-robot(j).nowy)^2)^0.5;
                acceleration(2,2) = acceleration(2,2) + (captor_now.nowy-robot(j).nowy)/((captor_now.nowx-robot(j).nowx)^2+(captor_now.nowy-robot(j).nowy)^2)^0.5;
                flag2 = flag2 + 1;
            end
        end
    end
        if flag2~=0                                              %如果存在
            acceleration(2,1) = acceleration(2,1)/flag2/2;
            acceleration(2,2) = acceleration(2,2)/flag2/2;
            factor=factors(2,:);                             %使用规则2
        end
        
%% 在探测范围内：跟随，等于邻居们的方向矢量和
%if(flag==0)
        for j=1:num_robot
            if(j~=captor_now.id && (robot(j).organize==1)    )                            %不判断自己，并且只跟随组织机器人
                if(((captor_now.nowx-robot(j).nowx)^2+(captor_now.nowy-robot(j).nowy)^2)^0.5 < captor_now.distent_detect)
                    acceleration(3,1) = acceleration(3,1) + robot(j).vx;
                    acceleration(3,2) = acceleration(3,2) + robot(j).vy;
                    flag3 = flag3 + 1;
                end
            end
        end
        if flag3~=0
            acceleration(3,1)=acceleration(1)/flag3;               
            acceleration(3,2)=acceleration(2)/flag3;
        end
%end


    %% 根据各个速度求最终移动方向
    move = zeros(1,2);                  %给每个速度加权求和
    for p=1:3
        move = move + factor(p)*acceleration(p,:);
    end
    
    [a,die] = avoiding_die(robot,move,captor_now.id,pattern_barrier,target);
    acceleration(4,1) = a(1);
    acceleration(4,2) = a(2);
    
    move = zeros(1,2);                  %加上避障后，给每个速度加权求和
    for p=1:4
        move = move + factor(p)*acceleration(p,:);
    end

    
    theta = atand(move(2)/move(1));     %求最终方向
    if (move(1)<0 )
        theta = theta +180;
    elseif (move(1)==0 && move(2)>0)
        theta = 90;
    elseif (move(1)==0 && move(2)<=0)
        theta = 270;
    end
    move(1) = captor_now.v * cosd(theta);          %求最终速度
    move(2) = captor_now.v * sind(theta);
    