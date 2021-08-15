       %�����ΧȦռ����
function surroundingtheta = cal_surroundingtheta(robot, target,simulation_robot,target_id)
       
% global cell_wid;
range = 10;
% [~,num_robot] = size(robot);
[~,num_target] = size(target);
theta_occupy1 = zeros(num_target,360);
theta_occupy2 = zeros(num_target,360);

for j=1:num_target
    for i=1:length(target(j).robotlist)%�����Χ�б���Ļ�����ռ��ĽǶ�
        i = target(j).robotlist(i);
        disx_target = robot(i).nowx-target(robot(i).task).nowx;
        disy_target = robot(i).nowy-target(robot(i).task).nowy;
        
        if disx_target^2 + disy_target^2 < 2.5^2      %����С��10��ƽ����ʱ����ܼ���Ϊ��Χ
            thetatemp = atand(disy_target/disx_target);            %��ǰ��Ŀ��ļн�
            if (disx_target<0 )
                thetatemp = thetatemp +180;
            elseif (disx_target==0 && disy_target>0)
                thetatemp = 90;
            elseif (disx_target==0 && disy_target<=0)
                thetatemp = 270;
            end
            thetatemp=round(thetatemp+90);
%             theta(j,i)=thetatemp;
            if thetatemp <= range
                thetatemp = range + 1;
            elseif thetatemp + range >= 360
                thetatemp = 359-range;
            end
        theta_occupy1(j,thetatemp-range:thetatemp+range)=1;
        end
    end
        
end

for j=1:num_target
    for i = 1:length(simulation_robot)      %����ģ�������ռ��ĽǶ�
        disx_target = simulation_robot(i,1)-target(j).nowx;
        disy_target = simulation_robot(i,2)-target(j).nowy;
        if disx_target^2 + disy_target^2 < 2.5^2      %����С��10��ƽ����ʱ����ܼ���Ϊ��Χ
            thetatemp = atand(disy_target/disx_target);            %��ǰ��Ŀ��ļн�
            if (disx_target<0 )
                thetatemp = thetatemp +180;
            elseif (disx_target==0 && disy_target>0)
                thetatemp = 90;
            elseif (disx_target==0 && disy_target<=0)
                thetatemp = 270;
            end
            thetatemp=round(thetatemp+90);
%             theta(j,i)=thetatemp;
            if thetatemp <= range
                thetatemp = range + 1;
            elseif thetatemp + range >= 360
                thetatemp = 359-range;
            end
        theta_occupy2(j,thetatemp-range:thetatemp+range)=1;
        end
        
        
    end
end
        theta_occupy = double(theta_occupy1 | theta_occupy2);
        surroundingtheta = sum(theta_occupy,2)/360';
%         plot_theta(theta_occupy2)
end

function plot_theta(occupy)
    figure;
    num_point = 360; 
    theta=0:2*pi/(num_point):2*pi;      %��ʼ�������˵�����ʹ������Բ��
    point(1,:)=0+10*cos(theta);
    point(2,:)=0+10*sin(theta);
    hold on;
    for ploti = 1:num_point
        t = linspace(0,2*pi,10);
        r = 0.2;
        x = r * cos(t)+point(1,ploti);             
        y = r * sin(t)+point(2,ploti);              
        plot(x,y)        
        if occupy(ploti) == 1
            fill(x,y,'b')
        else
%             fill(x,y,[0.8,0.8,0.8])
        end
    end
end