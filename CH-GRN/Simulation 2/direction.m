%计算从x1y1出发的到达x2y2的方向
%水平向右方向角度为0
function theta = direction(x1,y1,x2,y2)
    x = x2-x1;
    y = y2-y1;
    theta = atand(y/x);     %求最终方向
    if (x<0)
        theta = theta +180;
    elseif (x>0 && y<0)
        theta = theta +360;
    elseif (x==0 && y>0)
        theta = 90;
    elseif (x==0 && y<0)
        theta = 270;
    else
        theta = 0;
    end
end