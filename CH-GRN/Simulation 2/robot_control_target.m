%agent���target��֮��Ľ���
function target = robot_control_target(robot,target)


    [~,num_robot] = size(robot);

    %% ����������ӵ���ӦĿ��ı��У����趨�����Ŀ����ٶ�
    for id = 1:num_robot
        if (robot(id).alive == 1 && robot(id).organize == 1)                                   %���������
                if isempty(find(target(robot(id).task).robotlist == id, 1))    %�����������Ŀ��ı���
                    target(robot(id).task).robotlist = [target(robot(id).task).robotlist;id];
                end
                if isempty(find(target(robot(id).task).robotlist == id, 1))    %�����������Ŀ��ı���
                    target(robot(id).task).robotlist = [target(robot(id).task).robotlist;id];
                end
        end
    end