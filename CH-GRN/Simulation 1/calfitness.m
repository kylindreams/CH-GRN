%计算包围强度和包围圈占有率
function fitness = calfitness(robot,target,pattern_barrier,simulation_robot)

% [~,num_robot] = size(robot);
[~,num_target] = size(target);
for i=1:num_target
    surroundingstrength(i) = cal_surroundingstrength(robot,target,pattern_barrier,i);
end
    surroundingtheta = cal_surroundingtheta(robot,target,simulation_robot,i);
fitness.surroundingstrength = surroundingstrength';
fitness.surroundingtheta = surroundingtheta;