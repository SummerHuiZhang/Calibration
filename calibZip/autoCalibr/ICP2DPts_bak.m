function [R,t]=ICP2DPts(Pts1,Pts2)

param=zeros(3,1);

options = optimset('LargeScale','off','Display','off','LevenbergMarquardt','on');
A=Pts1;
for itr=1:40
    theta=param(1);
    R=[ cos(theta), -sin(theta);
        sin(theta), cos(theta)];
    t=param(2:end);
    A = R*A + repmat(t,[1,size(A,2)]);
    B = Pts2;
    [sqrDists, pairIndx] = DistPtsSets(A,B);
    [temp,ascIndx]= sort(sqrDists);
    ascIndx=ascIndx(1:end);
    ascA=A(:,ascIndx);
    pairIndx= pairIndx(ascIndx);
    ascB=B(:,pairIndx);
    [param,fval] =fminunc(@computeDistErr,zeros(3,1),options,ascA, ascB);
    if norm(param)<1e-10
        break;
    end
end;

[param,fval] =fminunc(@computeDistErr,param,options,Pts1(:,ascIndx), ascB);
theta=param(1);
R=[ cos(theta), -sin(theta);
    sin(theta), cos(theta)];
t=param(2:end);
Pts12 = R*Pts1 + repmat(t,[1,size(Pts1,2)]);

plot(Pts1(1,:), Pts1(2,:),'g-', ...
        Pts12(1,:), Pts12(2,:),'r-',Pts2(1,:), Pts2(2,:),'b-');
axis equal

%-------------------------------------
function  err = computeDistErr(param,A,B)

theta=param(1);

R=[ cos(theta), -sin(theta);
    sin(theta), cos(theta)];
t=param(2:end);

T=repmat(t,[1,size(A,2)]);

A=R*A+T;

err=sum(sum((A-B).^2));

return

%-------------------------------------%

function [sqrDists, pairIndx] = DistPtsSets(A,B)

DistMat=[];

AMatx=repmat(A(1,:)',[1,size(B,2)]);
AMaty=repmat(A(2,:)',[1,size(B,2)]);

BMatx=repmat(B(1,:),[size(A,2),1]);
BMaty=repmat(B(2,:),[size(A,2),1]);

Matx=AMatx-BMatx;
Maty=AMaty-BMaty;

DistMat= Matx.^2+Maty.^2;

[sqrDists,pairIndx]=min(DistMat,[],2);

return

%--------------------------------------%