%如果目标可以移动，对目标的位置进行更新
function newtarget = renew_target(target,i,robot,simulation_robot)
    [~,num_target] = size(target);
    newtarget = target;
    for id = 1:num_target
        if(i<20)
            newtarget(1).vx = +0.05;        
            newtarget(2).vx = -0.05;        
            newtarget(2).vy = +0.05;    
            newtarget(3).vy = -0.05;    
        else      
            newtarget(1).vx = -0.04;        
            newtarget(2).vx = +0.05;     
            newtarget(2).vy = -0.01;   
            newtarget(3).vy = +0.04;    
        end

        newtarget(id).nowx = newtarget(id).nextx;
        newtarget(id).nowy = newtarget(id).nexty;
    end 
    
    
    
end