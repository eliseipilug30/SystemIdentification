clear all;
close all;
clc
load('datemotor_lab7');
plot(u);

a=-0.7;
b=0.7;
m=3;
m2=10;
N=200;
na=20;
nb=20;
nk=1;
%u=spab(N, m, a, b);
% Segmentare
u_id1 = u(1:245);
u_id2 = u(246:475);
u_val = u(476:end);

y_id1=vel(1:245);
y_id2=vel(246:475);
y_val=vel(476:end);
u=[u_id1 u_id2 u_val];
%u=[zeros(1,30),spab(N,m,a,b),zeros(1,30),spab(n,m2,a,b),zeros(1,30),0.4*ones(1,70)];
% close all;
m=3;
if(m==3)
     a=[1 0 1];
 elseif(m==4)
     a=[1 0 0 1];
 elseif(m==5)
     a=[0 1 0 0 1];
 elseif(m==6)
     a=[1 0 0 0 0 1];
 elseif(m==7)
     a=[1 0 0 0 0 0 1];
 elseif(m==8)
     a=[1 1 0 0 0 0 1 1];
 elseif(m==9)
     a=[0 0 0 1 0 0 0 0 1];
 elseif(m==10)
     a=[0 0 1 0 0 0 0 0 0 1];
end
X=ones(1,m);
for i=2:N
    X(i,1)=mod(a*X(i-1,:)',2)%in baza 2
    X(i,2:m)=X(i-1,(2:m)-1)%parcurgere pe "coloane";
end
spab3=X(:,1)
plot(spab3);

m=10;
if(m==3)
     a=[1 0 1];
 elseif(m==4)
     a=[1 0 0 1];
 elseif(m==5)
     a=[0 1 0 0 1];
 elseif(m==6)
     a=[1 0 0 0 0 1];
 elseif(m==7)
     a=[1 0 0 0 0 0 1];
 elseif(m==8)
     a=[1 1 0 0 0 0 1 1];
 elseif(m==9)
     a=[0 0 0 1 0 0 0 0 1];
 elseif(m==10)
     a=[0 0 1 0 0 0 0 0 0 1];
end
X=ones(1,m);
for i=2:N
    X(i,1)=mod(a*X(i-1,:)',2)%in baza 2
    X(i,2:m)=X(i-1,(2:m)-1)%parcurgere pe "coloane";
end
spab10=X(:,1)
figure;
plot(spab10);
%%
close all;
clc
load('datemotor_lab7');
plot(u);
a=-0.7;
b=0.7;
m=3;
m2=10;
N=200;
na=20;
nb=20;
nk=1;
%u=spab(N, m, a, b);
% Segmentare
u_id1 = u(1:245)';
u_id2 = u(246:475)';
u_val = u(476:end)';

y_id1=vel(1:245)';
y_id2=vel(246:475)';
y_val=vel(476:end)';


% ARX
T=t(2)-t(1);
%pentru spab3
date_arx=iddata(y_id1,u_id1,T);
arx1=arx(date_arx,[na,nb,nk]);
%creare model
figure;
compare(arx1,date_arx);
title('SPAB3');
%comparare spab3 cu modelul creat la arx
figure;
date_arx=iddata(y_val,u_val,T);
compare(arx1,date_arx);
%pentru spab10
date_arx=iddata(y_id2,u_id2,T);
arx1=arx(date_arx,[na,nb,nk]);
%creare model
figure;
compare(arx1,date_arx);
%comparare spab3 cu modelul creat la arx
figure;
date_arx=iddata(y_val,u_val,T);
compare(arx1,date_arx);
title('SPAB10');










