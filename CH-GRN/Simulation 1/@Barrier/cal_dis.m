%计算虚拟机器人的当前网格的pattern
function m = cal_dis(pos,i,j)

global cell_wid;
[num,dim] = size(pos); %% num: number of organizing agents in the env; dim: the dimension of the system, typically, 2.Can be generalized
                       %% the last element of pos reprsents the strength of
                       %% the indexed source
epi = 1; 
tempp = [];
m = 0;
for index = 1:num                                    
    r = ((cell_wid*(i-0.5)-pos(index,1))^2+(cell_wid*(j-0.5)-pos(index,2))^2)^0.5;  %距离目标的距离
    r=r*2;
    temp(1) = 2 * exp(-r);
    temp(2) = 1/(1+exp(-r))-1;
    temp(3) = 4*(1-1/(1+exp(-(r-2))));
    tempp=[tempp,(temp(1)+temp(2)+temp(3))/5];
end
    m=sum(tempp);