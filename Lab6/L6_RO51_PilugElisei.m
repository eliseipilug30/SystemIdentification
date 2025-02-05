clear all;
close all;
clc;
load('date_lab6.mat')
plot(t,u,'red')
title('afisare date identificare');

uid = u(1:300);
uval = u(301:end);
figure
subplot(2,2,1)
plot(uid)
title('U Identificare');
subplot(2,2,2)
plot(uval)
title('U Validare');

yid=vel(1:300);
yval=vel(301:end);
subplot(2,2,3)
plot(yid);
title('Y Identificare');
subplot(2,2,4)
plot(yval);
title('Y Validare');


na =7;
nb =7;
%identificare
phi=[];
 for k = 1: length(yid)
    for i = 1:na
        if(k>i)
        phi(k,i)=-yid(k-i);
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
theta=phi\yid';
%matricea de aproximare
phival=[];
for k=1:length(yval)
    for i=1:na
        if(k>i)
        phival(k,i)=-yval(k-i);
        else
            phival(k,i)=0;
        end
    end
    for i=1:nb
        if(k>i)
        phival(k,i+na)=uval(k-i);
        else
     phival(k,i+na)=0;
        end
end
end
yhat=phival*theta;

%simulare
ysimul=zeros(length(yval),1);
for k=1:length(yval)
    for i=1:na
        if(k>i)
        ysimul(k)=ysimul(k)-ysimul(k-i)*theta(i);
        end
    end
    for i=1:nb
if(k>i)
        ysimul(k)=ysimul(k)+uval(k-i)*theta(i+na);
end
    end
end
MSE=1/length(yval)*sum((yval'-ysimul).^2)
figure,
plot(yval);
hold on 
plot(yhat);
title('Predictie');

figure,
plot(yval);
hold on;
plot(ysimul);
title('Simulare');



