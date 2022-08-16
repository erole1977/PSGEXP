function [rmsetest,mapetest,msebest,pgbest,rmse,yhatg,yhattestg,rn,mape,itn]=psgmexpsincostest(xt,mi,drc,ntest)
itr=1000;
ps=50;
% m girdi sayýsý
msebestEski=10^6;kk=0;
x0=xt;
n0=length(xt);
xtest=x0((n0-ntest+1):n0);
xt=x0(1:(n0-ntest));
x=(xt-min(xt))/(max(xt)-min(xt));
saat=clock;
rand('seed',saat(6)*10000000);
%rand('seed',254740000);
rn=rand('seed');
p=drc*mi+drc+2;
%p parametre sayýsý
n=length(x);
A=unifrnd(0,1,ps,p);
for k=1:ps
    yhat=multifexppsg(x,A(k,:),mi,drc);
    nh=length(yhat);
    for i=1:nh
        hata(i)=(i/nh)*(yhat(i)-x(n-nh+i))^2;
    end
        mse(k)=mean(hata);
end
%en iyi parçacýðý saklýyor.
MSEegt=min(mse);
for i=1:ps
    if MSEegt==mse(i)
        dd=i;
        break
    end
end
pgbest=A(dd,:);
msebest=mse(dd);
pid=A;
msepid=mse;
i22=0;
for i1=1:itr
    i1
    i22=i22+1;
    % Güncelleme
    a = 2;
    r1=a-i1*((a)/itr);
    r2=(2*pi)*rand();
    r3=2*rand;
    r4=rand();
    for i2=1:size(A,1)
        for i3=1:size(A,2)
            if r4<0.5
                % Eq. (3.1)
                A(i2,i3)= A(i2,i3)+(r1*sin(r2)*abs(r3*pgbest(i3)-A(i2,i3)));
            else
                % Eq. (3.2)
               A(i2,i3)= A(i2,i3)+(r1*cos(r2)*abs(r3*pgbest(i3)-A(i2,i3)));
            end
            if i3>p-2
                A(i2,i3)=min(1,max(0,A(i2,i3)));
            end
        end  
    end
    if i22>=100
        A=unifrnd(0,1,ps,p);
        i22=0;
    end
    for k=1:ps    
        yhat=multifexppsg(x,A(k,:),mi,drc);
        nh=length(yhat);
        for i=1:nh
            hata(i)=(i/nh)*(yhat(i)-x(n-nh+i))^2;
        end
        mse(k)=mean(hata);
    end
    %en iyi parçacýðý saklýyor.
    MSEegt=min(mse);
    for i=1:ps
        if MSEegt==mse(i)
            dd=i;
            break
        end
    end
    if MSEegt<msebest
         pgbest=A(dd,:);
         msebest=mse(dd);
         [i1,msebest]
    end
    if abs((msebestEski-msebest)/msebest)<10^-3
        kk=kk+1;
    else
        kk=0;
    end
    if kk>100
            break
    end
    msebestEski=msebest;
end
itn=i1;
       yhat=multifexppsg(x,pgbest,mi,drc);       
       nh=length(yhat);
       yhatg=(yhat)*(max(xt)-min(xt))+min(xt);
        for i=1:nh
            hata(i)=(yhatg(i)-xt(n-nh+i))^2;
            hata2(i)=abs((yhatg(i)-xt(n-nh+i))/xt(n-nh+i));
        end
    rmse=mean(hata)^0.5;
    mape=mean(hata2);
    x=(x0-min(x0))/(max(x0)-min(x0));
    yhattum=multifexppsg(x,pgbest,mi,drc); 
    nt=length(yhattum);
    yhattest=yhattum((nt-ntest+1):nt);
    yhattestg=(yhattest)*(max(xt)-min(xt))+min(xt);
    for i=1:ntest
        hata3(i)=(xtest(i)-yhattestg(i))^2;
        hata4(i)=abs((xtest(i)-yhattestg(i))/xtest(i));
    end
    rmsetest=(mean(hata3))^0.5;
    mapetest=mean(hata4);
end