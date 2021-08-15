%�������������
function pattern = generate_simulatepattern(p_captor)

% global cell_wid;
N_cell_x = 100;
N_cell_y = 100;

p2 = zeros(N_cell_x,N_cell_y);
g1 = zeros(N_cell_x,N_cell_y);
g2 = zeros(N_cell_x,N_cell_y);
g3 = zeros(N_cell_x,N_cell_y);

sita1 = 0.15;
sita2 = 2.8;
for i = 1:N_cell_x
    for j = 1:N_cell_y
%          p2(i,j) = calc_mor(p_captor,i,j); 
        p2(i,j) = Barrier.cal_dis(p_captor,i,j);     %ʵ��Ӱ��ľ�ֻ�к�Ŀ��ľ����Ŀ���Ӱ����
        g1(i,j) = sig(p2(i,j),sita1);
        g2(i,j) = 1-sig(p2(i,j),sita2);
        g3(i,j) = 0.5*g1(i,j)+g2(i,j);
    end
end

g3 = g3-min(min(g3(:)));
g3 = g3/max(max(g3(:)));

x_mat = zeros(N_cell_x,N_cell_y);               %�վ���
y_mat = zeros(N_cell_x,N_cell_y);

cell_wid = 0.25;
for i1 = 1:N_cell_x
     for j1 = 1:N_cell_y
        x_mat(i1,j1)=(i1-0.5)*cell_wid;         %���ÿ��ϸ��������λ������
        y_mat(i1,j1)=(j1-0.5)*cell_wid;
     end
end
  pattern = g3;