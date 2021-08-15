%��agent��λ�ý��и���
function newrobot = renew_robot(robot,target,pattern_barrier,final_pattern,pattern_target)
    [~,num_robot] = size(robot);
    [~,num_target] = size(target);
    newrobot = robot;

    for id = 1:num_robot

        if (robot(id).alive == 1)                                   %���������
            newrobot(id).organize = iforganize(id,target,robot);      %�ж��Ƿ�����֯������
            if (newrobot(id).organize == 1)                            %�������֯������
                nearesttarget = near(target,robot(id).nowx,robot(id).nowy);
                newrobot(id).task = nearesttarget;            %����Ŀ����������˵������嵥

                newrobot(id).pattern = final_pattern;%ÿ������������ͬһ��pattern��
                newrobot(id).pattern_robot = newrobot(id).generate_robotpatt(robot);%������һ������������pattern
                newrobot(id).pattern_target = pattern_target;%���Ŀ�����ɵ�pattern
                [move,die] = robot(id).trapping(robot,target,pattern_barrier,robot(id).pattern);
            else             %���������֯�����ˣ�����֯�������˶�������ͬ
                [move,die] = robot(id).non_trapping(robot,target,pattern_barrier);    
            end
        else                 %�������                 
                move = [0,0];
                die = 1;
        end
        
        if die == 1             %�ж��Ƿ�����
            newrobot(id).alive = 0;
        end
        
        %%���Ũ�Ⱥܴ��ұ仯��С�����ı��ٶ�
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
        
        
        newrobot(id).vx = move(1); %�����ٶȺ�λ��
        newrobot(id).vy = move(2);
        newrobot(id).nowx = newrobot(id).nextx;
        newrobot(id).nowy = newrobot(id).nexty;

    end