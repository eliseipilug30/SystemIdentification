clear all;
close all;
clc;
a=-0.8;
b=0.8;
na=2;
nb=2;
nk=1;
Ts=0.01;
N=200;
A=0;
B=0;

uid=idinput(N,'prbs',[],[-0.8,0.8]);
yid=zeros(1,N);
uval = [zeros(10, 1); 0.3*ones(70, 1); zeros(10, 1)];
theta=ones(na+nb,1);
P_inv=1000*eye(na + nb);

motor = DCMRun.start();

for k = 1:N
    yid(k)=motor.step(uid(k));
    phi=[];
    for i = 1:na
        if(k>i)
            phi(i)=-yid(k-i);
        else
            phi(i)=0;
        end
    end
    for i = 1:nb
        if(k>i)
            phi(i+na)=uid(k-i);
        else
            phi(i+na)=0;
        end
    end
    phi = phi';

    e = yid(k)-phi'*theta;
    P_inv = P_inv - P_inv*phi*phi'*P_inv/(1+phi'*P_inv*phi);
    W = P_inv*phi;
    theta = theta + W*e;

    if k == 10
        theta5 = theta;
    end

    motor.wait;
end
motor.stop();

A=[1 theta(1:na)'];
B=[0 theta(na+1:end)'];
arxmodel=idpoly(A,B,1,1,1,0,Ts);

A=[1 theta5(1:na)'];
B=[0 theta5(na+1:end)'];
arxmodel5=idpoly(A,B,1,1,1,0,Ts);

yval = DCMRun.run(uval);
yhat = lsim(arxmodel,uval);
yhat2 = lsim(arxmodel5, uval);
%%
plot(yhat);
hold;
plot(yval);
figure;
plot(yhat)
hold
plot(yhat2);
hold;