close all;
clear all;
clc
load("data_lab8.mat")
y=speed;
plot(u);
title('u')
figure;
plot(y)
title('y')
Ts=0.01;
a=-0.7;
b=0.7;
m2=10;
u_id = u(1:250);
u_val= u(251:end);
y_id=y(1:250);
y_val=y(251:end)';
N=length(y_id);
nk=2;
e = zeros(1,N);
df = zeros(N,1);
db = zeros(N,1);


theta =[0.1;50];
theta_1=theta;
l=1;
lmax=1000;

F = theta(1);
B = theta(2);
df = zeros(1,N);
db = zeros(1,N);
H = zeros(2,2);
dV =0;
thetaB=[B,0];
thetaF=[F,0];
alpha=0.1;
delta=0.01;

 while  l==1 ||  l<=lmax && (norm([thetaF(l),thetaB(l)]-[thetaF(l-1),thetaB(l-1)]))>delta
     F=thetaF(l);
     B=thetaB(l); 
     l=l+1;
     df(1:nk)=0;
     db(1:nk)=0;
    e(1:nk)=y_id(1:nk);
        for k = 1+nk:N
            e(k)=-F*e(k-1)+y(k)+F*y(k-1)-B*u(k-nk);
            df(k) = -e(k-1)-F*df(k-1)+y(k-1);
            db(k) = -F*db(k-1)- u(k-nk);
            
       
        end
% for i=1:N
% dV=dV+e(i)*de()
% 
% end


        
        dV = 2/(N-nk) * sum( e.*[df; db],2);
        H =2/(N-nk) * ([df; db]*[df; db]');
        o=alpha.*(H\dV);
        thetaF(l)=thetaF(l-1)-o(1,:);
         thetaB(l)=thetaB(l-1)-o(2,:);
        
 end
 identificare=iddata(y_val,u_val,t(2)-t(1));

model_id = idpoly(1,[0,B], 1, 1,[1,F], 0, t(2)-t(1));
figure;
compare(model_id,identificare);




