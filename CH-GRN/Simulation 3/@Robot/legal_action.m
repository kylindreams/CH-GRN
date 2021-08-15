    
   %动作合法性判断：动作不合法则转为静止状态
   %动作不合法：超出任务边界或者撞上障碍
   function move = legal_action(obj,move)
       obj.vx = move(1);
       obj.vy = move(2);
       legal_nextx = obj.nowx + obj.vx;
       legal_nexty = obj.nowy + obj.vy;
       %超出任务边界的判断
       if round(legal_nextx) > 20 || round(legal_nextx) <0
           obj.vx = -obj.vx;
       end
       if round(legal_nexty) > 20 || round(legal_nexty) <0
           obj.vy = -obj.vy;
       end
       %靠近障碍物的判断：如果下一步的位置在障碍物内部，向距离障碍物最近方向的反方向移动
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
               %反射避障
               result = direction_obstacle(obj, obstacle);
               direction =result(1);
               point = result(2:3);
               if direction == 0     %靠近竖直墙面
                    move(1) = point(1) - obj.nowx;
               elseif direction == 90     %靠近水平墙面
                   move(2) = point(2) - obj.nowy;
               elseif direction == 180     %靠近竖直墙面
                    move(1) = point(1) - obj.nowx;
               elseif direction == 270     %靠近竖直墙面
                    move(2) = point(2) - obj.nowy;
               end
                   if abs(move(1)-obj.vx)>1
                       stop = 1;
                   end
           end
       end
   end
   
%计算点到障碍物的方向
%输入：坐标P，所有障碍物的顶点坐标obstacle
%输出：点到障碍物的方向
function result = direction_obstacle(obj, obstacle)
    P = [obj.nowx, obj.nowy];
    near_dis = Inf;
    near_theta = 0;
    point = [0,0];
    result = [near_theta,point];
    for i = 1:size(obstacle,1)
        obs = obstacle(i,:);
        %当前障碍物的4个顶点
        Q1 = [obs(1),obs(1)+obs(3),obs(1),obs(1)+obs(3)];%x坐标
        Q2 = [obs(2),obs(2),obs(2)+obs(4),obs(2)+obs(4)];%y坐标
        order = [1,1,4,4;2,3,2,3];
        for o = 1:4
            %当前计算的两个顶点
            T1 = [Q1(order(1,o)),Q2(order(1,o))];
            T2 = [Q1(order(2,o)),Q2(order(2,o))];
            %先判断投影点有没有在线段范围内的（计算夹角是否为钝角）
            x1=T1(1);y1=T1(2);x2=T2(1);y2=T2(2);x3=P(1);y3=P(2);
            theta1=acosd(dot([x1-x2,y1-y2],[x3-x2,y3-y2])/...
                (norm([x1-x2,y1-y2])*norm([x3-x2,y3-y2])));
            x2=T1(1);y2=T1(2);x1=T2(1);y1=T2(2);x3=P(1);y3=P(2);
            theta2=acosd(dot([x1-x2,y1-y2],[x3-x2,y3-y2])/...
                (norm([x1-x2,y1-y2])*norm([x3-x2,y3-y2])));
            theta = max(theta1, theta2);
            if theta <= 90 %如果在线段范围内，计算距离
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

%计算点到直线的距离
%输入：直线上的两点Q1,Q2;待计算的点P
%输出：最近点的距离
function d  =cal_point_line_distance(Q1,Q2,P)
    d = abs(det([Q2-Q1;P-Q1]))/norm(Q2-Q1);
end

%计算点到直线的最近点的方向
%输入：直线上的两点Q1,Q2;待计算的点P
%输出：最近点的方向
function result =cal_point_line_dirction(Q1,Q2,P)
    if Q1(1) == Q2(1) %如果横坐标相等，即斜率不存在
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

        k = x(1); %斜率
        b = x(2); %偏置
        x1 = P(1);
        y1 = P(2);

        x2 = (k*y1+x1-k*b)/(1+k*k);%投影点坐标
        y2 = k*x2+b;

        theta = direction(x1,y1,x2,y2);
        point = [x2,y2];
    end
    result = [theta,point];
end