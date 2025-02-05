clear all
clc
close all

load ('lab5_3.mat');

Uid = id.InputData;
Yid = id.OutputData;
Uval = val.InputData;
Yval = val.OutputData;

figure
subplot(221)
plot(Yid)
subplot(223)
plot(Uid)
subplot(222)
plot(Yval)
subplot(224)
plot(Uval)


Yid = detrend(Yid);
plot(Yid)
Uid = detrend(Uid);
plot(Uid)

M = 35;
N = length(Yid);
ru = zeros(N,M);

for i = 1:N
    for j = 1:M
        tau = abs(i-j);
        for k = 1:N-tau
            ru(i,j) = ru(i,j) + Uid(k+tau)*Uid(k);
        end
        ru(i,j) = ru(i,j)/N;
    end
end


ryu = zeros(N,1);
for tau = 1:N
    for k = 1:N-tau+1
        ryu(tau) = ryu(tau) + Yid(k+tau-1)*Uid(k);
    end
    ryu(tau)=ryu(tau)/N;
end


Yh = ru\ryu;
stem(Yh)

Yid_aprox = conv(Yh,Uid);
Yid_aprox = Yid_aprox(1:length(Yid));
Yval_aprox = conv(Yh,Uval);
Yval_aprox = Yval_aprox(1:length(Yval));

% MSE
MSEid = sum((Yid-Yid_aprox).^2);
MSEid = MSEid / length(Yid);

MSEval = sum((Yval - Yval_aprox).^2);
MSEval = MSEval / length(Yval);


figure
plot(Yid_aprox); hold on
plot(Yid); hold off
title("MSE: ",MSEid);
figure
plot(Yval_aprox); hold on
plot(Yval); hold off
title("MSE: ",MSEval);



