function [nphi,ndelta]=optimizeCalib(ptSets1,ptSets2,Rfs,tfs,phi,delta,K)

params=[rodrigues(phi);delta(1);delta(3);];

options = optimset('LargeScale','off','LevenbergMarquardt','on','Display','off');
[params,fval]=fminunc(@getEpipolarConstrErr,params,options,ptSets1,ptSets2,Rfs,tfs,K);
fval
nphi=rodrigues(params(1:3));
ndelta=[params(4),0,params(5)]';

for i=1:size(ptSets1,2);
   
   Rc=nphi'*Rfs{i}*nphi;                        % R=inv(phi)*Rf*phi   
   tc=nphi'*(Rfs{i}*ndelta-ndelta+tfs{i});      % T=inv(phi)*(Rf*delta-delta+Tf)
   F=inv(K)'*SkewSymMat(tc)*Rc*inv(K);          % F=inv(K')*[T]R*inv(K)
   errs(i)=getDistanceErr(F, ptSets1{i},ptSets2{i});
   disp([int2str(i),':',num2str(errs(i))]);   
end;
mean(errs)
return


%----------------residual funtion ------------------------------------%
function err=getEpipolarConstrErr(params, ptSets1,ptSets2,Rfs,tfs,K)

numM=size(ptSets1,2);
phi=rodrigues(params(1:3));
delta=[params(4),0,params(5)]';

err=0;

for i=1:numM 
 
    num=size(ptSets1{i},2);
    
    pts1=[ptSets1{i};ones(1,num)];
    pts2=[ptSets2{i};ones(1,num)];

    Rc=phi'*Rfs{i}*phi;                        % R=inv(phi)*Rf*phi   
    tc=phi'*(Rfs{i}*delta-delta+tfs{i});       % T=inv(phi)*(Rf*delta-delta+Tf)
    %tc=phi'*tfs{i};  
    
    F=inv(K)'*SkewSymMat(tc)*Rc*inv(K);   % F=inv(K')*[T]R*inv(K)
 
    lines2=F*pts1;          %Epipolar lines on the image 2
    lines1=F'*pts2;         %Epipolar lines on the image 1
 
    mags1=sum(lines1(1:2,:).^2)+eps;
    mags2=sum(lines2(1:2,:).^2)+eps;
    err= err+sum(((sum(pts2.*lines2)).^2).*(1./(mags1 + mags2 +eps)));  %sampson distance
    %err= err+sum(((sum(pts2.*lines2)).^2).*( 1./mags1 + 1./mags2));  
    
end

return;



