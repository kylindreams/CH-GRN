%����֯�����˵��˶����򣺸����ԱߵĻ�����
function [move,die] = non_trapping(captor_now,robot,target,pattern_barrier)
  %% ��ʼ��

    flag1 = 0;                               %ϵ�����Ƿ�����������
    flag2 = 0;
    flag3 = 0;
    
    acceleration=zeros(6,2);                 %Ӱ�����ӡ�Զ��Ŀ�꣬Զ��ͬ�࣬����Ŀ�꣬����g3����,ȥ�ܶȵ͵ķ��򣬱��ϡ�
    factors=[1,1,1,10;
            1,1,0,10;
            0,0,1,10];               
        
    factor=factors(1,:);                     %Ĭ��ʹ�ù���1
  %  factor=[1 1 1 0 0.5];                         %Ӱ�����ӡ�Զ��Ŀ�꣬Զ��ͬ�࣬����Ŀ�꣬����g3����,ȥ�ܶȵ͵ķ���
    [~,num_target] = size(target); 
    [~,num_robot] = size(robot);
    %% ��Ŀ�갲ȫ��������:����Զ��
    for j=1:num_target
        if(((captor_now.nowx-target(j).nowx)^2+(captor_now.nowy-target(j).nowy)^2)^0.5 < captor_now.distent_fish )
            acceleration(1,1) = acceleration(1,1) + (captor_now.nowx-target(j).nowx)/((captor_now.nowx-target(j).nowx)^2+(captor_now.nowy-target(j).nowy)^2)^0.5;
            acceleration(1,2) = acceleration(1,2) + (captor_now.nowy-target(j).nowy)/((captor_now.nowx-target(j).nowx)^2+(captor_now.nowy-target(j).nowy)^2)^0.5;  
            flag1 = flag1 + 1;
        end
    end
        if flag1~=0                                              %�������:���ٶȹ�һ
                acceleration(1,1) = acceleration(1,1)/flag1/2;
                acceleration(1,2) = acceleration(1,2)/flag1/2;
                factor=factors(2,:);                             %ʹ�ù���2
        end
    
%% ����Χ�����˰�ȫ��������:����Զ��     
    for j=1:num_robot
        if(j~=captor_now.id)                            %���ж��Լ�
            if(((captor_now.nowx-robot(j).nowx)^2+(captor_now.nowy-robot(j).nowy)^2)^0.5 < captor_now.distent_capter)
                acceleration(2,1) = acceleration(2,1) + (captor_now.nowx-robot(j).nowx)/((captor_now.nowx-robot(j).nowx)^2+(captor_now.nowy-robot(j).nowy)^2)^0.5;
                acceleration(2,2) = acceleration(2,2) + (captor_now.nowy-robot(j).nowy)/((captor_now.nowx-robot(j).nowx)^2+(captor_now.nowy-robot(j).nowy)^2)^0.5;
                flag2 = flag2 + 1;
            end
        end
    end
        if flag2~=0                                              %�������
            acceleration(2,1) = acceleration(2,1)/flag2/2;
            acceleration(2,2) = acceleration(2,2)/flag2/2;
            factor=factors(2,:);                             %ʹ�ù���2
        end
        
%% ��̽�ⷶΧ�ڣ����棬�����ھ��ǵķ���ʸ����
%if(flag==0)
        for j=1:num_robot
            if(j~=captor_now.id && (robot(j).organize==1)    )                            %���ж��Լ�������ֻ������֯������
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


    %% ���ݸ����ٶ��������ƶ�����
    move = zeros(1,2);                  %��ÿ���ٶȼ�Ȩ���
    for p=1:3
        move = move + factor(p)*acceleration(p,:);
    end
    
    [a,die] = avoiding_die(robot,move,captor_now.id,pattern_barrier,target);
    acceleration(4,1) = a(1);
    acceleration(4,2) = a(2);
    
    move = zeros(1,2);                  %���ϱ��Ϻ󣬸�ÿ���ٶȼ�Ȩ���
    for p=1:4
        move = move + factor(p)*acceleration(p,:);
    end

    
    theta = atand(move(2)/move(1));     %�����շ���
    if (move(1)<0 )
        theta = theta +180;
    elseif (move(1)==0 && move(2)>0)
        theta = 90;
    elseif (move(1)==0 && move(2)<=0)
        theta = 270;
    end
    move(1) = captor_now.v * cosd(theta);          %�������ٶ�
    move(2) = captor_now.v * sind(theta);
    