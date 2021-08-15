%障碍物初始化
function simulation_captor = init_barrier(barrier)

global cell_wid;
cell_wid = 0.25;
length = 0.5;    %模拟障碍物的大小

point2 = 4*[7,9,9,7;                       
          0,0,20,20;]*cell_wid;
% simulation1 = [point1,point1(:,1)];
x1 = barrier(1).pointx(1)/4;
y1 = barrier(1).pointy(1)/4;
x2 = barrier(1).pointx(3)/4;
y2 = barrier(1).pointy(2)/4;
simulation2 = [x1+length,x2-length,x2-length,x1+length,x1+length;
                 y1+length,y1+length, y2-length,y2-length,y1+length];
point3 = 4*[11,13,13,11;
          0,0,20,20;]*cell_wid;
x1 = barrier(2).pointx(1)/4;
y1 = barrier(2).pointy(1)/4;
x2 = barrier(2).pointx(3)/4;
y2 = barrier(2).pointy(2)/4;
simulation3 = [x1+length,x2-length,x2-length,x1+length,x1+length;
                 y1+length,y1+length, y2-length,y2-length,y1+length];
      
%这一段是根据simulation求等距坐标点的
num_simulation = 0;
for i = 1:4         %算各条线与x正方向夹角的大小
    simulation_theta(i) = atand((simulation2(2,i+1)-simulation2(2,i))/(simulation2(1,i+1)-simulation2(1,i)));     
    if ((simulation2(1,i+1)-simulation2(1,i))<0 )
        simulation_theta(i) = simulation_theta(i) +180;
        y = simulation2(2,i);
        for x = simulation2(1,i):length*cosd(simulation_theta(i)):simulation2(1,i+1)
            num_simulation = num_simulation + 1;
            simulation_captor(num_simulation,1)= x;
            simulation_captor(num_simulation,2)= y;
            y = y + length*sind(simulation_theta(i));
        end
    elseif ((simulation2(1,i+1)-simulation2(1,i))==0) && (simulation2(2,i+1)-simulation2(2,i))>0
        simulation_theta(i) = 90;
        x = simulation2(1,i); 
        for y = simulation2(2,i):length:simulation2(2,i+1)
            num_simulation = num_simulation + 1;
            simulation_captor(num_simulation,1)= x;
            simulation_captor(num_simulation,2)= y;
            x = x + length*cosd(simulation_theta(i));
        end
    elseif ((simulation2(1,i+1)-simulation2(1,i))==0) && (simulation2(2,i+1)-simulation2(2,i))<0
        simulation_theta(i) = 270;
        x = simulation2(1,i);  
        for y = simulation2(2,i):-length:simulation2(2,i+1)
            num_simulation = num_simulation + 1;
            simulation_captor(num_simulation,1)= x;
            simulation_captor(num_simulation,2)= y;
            x = x + length*cosd(simulation_theta(i));
        end
    else 
        y = simulation2(2,i);
        for x = simulation2(1,i):length*cosd(simulation_theta(i)):simulation2(1,i+1)
            num_simulation = num_simulation + 1;
            simulation_captor(num_simulation,1)= x;
            simulation_captor(num_simulation,2)= y;
            y = y + length*sind(simulation_theta(i));
        end
    end
    clear simulation_theta
end
for i = 1:4         %算各条线与x正方向夹角的大小
    simulation_theta(i) = atand((simulation3(2,i+1)-simulation3(2,i))/(simulation3(1,i+1)-simulation3(1,i)));  
    if ((simulation3(1,i+1)-simulation3(1,i))<0 ) 
        y = simulation3(2,i);  
        simulation_theta(i) = simulation_theta(i) +180;
        for x = simulation3(1,i):length*cosd(simulation_theta(i)):simulation3(1,i+1)
            num_simulation = num_simulation + 1;
            simulation_captor(num_simulation,1)= x;
            simulation_captor(num_simulation,2)= y;
            y = y + length*sind(simulation_theta(i));
        end
    elseif ((simulation3(1,i+1)-simulation3(1,i))==0) && (simulation3(2,i+1)-simulation3(2,i))>0
        simulation_theta(i) = 90;
        x = simulation3(1,i);  
        for y = simulation3(2,i):length:simulation3(2,i+1)
            num_simulation = num_simulation + 1;
            simulation_captor(num_simulation,1)= x;
            simulation_captor(num_simulation,2)= y;
            x = x + length*cosd(simulation_theta(i));
        end
    elseif ((simulation3(1,i+1)-simulation3(1,i))==0) && (simulation3(2,i+1)-simulation3(2,i))<0
        simulation_theta(i) = 270;
        x = simulation3(1,i);  
        for y = simulation3(2,i):-length:simulation3(2,i+1)
            num_simulation = num_simulation + 1;
            simulation_captor(num_simulation,1)= x;
            simulation_captor(num_simulation,2)= y;
            x = x + length*cosd(simulation_theta(i));
        end
    else 
        y = simulation3(2,i);
        for x = simulation3(1,i):length*cosd(simulation_theta(i)):simulation3(1,i+1)
            num_simulation = num_simulation + 1;
            simulation_captor(num_simulation,1)= x;
            simulation_captor(num_simulation,2)= y;
            y = y + length*sind(simulation_theta(i));
        end
    end
end

simulation_captor(:,3) = 1;
