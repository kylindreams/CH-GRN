%�����x1y1�����ĵ���x2y2�ķ���
%ˮƽ���ҷ���Ƕ�Ϊ0
function theta = direction(x1,y1,x2,y2)
    x = x2-x1;
    y = y2-y1;
    theta = atand(y/x);     %�����շ���
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