 %画图类
classdef Plot
   properties 
       id = 1;                %编号
       nowx = 0;              %当前横坐标
       nowy = 0;              %当前纵坐标
       vx = 0;                %当前横向速度
       vy = 0;                %当前纵向速度
       move = 0;              %是否是移动目标:0,静态目标；1,动态目标
   end  
   properties (Dependent, Hidden)
       nextx = 0;             %下一步横坐标
       nexty = 0;             %下一步纵坐标

   end
   properties (Hidden, Constant)
       cell_wid = 0.25;
       N_cell_x = 100;
       N_cell_y = 100;
   end
   
   methods  
       %构造函数
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
       %更新坐标
       function  plot_target(target)
            hold on;
            %目标的运动轨迹线
            plot([10,10],[9,4],'--','color','k','LineWidth',1.2)
            %目标点
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
            x_mat = zeros(Plot.N_cell_x,Plot.N_cell_y);               %空矩阵
            y_mat = zeros(Plot.N_cell_x,Plot.N_cell_y);

            for i1 = 1:Plot.N_cell_x
                 for j1 = 1:Plot.N_cell_y
                    x_mat(i1,j1)=(i1-0.5)*Plot.cell_wid;         %求出每个细胞的中心位置坐标
                    y_mat(i1,j1)=(j1-0.5)*Plot.cell_wid;
                 end
            end
            [c,h]=contour(x_mat,y_mat,proteinconcentration);                        %横纵坐标及高度画等高线
            %colorbar
            set(gcf,'color',[1,1,1])
                set(h,'LevelList',1.25)%设定等高线的值
            axis([0,20,0,20]);                              %x轴y轴都在25之内，正好是100*100
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
                plot(x,y)                           % 画圆
    %             fill(x,y,'y')      
            end
       end
       
       function  plot_background()
            set(gcf,'color',[1,1,1])
            axis([0,20,0,20]);                              %x轴y轴都在25之内
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

