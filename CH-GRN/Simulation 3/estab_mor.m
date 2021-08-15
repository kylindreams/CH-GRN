%对虚拟机器人，计算单个网格的pattern浓度
function m = estab_mor(pos,i,j)

global cell_wid;
[num,dim] = size(pos); 

epi = 1;  
m = 0;
for index = 1:dim                                     
    r = ((cell_wid*(i-0.5)-pos(index).nowx)^2+(cell_wid*(j-0.5)-pos(index).nowy)^2)^0.5;  %距离目标的距离
    m = m + exp(-r/epi);                   %随着距离的远近影响逐渐变小
end