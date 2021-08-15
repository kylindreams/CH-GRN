%��֯�����˵��˶����򣺸������ص��ۺ�
function [move,die] = trapping(captor_now,robot,target,pattern_barrier,pattern) 
  %% ��ʼ��

    flag1 = 0;                               %ϵ�����Ƿ�����������
    flag2 = 0;
    
    acceleration=zeros(6,2);                 %Ӱ�����ӡ�Զ��Ŀ�꣬Զ��ͬ�࣬����Ŀ�꣬����g3����,ȥ�ܶȵ͵ķ��򣬱��ϡ�
    factor=[5,1,1,1,1,1];                     %Ĭ��ʹ�ù���1
    [~,num_target] = size(target); 
    [~,num_robot] = size(robot); 
        xaxis = fix(captor_now.nowx/0.25)+1;   %��ǰ����
        yaxis = fix(captor_now.nowy/0.25)+1;
        
%% ��Ŀ�갲ȫ��������:����Զ��
    for i=1:num_target
        if(((captor_now.nowx-target(i).nowx)^2+(captor_now.nowy-target(i).nowy)^2)^0.5 <  captor_now.distent_fish )
            acceleration(1,1) = acceleration(1,1) + (captor_now.nowx-target(i).nowx)/((captor_now.nowx-target(i).nowx)^2+(captor_now.nowy-target(i).nowy)^2)^0.5;
            acceleration(1,2) = acceleration(1,2) + (captor_now.nowy-target(i).nowy)/((captor_now.nowx-target(i).nowx)^2+(captor_now.nowy-target(i).nowy)^2)^0.5;  
            flag1 = flag1 + 1;
        end
    end
        if flag1~=0                                              %�������:���ٶȹ�һ
                acceleration(1,1) = acceleration(1,1)/flag1/2;
                acceleration(1,2) = acceleration(1,2)/flag1/2;
        end
    
%% ����Χ�����˰�ȫ��������:����Զ��     
    for i=1:num_robot
        if(i~=captor_now.id)                            %���ж��Լ�
            if(((captor_now.nowx-robot(i).nowx)^2+(captor_now.nowy-robot(i).nowy)^2)^0.5 < captor_now.distent_capter)
                acceleration(2,1) = acceleration(2,1) + (captor_now.nowx-robot(i).nowx)/((captor_now.nowx-robot(i).nowx)^2+(captor_now.nowy-robot(i).nowy)^2)^0.5;
                acceleration(2,2) = acceleration(2,2) + (captor_now.nowy-robot(i).nowy)/((captor_now.nowx-robot(i).nowx)^2+(captor_now.nowy-robot(i).nowy)^2)^0.5;
                flag2 = flag2 + 1;
            end
        end
    end
        if flag2~=0                                              %�������
            acceleration(2,1) = acceleration(2,1)/flag2/2;
            acceleration(2,2) = acceleration(2,2)/flag2/2;
        end
        
%% ��Ŀ��ǰ�� 
    nearfish = near(target, captor_now.nowx, captor_now.nowy);      %�������Ŀ��
   % if(flag==0)         %���Ȳ����ڰ�ȫ��Χ�ڣ�Ȼ������ƶ�
        if(xaxis>0 && yaxis>0 && xaxis<101 && yaxis<101)
            acceleration(3,1) = acceleration(3,1) - (captor_now.nowx-target(nearfish).nowx)/((captor_now.nowx-target(nearfish).nowx)^2+(captor_now.nowy-target(nearfish).nowy)^2)^0.5;
            acceleration(3,2) = acceleration(3,2) - (captor_now.nowy-target(nearfish).nowy)/((captor_now.nowx-target(nearfish).nowx)^2+(captor_now.nowy-target(nearfish).nowy)^2)^0.5;
           % flag = flag + factor(3);
        else
            acceleration(3,1) = 0;
            acceleration(3,2) = 0;
        end

%% ��̽�ⷶΧ��patternŨ�ȸ��ҽ��ĵ�ǰ��
        distance_nearfish=((captor_now.nowx-target(nearfish).nowx)^2+(captor_now.nowy-target(nearfish).nowy)^2)^0.5;
        if (xaxis>0 && yaxis>0 && xaxis<101 && yaxis<101 && distance_nearfish<1.25)
%         if (xaxis>0 && yaxis>0 && xaxis<101 && yaxis<101)
            range = 0;
            unfind = 0;
            while unfind ~= 1 && range < 10
                bigg3 = [];
                range = range + 3;
            for xxx = xaxis-range:xaxis+range
                for yyy = yaxis-range:yaxis+range
                    if xxx < 1
                        xxx=1;
                    end
                    if yyy < 1
                        yyy=1;
                    end
                    if xxx >100
                        xxx=100;
                    end
                    if yyy > 100
                        yyy=100;
                    end
                    bigg3=[bigg3;xxx,yyy,pattern(xxx,yyy)];
                end
            end
            [~,big]=max(bigg3(:,3));
%             unfind = length(unique(bigg3(:,3)));
            end
            bigg3(:,1) = bigg3(:,1)*0.25;
            bigg3(:,2) = bigg3(:,2)*0.25;
            acceleration(4,1) = acceleration(4,1) - (captor_now.nowx-bigg3(big,1))/((captor_now.nowx-bigg3(big,1))^2+(captor_now.nowy-bigg3(big,2))^2)^0.5;
            acceleration(4,2) = acceleration(4,2) - (captor_now.nowy-bigg3(big,2))/((captor_now.nowx-bigg3(big,1))^2+(captor_now.nowy-bigg3(big,2))^2)^0.5;

        end
    %% ���ܶȵ͵ķ���ǰ��
    flag5 = 0;
    density(1)=0;
    density(2)=0;
        for i=1:num_robot
            if(i~=captor_now.id)                            %���ж��Լ�
                if(((captor_now.nowx-robot(i).nowx)^2+(captor_now.nowy-robot(i).nowy)^2)^0.5 < captor_now.distent_detect/2)
                    density(1)=density(1)+(captor_now.nowx-robot(i).nowx)/((captor_now.nowx-robot(i).nowx)^2+(captor_now.nowy-robot(i).nowy)^2)^0.5;
                    density(2)=density(2)+(captor_now.nowy-robot(i).nowy)/((captor_now.nowx-robot(i).nowx)^2+(captor_now.nowy-robot(i).nowy)^2)^0.5;
                    flag5 = flag5+1;

                end
            end
        end
        if flag5~=0
            density(1)=density(1)/flag5;
            density(2)=density(2)/flag5;
          %  flag = flag+factor(5);
        end

        acceleration(5,1) = acceleration(5,1) + density(1);
        acceleration(5,2) = acceleration(5,2) + density(2);
        

   % end
    %% ���ݸ����ٶ��������ƶ�����
    move = zeros(1,2);                  %��ÿ���ٶȼ�Ȩ���
    for p=1:5
        move = move + factor(p)*acceleration(p,:);
    end

    
    [a,die] = avoiding_die(robot,move,captor_now.id,pattern_barrier,target);
    acceleration(6,1) = a(1);
    acceleration(6,2) = a(2);
    
    move(1) = acceleration(6,1);
    move(2) = acceleration(6,2);
    
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
    
    
    
    


