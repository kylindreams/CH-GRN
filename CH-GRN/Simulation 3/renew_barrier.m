%如果障碍可以移动，对障碍的位置进行更新
function [pattern_barrier,simulation_robot,pattern_simulationrobot,barrier] = renew_barrier(barrier, change)
    [~,num_barrier] = size(barrier);
    pattern_barrier = zeros(80);
    for id = 1:num_barrier
        pattern_barrier = pattern_barrier + barrier(id).pattern_barrier;
    end
    pattern_barrier = pattern_barrier';
    
    global obstacle
    barrier(1).pointx = barrier(1).pointx-change*4;
    barrier(2).pointx = barrier(2).pointx+change*4;
    obstacle(1,1) = obstacle(1,1)-change;
    obstacle(2,1) = obstacle(2,1)+change;
    simulation_robot = Barrier.init_barrier(barrier);
    pattern_simulationrobot = Barrier.generate_simulatepattern(simulation_robot);  
end