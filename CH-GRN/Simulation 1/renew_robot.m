%对agent的位置进行更新
function newrobot = renew_robot(robot,target,pattern_barrier,final_pattern,pattern_target)
    [~,num_robot] = size(robot);
    [~,num_target] = size(target);
    newrobot = robot;

    for id = 1:num_robot

        if (robot(id).alive == 1)                                   %如果还活着
            newrobot(id).organize = iforganize(id,target,robot);      %判断是否是组织机器人
            if (newrobot(id).organize == 1)                            %如果是组织机器人
                nearesttarget = near(target,robot(id).nowx,robot(id).nowy);
                newrobot(id).task = nearesttarget;            %将该目标列入机器人的任务清单

                newrobot(id).pattern = final_pattern;%每个机器人先用同一个pattern吧
                newrobot(id).pattern_robot = newrobot(id).generate_robotpatt(robot);%根据上一步生产机器人pattern
                newrobot(id).pattern_target = pattern_target;%针对目标生成的pattern
                [move,die] = robot(id).trapping(robot,target,pattern_barrier,robot(id).pattern);
            else             %如果不是组织机器人：与组织机器人运动方向相同
                [move,die] = robot(id).non_trapping(robot,target,pattern_barrier);    
            end
        else                 %如果死了                 
                move = [0,0];
                die = 1;
        end
        
        if die == 1             %判断是否死亡
            newrobot(id).alive = 0;
        end
        
        %%如果浓度很大且变化很小，不改变速度
        xaxis = min(max(1, round(newrobot(id).nowx/0.25)),80);
        yaxis = min(max(1, round(newrobot(id).nowy/0.25)),80);
        pattern_now = newrobot(id).pattern_robot+newrobot(id).pattern_target(xaxis,yaxis);
        if pattern_now > 0.9
            pattern_new = newrobot(id).pattern_target(xaxis,yaxis);
            pattern_old = robot(id).pattern_target(xaxis,yaxis);
                if pattern_new-pattern_old < 0.1
                    move = [0,0];
                end
        end
        
        
        newrobot(id).vx = move(1); %更新速度和位置
        newrobot(id).vy = move(2);
        newrobot(id).nowx = newrobot(id).nextx;
        newrobot(id).nowy = newrobot(id).nexty;

    end