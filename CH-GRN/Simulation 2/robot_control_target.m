%agent类和target类之间的交互
function target = robot_control_target(robot,target)


    [~,num_robot] = size(robot);

    %% 将机器人添加到相应目标的表中，并设定运输的目标的速度
    for id = 1:num_robot
        if (robot(id).alive == 1 && robot(id).organize == 1)                                   %如果还活着
                if isempty(find(target(robot(id).task).robotlist == id, 1))    %如果不在任务目标的表中
                    target(robot(id).task).robotlist = [target(robot(id).task).robotlist;id];
                end
                if isempty(find(target(robot(id).task).robotlist == id, 1))    %如果不在任务目标的表中
                    target(robot(id).task).robotlist = [target(robot(id).task).robotlist;id];
                end
        end
    end