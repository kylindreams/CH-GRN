%�ж�Ŀ���Ƿ���agent�ķ�Χ�ڣ��ڣ���֯agent�����ڣ�����֯agent
function yesorno = iforganize(id,p_fish,p_captor)      %�ж���û�з���Ŀ��

yesorno = 0;


    [~,num_target] = size(p_fish); 

    for j=1:num_target
        if(((p_captor(id).nowx-p_fish(j).nowx)^2+(p_captor(id).nowy-p_fish(j).nowy)^2)^0.5 < p_captor(id).distent_detect )
            yesorno = 1;
        end
    end