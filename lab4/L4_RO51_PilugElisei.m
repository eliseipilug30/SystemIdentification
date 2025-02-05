%ordin1
load("lab4_order1_4.mat")
y1=data.Y;
u1=data.U;

%afisare grafice
figure
plot(t,u1,'b')
xlabel('t')
ylabel('u')
figure
plot(t,y1,'r')
xlabel('t')
ylabel('y')

%definire parametri
y1ss=1.6;
u1ss=1.5;
k1=y1ss/u1ss
y1max=3.42;
t1=1.16;
t2=1.68;
T1=t2-t1;

%formare matrice
A1=-1/T1;
B1=k1/T1;
C1=1;
D1=0;
H1=ss(A1,B1,C1,D1)
%validare
u1val=u1(1:330);
y1val=y1(1:330);

hold
yhat1=lsim(H1,u1,t,y1ss);
lsim(H1,u1,t,y1ss)

figure
plot(t,u1val)
hold on;
plot(t,y1val)
e=y1(1:330)
MSE=sum(e.^2)\length(e)
title('Ordin 1 Validare',MSE)
%%
%ordin2
load('lab4_order2_4.mat')
u2=data.U;
y2=data.Y;
figure
plot(t,u2,'blue')
figure
plot(t,y2,'green')

%declarare parametri
y2ss=0.25;
y0=y2ss;
u2ss=1;
k2=3;
t3=1.18;
t4=2.56;
T0=t4-t3;
k=y2ss;

Aplus=T0*sum(y2(31:54)-y2ss);
Aminus=T0*abs(sum(y2(54:76)-y2ss));
M=abs(Aminus)/Aplus;
zeta=(log(1/M))/(sqrt(pi^2)+(log(M)^2));
wn=2*pi/(T0*sqrt(1-(zeta^2)));

%formare Hs
A2=[0 1;-wn^2 -2*zeta*wn];
B2=[0; k*wn^2];
C2=[1 0];
D2=0;
H2=ss(A2,B2,C2,D2);

u2val=u2(1:330);
y2val=y2(1:330);
yhat=lsim(H2,u2,t,[y2ss 0])
figure

plot(t,u2val)
hold on
plot(t,y2val)
hold on
plot(t,yhat,'g')
e=y2(1:330)-yhat
MSE=sum(e.^2)/length(e)






















