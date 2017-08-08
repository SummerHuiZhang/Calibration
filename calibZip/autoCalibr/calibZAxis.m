function zvec=calibZAxis(ptSet1, ptSet2, K) 

pairNum=length(ptSet1);
tc=zeros(3,pairNum);
fval=ones(1,pairNum);
for i=1:pairNum
    pts1=ptSet1{i};
    pts2=ptSet2{i};
    [tc(:,i),fval(i)]=getCamTrans(pts1,pts2,K);
end;
tc=tc./repmat(sign(tc(3,:)),[3,1]);
ws=exp(-fval/10);
zvec=sum(tc.*repmat(ws,[3,1]),2)/sum(ws);

