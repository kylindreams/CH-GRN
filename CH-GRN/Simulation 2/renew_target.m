%���Ŀ������ƶ�����Ŀ���λ�ý��и���
function target = renew_target(target,i)
    [~,num_target] = size(target);

    for id = 1:num_target
        target(1).vx = 0;        
        target(1).vy = -0.1;   
        target(id).nowx = target(id).nextx;
        target(id).nowy = target(id).nexty;
    end 

    
    
    
end