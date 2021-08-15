 %Ŀ����
classdef Target
   properties 
       id = 1;                %���
       nowx = 0;              %��ǰ������
       nowy = 0;              %��ǰ������
       vx = 0;                %��ǰ�����ٶ�
       vy = 0;                %��ǰ�����ٶ�
       move = 0;              %�Ƿ����ƶ�Ŀ��:0,��̬Ŀ�ꣻ1,��̬Ŀ��
       type = 1;
       robotlist = [];        %���ڰ�Χ�Ļ������б�
   end  
   properties (Dependent, Hidden)
       nextx = 0;             %��һ��������
       nexty = 0;             %��һ��������

   end
   
   methods  
       %���캯��
       function obj = Target(id, nowx, nowy, vx, vy, move) 
           obj.id = id;
           obj.nowx = nowx;
           obj.nowy = nowy;
           obj.vx = vx;
           obj.vy = vy;
           obj.move = move;
       end
       
       %��ѯ��һ��������
       function value = get.nextx(obj)
           value = obj.nowx + obj.vx;
       end
       function value = get.nexty(obj)
           value = obj.nowy + obj.vy;
       end
       
       %��������
       function obj = renewxy(obj,x,y)
           obj.nowx = x;
           obj.nowy = y;
       end
       
    end   
end 

