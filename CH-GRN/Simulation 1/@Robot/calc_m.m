%计算当前网格的pattern
function m = calc_m(robotnow,pos,i,j)

global cell_wid;
[num,dim] = size(pos); %% num: number of organizing agents in the env; dim: the dimension of the system, typically, 2.Can be generalized
                       %% the last element of pos reprsents the strength of
                       %% the indexed source 
m = 0;
temp(1:3) = 0;
tempp = [];
for index = 1:dim
    if index~=robotnow.id
    r = ((cell_wid*(i-0.5)-pos(index).nowx)^2+(cell_wid*(j-0.5)-pos(index).nowy)^2)^0.5;  %距离目标的距离
    r=r*2.5;
%     r = r/10;
    temp(1) = 2 * exp(-r);
    temp(2) = 1/(1+exp(-r))-1;
    temp(3) = 4*(1-1/(1+exp(-(r-2))));
    tempp=[tempp,(temp(1)+temp(2)+temp(3))/5];
    end
end

    m=sum(tempp);