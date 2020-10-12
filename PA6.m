% John Tyler Maar 399884
% Robert Lauff 390593
% Daniel Zastrau 391378

clear all;
close all;

g=@(x) 100;
a=1;
w=1;
T_U=20;
h=0.04;

n_x=round(2/h);
n_y=round(3/h);

[A,b] = Generate(g,a,w,T_U,2,3,h);
u=A\b;
u_0=transpose(arrayfun(g, (0:h:2)));

x=0:h:2;
y=0:h:3;
X=zeros(1,(n_x+1) * (n_y+1));
Y=zeros(1,(n_x+1) * (n_y+1));
for i=0:n_x
    for j=0:n_y
        X(i+j*(n_x+1)+1)=x(i+1);
        Y(i+j*(n_x+1)+1)=y(j+1);
    end
end

figure(1)
plotc(X,Y,[u_0;u]);
xlabel('x')
ylabel('y')
title('Temperaturverteilung in der Kuehlrippe');
