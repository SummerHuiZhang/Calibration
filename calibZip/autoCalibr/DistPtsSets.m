function [sqrDists, indxA, indxB] = DistPtsSets(A,B)
%compute the distance between two point sets

DistMat=[];

AMatx=repmat(A(1,:)',[1,size(B,2)]);
AMaty=repmat(A(2,:)',[1,size(B,2)]);

BMatx=repmat(B(1,:),[size(A,2),1]);
BMaty=repmat(B(2,:),[size(A,2),1]);

Matx=AMatx-BMatx;
Maty=AMaty-BMaty;

DistMat= Matx.^2+Maty.^2;

cpDists1=min(DistMat,[],2);
cpDists2=min(DistMat,[],1)';

%D1=(sum(A.^2)').*cpDists1/size(A,2);
%D2=(sum(B.^2)').*cpDists2/size(B,2);

D1=(sum(A.^2).^(1/2))'.*cpDists1/size(A,2);
D2=(sum(B.^2).^(1/2))'.*cpDists2/size(B,2);

sqrDists=[D1(:);D2(:)];

if (nargout>1)
    Dmax=0.15;
    indxA=find(sqrt(cpDists1)<Dmax);
    indxB=find(sqrt(cpDists2)<Dmax);
end

return
