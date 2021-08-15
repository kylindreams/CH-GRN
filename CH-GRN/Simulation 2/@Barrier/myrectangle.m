%输入多边形顶点，返回障碍物矩阵
function tm2 = myrectangle(point)
np=100;
x=[0:np];
y=[0:np];


[X,Y]=meshgrid(x,y);%网格化

% 找内点
[ind] = inpolygon(X,Y,point(1,:),point(2,:));

flg_ind=double(ind);
tm = flg_ind(1:np,:)+flg_ind(2:(np+1),:);     %上下平移叠加
tm2 = tm(:,1:np)+tm(:,2:(np+1));              %左右平移叠加：为1的是边界


[num,dim] = size(tm2); 
for i=1:num                 
    for j=1:dim
      if tm2(i,j) > 0
         tm2(i,j) = 1;
      end
    end
end