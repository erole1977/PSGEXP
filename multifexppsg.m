function [y]=multifexppsg(x,pgbest,m,drc)
% x girdi, w aðýlýk, b yan aðýrlýk, mi gecikme sayýsý, drc model derecesi
%Program Exponential smoothing ve Pi Sigmanýn hibritine göre çýktý hesaplýyor.
xorj=x;
W(1,:)=pgbest(1:drc);
    for j=2:m
        W(j,:)=pgbest(drc*(j-1)+1:drc*j);
    end
b=pgbest(drc*m+1:drc*m+drc);
alfa1=pgbest(drc*m+drc+1);
alfa2=pgbest(drc*m+drc+2);
x=diff(x);
x=[0;x];
M=lagmatrix(x,(1:m));
M2=lagmatrix(xorj,(1:m));
n=length(x);
M=M((m+1):n,:)';
M2=M2((m+1):n,:)';
nr=size(M',1);
y1=zeros(nr,1);
y2=zeros(nr,1);
y=zeros(nr,1);
for i=1:nr
    if i==1
        for j=1:drc
            a(j)=sum(M(:,i).*W(:,j))+b(j);
        end
            y1(i)=1/(1+exp(-prod(a)));
            y(i)=y1(i);
    else
        for j=1:drc
            a(j)=sum(M(:,i).*W(:,j))+b(j);
        end
        y1(i)=1/(1+exp(-prod(a)));
        y2(i)=M2(1,i)*alfa1+y(i-1)*(1-alfa1);
        y(i)=alfa2*y1(i)+(1-alfa2)*y2(i);
    end
end
end