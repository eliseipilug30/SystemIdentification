close all
clear all;
clc;
load('date_lab9.mat')

plot(u,'black')
title('Afisare date identificare');
N=300;
Ts=0.01;

na =7;
nb =7;
nk=1;


uid = u(1:300);
uval = u(301:end);

yid=vel(1:300);
yval=vel(301:end);

date_arx=iddata(yid',uid,Ts);
arxmodel=arx(date_arx,[na,nb,nk]);
yhat=lsim(arxmodel,uid);

phi=[];
 for k = 1: length(yhat)
    for i = 1:na
        if(k>i)
        phi(k,i)=-yhat(k-i);
        else
            phi(k,i)=0;
        end
    end
    for i = 1:nb
        if(k>i)
        phi(k,i+na)=uid(k-i);
        else
            phi(k,i+na)=0;
        end
    end
        
end
theta=phi\yhat;

A=[1 theta(1:na)'];
B=[0 theta(na+1:end)'];
ivmodel=idpoly(A,B,1,1,1,0,Ts);
yhat2=lsim(ivmodel,uval);


MSE=1/length(yval)*sum((yval'-yhat2).^2)
figure,
plot(yval);
hold on;
plot(yhat2);
title('Simulare');





