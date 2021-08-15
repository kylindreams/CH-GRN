       %�����ΧȦռ����
function surroundingtheta = cal_surroundingtheta(robot, target,simulation_robot,target_id)
       
% global cell_wid;
range = 10;
[~,num_robot] = size(robot);
[~,num_target] = size(target);
theta_occupy1 = zeros(num_target,360);
theta_occupy2 = zeros(num_target,360);

for j=1:num_target
%     for i=1:length(target(j).robotlist)%�����Χ�б���Ļ�����ռ��ĽǶ�
    for i=1:num_robot
        disx_target = robot(i).nowx-target(j).nowx;
        disy_target = robot(i).nowy-target(j).nowy;
        
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
           
end