%����������ˣ����㵥�������patternŨ��
function m = estab_mor(pos,i,j)

global cell_wid;
[num,dim] = size(pos); 

epi = 1;  
m = 0;
for index = 1:dim                                     
    r = ((cell_wid*(i-0.5)-pos(index).nowx)^2+(cell_wid*(j-0.5)-pos(index).nowy)^2)^0.5;  %����Ŀ��ľ���
    m = m + exp(-r/epi);                   %���ž����Զ��Ӱ���𽥱�С
end