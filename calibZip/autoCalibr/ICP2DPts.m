function [R,t,nPts1,nPts2]=ICP2DPts(Pts1,Pts2, opt)

if (nargin<3)
    opt=0;
end

param=zeros(3,1);
args.Pts1=Pts1;
args.Pts2=Pts2;

options = optimset('LargeScale','off','Display','on','LevenbergMarquardt','on');
[param,fval] =fminunc(@computeICPErr,param,options,args);

computeICPErr(param, args, opt);
theta=param(1);

R=[ cos(theta), -sin(theta);
    sin(theta), cos(theta)];
t=param(2:end);

[sqrDists, indx1, indx2] = DistPtsSets(R*Pts1+repmat(t,[1,size(Pts1,2)]),Pts2);

nPts1=Pts1(:,indx1);
nPts2=Pts2(:,indx2);

%-------------------------------------
function  err = computeICPErr(param, args, opt)

if (nargin<3)
    opt=0;
end

Pts1=args.Pts1;
Pts2=args.Pts2;
theta=param(1);

R=[ cos(theta), -sin(theta);
    sin(theta), cos(theta)];
t=param(2:end);

T=repmat(t,[1,size(Pts1,2)]);

Pts12=R*Pts1+T;
sqrDists = DistPtsSets(Pts12,Pts2);
%sqrDists = sort(sqrDists);
err=sum(sqrDists);

if (opt==1)
    plot(Pts1(1,:), Pts1(2,:),'g-', ...
        Pts12(1,:), Pts12(2,:),'r.-',Pts2(1,:), Pts2(2,:),'b.-');
    axis equal
end

return

