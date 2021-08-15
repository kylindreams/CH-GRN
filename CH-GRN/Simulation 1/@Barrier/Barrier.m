 %Ŀ����
classdef Barrier
   properties 
       id = 1;                %���
       pointx = 0;              %��ǰ������
       pointy = 0;              %��ǰ������
       vx = 0;                %��ǰ�����ٶ�
       vy = 0;                %��ǰ�����ٶ�
       move = 0;              %�Ƿ����ƶ�Ŀ��:0,��̬Ŀ�ꣻ1,��̬Ŀ��
       type = 1;              %��Բ���ϰ����Ƕ�����ϰ�
       pattern_barrier = zeros(100);    %�ϰ����Ը����ϰ���ͼ
   end  
   properties (Dependent, Hidden)
       nextx = 0;             %��һ��������
       nexty = 0;             %��һ��������

   end
   
   methods  
       %���캯��
       function obj = Barrier(id, pointx, pointy, vx, vy, move) 
           obj.id = id;
           obj.pointx = pointx;
           obj.pointy = pointy;
           obj.vx = vx;
           obj.vy = vy;
           obj.move = move;
       end
       
       %��ѯ��һ��������
       function value = get.nextx(obj)
           value = obj.pointx + obj.vx;
       end
       function value = get.nexty(obj)
           value = obj.pointy + obj.vy;
       end
       %�����ϰ����Լ���ͼ
       function value = get.pattern_barrier(obj)
           [~,num] = size(obj.pointx);
           if num ==2
               
           elseif num>2
               np=100;
               x=[0:np];
               y=[0:np];
               [X,Y]=meshgrid(x,y);%����
               % ���ڵ�
               [ind] = inpolygon(X,Y,obj.pointx,obj.pointy);

               flg_ind=double(ind);
               tm = flg_ind(1:np,:)+flg_ind(2:(np+1),:);     %����ƽ�Ƶ���
               value = tm(:,1:np)+tm(:,2:(np+1));              %����ƽ�Ƶ��ӣ�Ϊ1���Ǳ߽�

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

