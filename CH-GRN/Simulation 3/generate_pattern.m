%Éú³Épattern
function pattern = generate_pattern(p_fish)

 N_cell_x = 100;
 N_cell_y = 100;
 
p = zeros(N_cell_x,N_cell_y);
g1 = zeros(N_cell_x,N_cell_y);
g2 = zeros(N_cell_x,N_cell_y);
g3 = zeros(N_cell_x,N_cell_y);


sita1 = 0.25;
sita2 = 0.3;
sita3 = 1.2;

for i = 1:N_cell_x
    for j = 1:N_cell_y
        p1(i,j) = estab_mor(p_fish,i,j);     
%         p1(i,j) = calc_mor(p_fish,i,j);     
        g1(i,j) = sig(p1(i,j),sita1);
        g2(i,j) = 1-sig(p1(i,j),sita2);
        g3(i,j) = sig(g1(i,j)+g2(i,j),sita3);

    end
end

% d = d/max(max(d(:)));

  pattern = g3;