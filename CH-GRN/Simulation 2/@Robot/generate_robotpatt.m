%计算当前位置的pattern除了自己之外的agent
function pattern = generate_robotpatt(robotnow,p_captor)


sita1 = 0.95;
sita2 = 1;


        xaxis = fix(robotnow.nowx/0.25)+1;   
        yaxis = fix(robotnow.nowy/0.25)+1;
        i = xaxis;
        j = yaxis;
        p2 = calc_m(robotnow,p_captor,i,j);   
        g1 = sig(p2,sita1);
        g2 = 1-sig(p2,sita2);
        g3 = 0.5*g1+g2;

g3 = g3-0.5;
g3 = g3/1.016;


  pattern = g3;