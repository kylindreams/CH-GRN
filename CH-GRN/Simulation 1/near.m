%找出距离位置（x,y）最近的目标
function minfish = near(fish,x,y)

[~,dim] = size(fish); %% num: number of organizing agents in the env; dim: the dimension of the system, typically, 2.Can be generalized
                       %% the last element of pos reprsents the strength of
                       %% the indexed source
minfish = 1;
mindis = ((x-fish(1).nowx)^2+(y-fish(1).nowy)^2)^0.5;         %初始最近的为目标1

for index = 1:dim                                       %对所有目标：找出最近的目标
    r = ((x-fish(index).nowx)^2+(y-fish(index).nowy)^2)^0.5;  %距离目标的距离
    if(mindis > r)
        minfish = index;
        mindis = r;
    end
end