 %目标类
classdef Target
   properties 
       id = 1;                %编号
       nowx = 0;              %当前横坐标
       nowy = 0;              %当前纵坐标
       vx = 0;                %当前横向速度
       vy = 0;                %当前纵向速度
       move = 0;              %是否是移动目标:0,静态目标；1,动态目标
       type = 1;
       robotlist = [];        %正在包围的机器人列表
   end  
   properties (Dependent, Hidden)
       nextx = 0;             %下一步横坐标
       nexty = 0;             %下一步纵坐标

   end
   
   methods  
       %构造函数
       function obj = Target(id, nowx, nowy, vx, vy, move) 
           obj.id = id;
           obj.nowx = nowx;
           obj.nowy = nowy;
           obj.vx = vx;
           obj.vy = vy;
           obj.move = move;
       end
       
       %查询下一步的坐标
       function value = get.nextx(obj)
           value = obj.nowx + obj.vx;
       end
       function value = get.nexty(obj)
           value = obj.nowy + obj.vy;
       end
       
       %更新坐标
       function obj = renewxy(obj,x,y)
           obj.nowx = x;
           obj.nowy = y;
       end
       
    end   
end 

