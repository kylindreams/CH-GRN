    
   %�����Ϸ����жϣ��������Ϸ���תΪ��ֹ״̬
   %�������Ϸ�����������߽����ײ���ϰ�
   function move = legal_action(obj,move)
       obj.vx = move(1);
       obj.vy = move(2);
       legal_nextx = obj.nowx + obj.vx;
       legal_nexty = obj.nowy + obj.vy;
       %��������߽���ж�
       if round(legal_nextx) > 20 || round(legal_nextx) <0
           obj.vx = -obj.vx;
       end
       if round(legal_nexty) > 20 || round(legal_nexty) <0
           obj.vy = -obj.vy;
       end
       %�����ϰ�����жϣ������һ����λ�����ϰ����ڲ���������ϰ����������ķ������ƶ�
       legal_nextx = min(max(1, obj.nowx + obj.vx),20);
       legal_nexty = min(max(1, obj.nowy + obj.vy),20);
       
        global obstacle
       for i = 1:size(obstacle,1)
           min_x = obstacle(i,1);
           min_y = obstacle(i,2);
           l_x = obstacle(i,3);
           l_y = obstacle(i,4);
           if legal_nextx > min_x && legal_nextx < min_x+l_x &&...
                   legal_nexty > min_y && legal_nexty < min_y+l_y
               %�������
               result = direction_obstacle(obj, obstacle);
               direction =result(1);
               point = result(2:3);
               if direction == 0     %������ֱǽ��
                    move(1) = point(1) - obj.nowx;
               elseif direction == 90     %����ˮƽǽ��
                   move(2) = point(2) - obj.nowy;
               elseif direction == 180     %������ֱǽ��
                    move(1) = point(1) - obj.nowx;
               elseif direction == 270     %������ֱǽ��
                    move(2) = point(2) - obj.nowy;
               end
                   if abs(move(1)-obj.vx)>1
                       stop = 1;
                   end
           end
       end
   end
   
%����㵽�ϰ���ķ���
%���룺����P�������ϰ���Ķ�������obstacle
%������㵽�ϰ���ķ���
function result = direction_obstacle(obj, obstacle)
    P = [obj.nowx, obj.nowy];
    near_dis = Inf;
    near_theta = 0;
    point = [0,0];
    result = [near_theta,point];
    for i = 1:size(obstacle,1)
        obs = obstacle(i,:);
        %��ǰ�ϰ����4������
        Q1 = [obs(1),obs(1)+obs(3),obs(1),obs(1)+obs(3)];%x����
        Q2 = [obs(2),obs(2),obs(2)+obs(4),obs(2)+obs(4)];%y����
        order = [1,1,4,4;2,3,2,3];
        for o = 1:4
            %��ǰ�������������
            T1 = [Q1(order(1,o)),Q2(order(1,o))];
            T2 = [Q1(order(2,o)),Q2(order(2,o))];
            %���ж�ͶӰ����û�����߶η�Χ�ڵģ�����н��Ƿ�Ϊ�۽ǣ�
            x1=T1(1);y1=T1(2);x2=T2(1);y2=T2(2);x3=P(1);y3=P(2);
            theta1=acosd(dot([x1-x2,y1-y2],[x3-x2,y3-y2])/...
                (norm([x1-x2,y1-y2])*norm([x3-x2,y3-y2])));
            x2=T1(1);y2=T1(2);x1=T2(1);y1=T2(2);x3=P(1);y3=P(2);
            theta2=acosd(dot([x1-x2,y1-y2],[x3-x2,y3-y2])/...
                (norm([x1-x2,y1-y2])*norm([x3-x2,y3-y2])));
            theta = max(theta1, theta2);
            if theta <= 90 %������߶η�Χ�ڣ��������
                dis = cal_point_line_distance(T1,T2,P);
                if dis < near_dis
                    near_T1 = T1;
                    near_T2 = T2;
                    near_dis = dis;
                end
            end
        end
    end
    if near_dis ~= Inf
        result = cal_point_line_dirction(near_T1,near_T2,P);
    end
end

%����㵽ֱ�ߵľ���
%���룺ֱ���ϵ�����Q1,Q2;������ĵ�P
%����������ľ���
function d  =cal_point_line_distance(Q1,Q2,P)
    d = abs(det([Q2-Q1;P-Q1]))/norm(Q2-Q1);
end

%����㵽ֱ�ߵ������ķ���
%���룺ֱ���ϵ�����Q1,Q2;������ĵ�P
%����������ķ���
function result =cal_point_line_dirction(Q1,Q2,P)
    if Q1(1) == Q2(1) %�����������ȣ���б�ʲ�����
        if Q1(1)-P(1) > 0
            theta = 0;
        else
            theta = 180;
        end
        point = [Q1(1),P(2)];
    else
        a = [Q1(1) 1; Q2(1) 1];
        b = [Q1(2) ; Q2(2)];
        x = a\b;

        k = x(1); %б��
        b = x(2); %ƫ��
        x1 = P(1);
        y1 = P(2);

        x2 = (k*y1+x1-k*b)/(1+k*k);%ͶӰ������
        y2 = k*x2+b;

        theta = direction(x1,y1,x2,y2);
        point = [x2,y2];
    end
    result = [theta,point];
end