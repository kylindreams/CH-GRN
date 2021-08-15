 %��ͼ��
classdef Plot
   properties 
       id = 1;                %���
       nowx = 0;              %��ǰ������
       nowy = 0;              %��ǰ������
       vx = 0;                %��ǰ�����ٶ�
       vy = 0;                %��ǰ�����ٶ�
       move = 0;              %�Ƿ����ƶ�Ŀ��:0,��̬Ŀ�ꣻ1,��̬Ŀ��
   end  
   properties (Dependent, Hidden)
       nextx = 0;             %��һ��������
       nexty = 0;             %��һ��������

   end
   properties (Hidden, Constant)
       cell_wid = 0.25;
       N_cell_x = 100;
       N_cell_y = 100;
   end
   
   methods  
       %���캯��
       function obj = Plot(id, nowx, nowy, vx, vy, move) 
           obj.id = id;
           obj.nowx = nowx;
           obj.nowy = nowy;
           obj.vx = vx;
           obj.vy = vy;
           obj.move = move;
       end
   end
   methods (Static)
       %��������
       function  plot_target(target)
            hold on;
            %Ŀ����˶��켣��
            plot([10,10],[9,4],'--','color','k','LineWidth',1.2)
            %Ŀ���
            [~,num_target] = size(target); 
            for ploti = 1:num_target
                plot(target(ploti).nowx, target(ploti).nowy,'xr','LineWidth',1.5)   
            end
       end
       function  plot_organize(robot)
            hold on;
            [~,num_robot] = size(robot);
            for ploti = 1:num_robot
                if(robot(ploti).organize == 1)
                    t = linspace(0,2*pi,10);
                    r = 0.2;
                    x = r * cos(t)+robot(ploti).nowx;             
                    y = r * sin(t)+robot(ploti).nowy;              
                    plot(x,y)        
                    if robot(ploti).alive == 1
                        fill(x,y,'b')
                    else
                        fill(x,y,[0.8,0.8,0.8])
                    end
                end
            end
       end
       function  plot_nonorganize(robot)
            hold on;
            [~,num_robot] = size(robot);
            for ploti = 1:num_robot
                if(robot(ploti).organize == 0)
                    t = linspace(0,2*pi,10);
                    r = 0.2;
                    x = r * cos(t)+robot(ploti).nowx;             
                    y = r * sin(t)+robot(ploti).nowy;              
                    plot(x,y)           
                    if robot(ploti).alive == 1
                        fill(x,y,'r')
                    else
                        fill(x,y,[0.8,0.8,0.8])
                    end
                end
            end
       end
       function plot_contour(proteinconcentration)

            colormap HOT;
            x_mat = zeros(Plot.N_cell_x,Plot.N_cell_y);               %�վ���
            y_mat = zeros(Plot.N_cell_x,Plot.N_cell_y);

            for i1 = 1:Plot.N_cell_x
                 for j1 = 1:Plot.N_cell_y
                    x_mat(i1,j1)=(i1-0.5)*Plot.cell_wid;         %���ÿ��ϸ��������λ������
                    y_mat(i1,j1)=(j1-0.5)*Plot.cell_wid;
                 end
            end
            [c,h]=contour(x_mat,y_mat,proteinconcentration);                        %�������꼰�߶Ȼ��ȸ���
            %colorbar
            set(gcf,'color',[1,1,1])
                set(h,'LevelList',1.25)%�趨�ȸ��ߵ�ֵ
            axis([0,20,0,20]);                              %x��y�ᶼ��25֮�ڣ�������100*100
            xlabel('x(m)'),ylabel('y(m)');
            axis square;
       end
       
       function  plot_barrier(barrier)
            hold on;
            [~,num_robot] = size(barrier);
            for ploti = 1:num_robot
                patch(barrier(ploti).pointx/4,barrier(ploti).pointy/4,[0,0.9,0])   
            end
       end
       
       function plot_simulationrobot(simulation_robot)
           hold on
            [num_simulationrobot,~] = size(simulation_robot);
            for i = 1:num_simulationrobot
                t = linspace(0,2*pi,10);
                r = 0.5;
                x = r * cos(t)+simulation_robot(i,1);             
                y = r * sin(t)+simulation_robot(i,2);              
                plot(x,y)                           % ��Բ
    %             fill(x,y,'y')      
            end
       end
       
       function  plot_background()
            set(gcf,'color',[1,1,1])
            axis([0,20,0,20]);                              %x��y�ᶼ��25֮��
            xlabel('x(m)'),ylabel('y(m)');
            axis square;
            box on
            set(gca,'FontName','Times New Roman','FontSize',14);
            set(gcf,'unit','centimeters','position',[1,2,9,9])
       end
       
       
       function  plot_all(final_pattern,barrier,target,robot)
            clf
            Plot.plot_contour(final_pattern);
            Plot.plot_background();
            Plot.plot_barrier(barrier);
            Plot.plot_target(target);
            Plot.plot_organize(robot);
            Plot.plot_nonorganize(robot);
            hold off
            pause(0.03);
       end
    end   
end 

