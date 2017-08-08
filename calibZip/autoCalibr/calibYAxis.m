function [yvec,Rcs,tcs]=calibYAxis(ptSet1, ptSet2, Rfs, K) 

pairNum=length(ptSet1);
for i=1:pairNum
    pts1=ptSet1{i};
    pts2=ptSet2{i};
    [Rcs{i},tcs{i}]=getCamMotion(pts1,pts2,K);
end;

A=zeros(3,pairNum);
for i=1:pairNum
    rf=rodrigues(Rfs{i});
    rc=rodrigues(Rcs{i});
    rf=rf/norm(rf);
    rc=rc/norm(rc);
    A(:,i)=rc/rf(2);
end

yvec=mean(A,2);
yvec=yvec/norm(yvec);






