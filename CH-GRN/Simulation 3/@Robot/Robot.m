 %机器人类
classdef Robot
   properties 
       id = 1;                %编号
       nowx = 0;              %当前横坐标
       nowy = 0;              %当前纵坐标
       vx = 0;                %当前横向速度
       vy = 0;                %当前纵向速度
       nextx = 0;             %下一步横坐标
       nexty = 0;             %下一步纵坐标
       organize = 0;          %是否是组织机器人:0,非组织机器人；1,组织机器人
       alive = 1;             %是否还活着:0,否；1,活着
       task = [];             %当前的目标
       size = 0.5;
       pattern = zeros(100);    %障碍目标的pattern
       
       pattern_target = zeros(100);    %目标的pattern
       pattern_robot = zeros(100);    %目标的pattern
   end  
   properties (Dependent, Hidden)

   end
   properties (Hidden)
%        pattern = zeros(100);%机器人自己的pattern
       distent_detect = 5;                        %探测范围
       distent_fish = 1;                         %安全距离
       distent_capter = 0.5;                       %安全距离
       v = 0.25;
   end  

   
   methods  
       %构造函数
       function obj = Robot(id, nowx, nowy, vx, vy, organize) 
           obj.id = id;
           obj.nowx = nowx;
           obj.nowy = nowy;
           obj.vx = vx;
           obj.vy = vy;
           obj.organize = organize;
%            obj.pattern = pattern;
       end
       
       %查询下一步的坐标
       function value = get.nextx(obj)
           value = obj.nowx + obj.vx;
       end
       function value = get.nexty(obj)
           value = obj.nowy + obj.vy;
       end
       
       %更新坐标
       function obj = renewxy(obj)
           obj.nextx = obj.nowx + obj.vx;
           obj.nexty = obj.nowy + obj.vy;
           obj.nowx = obj.nextx;
           obj.nowy = obj.nexty;
       end
       
       %机器人根据环境生成自身的pattern
       [value1,value2] = trapping(obj,robot,target,pattern_barrier,pattern) 
       pattern = generate_robotpatt(obj,p_captor)
       m = calc_m(obj,pos,i,j)
    end   
end 
