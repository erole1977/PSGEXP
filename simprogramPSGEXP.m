function [Stats1,Stats2,ONG,B1,B,RMSETEST,SMAPEtest,pbest,drcbest]=simprogramPSGEXP(x,ntest)
p=1:5;drc=2:5;
%p girdi sayýsýný gösterir, drc pi-sigmanýn derecesidir drc 2:5 alýnabilir
kk=0;
B=[1,2,3,4];
for i1=1:length(p)
    for i2=1:length(drc)
        for i3=1:5
            kk=kk+1;
            [xkaptest1,SMAPEtest,rmsetest(kk),itn,rn(kk),pgbest]=psgmexppsotest(x,p(i1),drc(i2),ntest);
            B=[B;[p(i1),drc(i2),rmsetest(kk),rn(kk)]];
        end
     end
end
B=B(2:end,:);
minB=min(B(:,3));
for i=1:length(B(:,3))
    if minB(1)==B(i,3)
        pbest=B(i,1);
        drcbest=B(i,2);
        break
    end
end
B1=[1,2];
for i4=1:30
    i4 
    [xkaptest{i4,1},SMAPEtest,rmsetest(i4),itn,rn(i4),pgbest]=psgmexppsotest(x,pbest,drcbest,ntest);
    B1=[B1;[rmsetest(i4),rn(i4)]];
end  
B1=B1(2:end,:);
Stats1=[mean(B1(:,1)),median(B1(:,1)),std(B1(:,1)),iqr(B1(:,1)),min(B1(:,1)),max(B1(:,1))];
Stats2=[mean(B1(:,2)),median(B1(:,2)),std(B1(:,2)),iqr(B1(:,2)),min(B1(:,2)),max(B1(:,2))];
minB1=min(B1(:,1));
for i=1:length(B1(:,1))
    if minB1(1)==B1(i,1)
       ONG=xkaptest{i,1};
       RMSETEST=B1(i,1);
        break
    end
end
end