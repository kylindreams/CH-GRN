 %目标类
classdef Barrier
   properties 
       id = 1;                %编号
       pointx = 0;              %当前横坐标
       pointy = 0;              %当前纵坐标
       vx = 0;                %当前横向速度
       vy = 0;                %当前纵向速度
       move = 0;              %是否是移动目标:0,静态目标；1,动态目标
       type = 1;              %是圆形障碍还是多边形障碍
       pattern_barrier = zeros(100);    %障碍物自个的障碍物图
   end  
   properties (Dependent, Hidden)
       nextx = 0;             %下一步横坐标
       nexty = 0;             %下一步纵坐标

   end
   
   methods  
       %构造函数
       function obj = Barrier(id, pointx, pointy, vx, vy, move) 
           obj.id = id;
           obj.pointx = pointx;
           obj.pointy = pointy;
           obj.vx = vx;
           obj.vy = vy;
           obj.move = move;
       end
       
       %查询下一步的坐标
       function value = get.nextx(obj)
           value = obj.pointx + obj.vx;
       end
       function value = get.nexty(obj)
           value = obj.pointy + obj.vy;
       end
       %生成障碍物自己的图
       function value = get.pattern_barrier(obj)
           [~,num] = size(obj.pointx);
           if num ==2
               
           elseif num>2
               np=100;
               x=[0:np];
               y=[0:np];
               [X,Y]=meshgrid(x,y);%网格化
               % 找内点
               [ind] = inpolygon(X,Y,obj.pointx,obj.pointy);

               flg_ind=double(ind);
               tm = flg_ind(1:np,:)+flg_ind(2:(np+1),:);     %上下平移叠加
               value = tm(:,1:np)+tm(:,2:(np+1));              %左右平移叠加：为1的是边界

               [num,dim] = size(value); 
               for i=1:num                 
                   for j=1:dim
                     if value(i,j) > 0
                        value(i,j) = 1;
                     end
                   end
               end
           end
       end
   end   
    methods(Static)
        value = init_barrier;
        value = myrectangle(point);
        value = generate_simulatepattern(p_captor);
        value = cal_dis(pos,i,j);
    end
end 

