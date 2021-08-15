       %�����Χǿ��
       function surroundingstrength = cal_surroundingstrength(robot, target,pattern_barrier,target_id)
       
       global cell_wid;
       range = 1;
       judgementgrid = 0;
    [~,num_robot] = size(robot);
      surroundingstrength = 0;
       %������һ����ͼ
       pattern_all = pattern_barrier*1.5;%�ϰ�ֵ����Ϊ1.5
       
    for id = 1:num_robot
        xaxis = round(robot(id).nowx/cell_wid);   %��ǰ����
        yaxis = round(robot(id).nowy/cell_wid);
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
                if ((cell_wid*(xxx-0.5)-robot(id).nowx)^2+(cell_wid*(yyy-0.5)-robot(id).nowy)^2)^0.5 < robot(id).size
                    pattern_all(xxx,yyy) = 1;       %������ֵ����Ϊ1
                end
            end
       end
    end
       %Ȼ�������Ӧ��Ŀ��İ�Χǿ��
       alpha1 = 3;          %��һ���߽�
       alpha2 = 5;          %�ڶ����߽�
       alpha3 = 6;          %�������߽�
        xaxis = round(target(target_id).nowx/cell_wid);   %��ǰ����
        yaxis = round(target(target_id).nowy/cell_wid);
            for xxx = xaxis-alpha3:xaxis+alpha3
                for yyy = yaxis-alpha3:yaxis+alpha3
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
                    distance_centertarget = ((cell_wid*(xxx-0.5)-target(target_id).nowx)^2+(cell_wid*(yyy-0.5)-target(target_id).nowy)^2)^0.5;
                    if distance_centertarget < alpha3
                        judgementgrid = judgementgrid + 1;
                    end
                    if pattern_all(xxx,yyy) ~= 0          %��������������Ч��Χ
                        if distance_centertarget < alpha2 && distance_centertarget > alpha1 %�����������������Ч��Χ����
                            surroundingstrength = surroundingstrength + 2*pattern_all(xxx,yyy);
                        elseif distance_centertarget < alpha3 && distance_centertarget > alpha2 %��Ȧ
                            surroundingstrength = surroundingstrength + 1*pattern_all(xxx,yyy);
                        elseif distance_centertarget < alpha1  %��Ȧ
                            surroundingstrength = surroundingstrength + 1*pattern_all(xxx,yyy);
                        end
                    end
                end
            end
            surroundingstrength = surroundingstrength / (judgementgrid*1.5);
          
            
        end