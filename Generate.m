% John Tyler Maar 399884
% Robert Lauff 390593
% Daniel Zastrau 391378

function [A,b] = Generate(g, a, w, T_U, x_m, y_m, h)

n_x= round(x_m / h);
n_y= round(y_m / h);

f=@(i,j) i+ (j-1)*(n_x+1) +1;

A=zeros((n_x+1) * n_y, (n_x+1) * n_y);
b=zeros((n_x+1) * n_y,1);

%equation 1

for i = 1:n_x-1
   b(f(i,1))=g(i*h);
   A(f(i,1), f(i+1,1))=-1;
   A(f(i,1), f(i-1,1))=-1;
   A(f(i,1), f(i,2))=-1;
   A(f(i,1), f(i,1))=4;
end
   
for j=2:n_y-1
   for i = 1:n_x-1
       b(f(i,j))=0;
       A(f(i,j), f(i+1,j))=-1;
       A(f(i,j), f(i-1,j))=-1;
       A(f(i,j), f(i,j+1))=-1;
       A(f(i,j), f(i,j-1))=-1;
       A(f(i,j), f(i,j))=4;
   end
end

%equation 3

for i=1:n_x-1
    b(f(i,n_y))=2*h*a*T_U;
    A(f(i,n_y), f(i+1,n_y))=-1;
    A(f(i,n_y), f(i-1,n_y))=-1;
    A(f(i,n_y), f(i,n_y-1))=-2;
    A(f(i,n_y), f(i,n_y))=4+2*h*a;
end

%equations 4,5

for j=2:n_y-1
    b(f(0,j))=2*h*a*T_U;
    A(f(0,j), f(0,j-1))=-1;
    A(f(0,j), f(0,j+1))=-1;
    A(f(0,j), f(1,j))=-2;
    A(f(0,j), f(0,j))=4+2*h*a;
    
    b(f(n_x,j))=2*h*a*T_U;
    A(f(n_x,j), f(n_x,j-1))=-1;
    A(f(n_x,j), f(n_x,j+1))=-1;
    A(f(n_x,j), f(n_x-1,j))=-2;
    A(f(n_x,j), f(n_x,j))=4+2*h*a;
end
%corners

b(f(0,n_y))=4*h*a*T_U;
A(f(0,n_y), f(1,n_y)) = -2;
A(f(0,n_y), f(0,n_y-1)) = -2;
A(f(0,n_y), f(0,n_y)) = 4+ 4*h*a;

b(f(n_x,n_y))=4*h*a*T_U;
A(f(n_x,n_y), f(n_x-1,n_y)) = -2;
A(f(n_x,n_y), f(n_x,n_y-1)) = -2;
A(f(n_x,n_y), f(n_x,n_y)) = 4+ 4*h*a;

b(f(0,1))=2*h*a*T_U+g(0);
A(f(0,1), f(1,1)) = -2;
A(f(0,1), f(0,2)) = -1;
A(f(0,1), f(0,1)) = 4+ 2*h*a;

b(f(n_x,1))=2*h*a*T_U+g(x_m);
A(f(n_x,1), f(n_x-1,1)) = -2;
A(f(n_x,1), f(n_x,2)) = -1;
A(f(n_x,1), f(n_x,1)) = 4+ 2*h*a;

A=sparse(A);
end


