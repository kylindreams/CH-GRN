%�������ζ��㣬�����ϰ������
function tm2 = myrectangle(point)
np=100;
x=[0:np];
y=[0:np];


[X,Y]=meshgrid(x,y);%����

% ���ڵ�
[ind] = inpolygon(X,Y,point(1,:),point(2,:));

flg_ind=double(ind);
tm = flg_ind(1:np,:)+flg_ind(2:(np+1),:);     %����ƽ�Ƶ���
tm2 = tm(:,1:np)+tm(:,2:(np+1));              %����ƽ�Ƶ��ӣ�Ϊ1���Ǳ߽�


[num,dim] = size(tm2); 
for i=1:num                 
    for j=1:dim
      if tm2(i,j) > 0
         tm2(i,j) = 1;
      end
    end
end