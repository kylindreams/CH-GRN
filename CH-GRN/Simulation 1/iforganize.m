%判断目标是否在agent的范围内，在：组织agent，不在：非组织agent
function yesorno = iforganize(id,p_fish,p_captor)      %判断有没有发现目标

yesorno = 0;


    [~,num_target] = size(p_fish); 

    for j=1:num_target
        if(((p_captor(id).nowx-p_fish(j).nowx)^2+(p_captor(id).nowy-p_fish(j).nowy)^2)^0.5 < p_captor(id).distent_detect )
            yesorno = 1;
        end
    end