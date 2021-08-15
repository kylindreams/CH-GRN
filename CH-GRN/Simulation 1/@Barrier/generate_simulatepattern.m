%生成虚拟机器人
function pattern = generate_simulatepattern(p_captor)

N_cell_x = 100;
N_cell_y = 100;

p2 = zeros(N_cell_x,N_cell_y);
g1 = zeros(N_cell_x,N_cell_y);
g2 = zeros(N_cell_x,N_cell_y);
g3 = zeros(N_cell_x,N_cell_y);

sita1 = 0.95;
sita2 = 1;
for i = 1:N_cell_x
    for j = 1:N_cell_y
        p2(i,j) = Barrier.cal_dis(p_captor,i,j);     %实际影响的就只有和目标的距离和目标的影响力
        g1(i,j) = sig(p2(i,j),sita1);
        g2(i,j) = 1-sig(p2(i,j),sita2);
        g3(i,j) = 0.5*g1(i,j)+g2(i,j);
    end
end

g3 = g3-min(min(g3(:)));
g3 = g3/max(max(g3(:)));

  pattern = g3;