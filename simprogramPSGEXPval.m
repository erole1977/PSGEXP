function [Stats1,Stats2,ONG,B1,RMSETEST,SMAPETEST]=simprogramPSGEXPval(x,ntest,pbest,drcbest)
B1=[1,2,3];
for i4=1:30
    i4 
    [xkaptest{i4,1},SMAPEtest(i4),rmsetest(i4),itn,rn(i4),pgbest]=psgmexppsotest(x,pbest,drcbest,ntest);
    B1=[B1;[rmsetest(i4),SMAPEtest(i4),rn(i4)]];
end  
B1=B1(2:end,:);
Stats1=[mean(B1(:,1)),median(B1(:,1)),std(B1(:,1)),iqr(B1(:,1)),min(B1(:,1)),max(B1(:,1))];
Stats2=[mean(B1(:,2)),median(B1(:,2)),std(B1(:,2)),iqr(B1(:,2)),min(B1(:,2)),max(B1(:,2))];
minB1=min(B1(:,1));
for i=1:length(B1(:,1))
    if minB1(1)==B1(i,1)
       ONG=xkaptest{i,1};
       RMSETEST=B1(i,1);SMAPETEST=B1(i,2);
       break
    end
end
end