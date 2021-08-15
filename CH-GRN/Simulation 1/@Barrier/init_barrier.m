%障碍物初始化
function simulation_captor = init_barrier

global cell_wid;
cell_wid = 0.25;
length = 0.5;    %模拟障碍物的大小

point1 = 4*[4,8,5;                        %这边是碰撞判定的多边形顶点，一列是一个点的横纵坐标
          4,4,8;];                  
barrier1 = Barrier.myrectangle(point1);
point1 = 4*[4,8,5;                       
          4,4,8;]*cell_wid;
simulation1 = [4.44,7.4,5.1,4.44;
                 4.34,4.34,7.4,4.34;];
%左矩形
point2 = 4*[15,17,17,15;
          4,4,13,13;];
barrier2 = Barrier.myrectangle(point2);
point2 = 4*[15,17,17,15;
          4,4,13,13;]*cell_wid;
simulation2 = [15+length,17-length,17-length,15+length,15+length;
                 4+length,4+length, 13-length,13-length,4+length];
%非凸障碍
point3 = 4*[4,4,10,10;
          15,17,17,15;];
barrier3 = Barrier.myrectangle(point3);

point3 = 4*[4,4,10,10;
          15,17,17,15;]*cell_wid;
simulation3 =  [4+length,4+length,10-length,10-length,4+length;
                 15+length,17-length, 17-length,15+length,15+length];
      
%这一段是根据simulation求等距坐标点的
num_simulation = 0;
for i = 1:3         %算各条线与x正方向夹角的大小
    simulation_theta(i) = atand((simulation1(2,i+1)-simulation1(2,i))/(simulation1(1,i+1)-simulation1(1,i)));     
    if ((simulation1(1,i+1)-simulation1(1,i))<0 )
        simulation_theta(i) = simulation_theta(i) +180;
    elseif ((simulation1(1,i+1)-simulation1(1,i))==0) && (simulation1(2,i+1)-simulation1(2,i))>0
        simulation_theta(i) = 90;
    elseif ((simulation1(1,i+1)-simulation1(1,i))==0) && (simulation1(2,i+1)-simulation1(2,i))<0
        simulation_theta(i) = 270;
    end
    y = simulation1(2,i);
    for x = simulation1(1,i):length*cosd(simulation_theta(i)):simulation1(1,i+1)
        num_simulation = num_simulation + 1;
        simulation_captor(num_simulation,1)= x;
        simulation_captor(num_simulation,2)= y;
        y = y + length*sind(simulation_theta(i));
    end
    clear simulation_theta
end
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
