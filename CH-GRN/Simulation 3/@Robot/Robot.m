 %��������
classdef Robot
   properties 
       id = 1;                %���
       nowx = 0;              %��ǰ������
       nowy = 0;              %��ǰ������
       vx = 0;                %��ǰ�����ٶ�
       vy = 0;                %��ǰ�����ٶ�
       nextx = 0;             %��һ��������
       nexty = 0;             %��һ��������
       organize = 0;          %�Ƿ�����֯������:0,����֯�����ˣ�1,��֯������
       alive = 1;             %�Ƿ񻹻���:0,��1,����
       task = [];             %��ǰ��Ŀ��
       size = 0.5;
       pattern = zeros(100);    %�ϰ�Ŀ���pattern
       
       pattern_target = zeros(100);    %Ŀ���pattern
       pattern_robot = zeros(100);    %Ŀ���pattern
   end  
   properties (Dependent, Hidden)

   end
   properties (Hidden)
%        pattern = zeros(100);%�������Լ���pattern
       distent_detect = 5;                        %̽�ⷶΧ
       distent_fish = 1;                         %��ȫ����
       distent_capter = 0.5;                       %��ȫ����
       v = 0.25;
   end  

   
   methods  
       %���캯��
       function obj = Robot(id, nowx, nowy, vx, vy, organize) 
           obj.id = id;
           obj.nowx = nowx;
           obj.nowy = nowy;
           obj.vx = vx;
           obj.vy = vy;
           obj.organize = organize;
%            obj.pattern = pattern;
       end
       
       %��ѯ��һ��������
       function value = get.nextx(obj)
           value = obj.nowx + obj.vx;
       end
       function value = get.nexty(obj)
           value = obj.nowy + obj.vy;
       end
       
       %��������
       function obj = renewxy(obj)
           obj.nextx = obj.nowx + obj.vx;
           obj.nexty = obj.nowy + obj.vy;
           obj.nowx = obj.nextx;
           obj.nowy = obj.nexty;
       end
       
       %�����˸��ݻ������������pattern
       [value1,value2] = trapping(obj,robot,target,pattern_barrier,pattern) 
       pattern = generate_robotpatt(obj,p_captor)
       m = calc_m(obj,pos,i,j)
    end   
end 
