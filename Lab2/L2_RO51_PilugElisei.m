
load('lab2_01');

xid = id.X;
yid = id.Y;
xval = val.X;
yval = val.Y;
% identificare
figure;
plot(xid,yid);
% formam matricea phi
n=20;
phi=[];
for i=1:length(xid)
    for j=1:n
        L(j)=xid(i)^(j-1);

    end
    phi=[phi;L]
end
theta=phi\yid';
figure;
phival=[];
for i=1:length(xval);
    for j=1:n
        L(j)=xval(i)^(j-1);

    end
    phival=[phival;L];
end
yhat=phival*theta;
plot(xval,[yhat';yval]);
figure;
plot(xval,(yhat'-yval));
MSE=1/length(yval)*sum((yval'-yhat).^2)


