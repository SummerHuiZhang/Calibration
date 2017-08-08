function [R, t, nE] = RecvMotion(pts1,pts2,K)
%estimate camera motion (Rcam, tcam) from essential matrix
%for robot motion, the camera undergoes planar motion with rotation axis is perpendicular to t 

 num=size(pts1,2);
 npts1=inv(K)*[pts1;ones(1,num)]; 
 npts2=inv(K)*[pts2;ones(1,num)]; 
 
 F = EightPtsAlg(pts1,pts2);
 E = K'*F*K;
 E = E*sqrt(2)/sqrt(sum(E(:).^2));
 
 [U, S, V] = svd(E');
 
 t=V(:,3);
 T=SkewSymMat(t);
 
 constrSign=sign(sum((T*npts2).*(E*npts1)));
 if sum(constrSign)<0
     t=-t;
 end
 
 itrNum=20;
 thetas=rand(3,itrNum);
 mags=repmat(sum(thetas.^2),[3,1]);
 thetas=thetas./mags;
 
 options = optimset('LargeScale','off','Display','off','LevenbergMarquardt','on');
 
 for i=1:itrNum
    [params(:,i),fval(i)] =fminunc(@getFrobsNormErr,[thetas(:,i);t+ 0.1*rand(3,1)],options,E);
 end
 
 [fval,indx]=sort(fval);
 params=params(:,indx);
 theta=params(1:3,1);
 t=params(4:end,1);
 R=rodrigues(theta);
 
 M=compute3DPt(pts1(:,1),pts2(:,1),R,t,K,1);
 if (M(3)<0)
     t=-t;
 end
   
 nE= SkewSymMat(t)*R;

return

%-----------------------------------------%
function Err=getFrobsNormErr(params,E)
 
 theta=params(1:3);
 t=params(4:end);
 R=rodrigues(theta);
 T=SkewSymMat(t);
 
 errs=E-T*R;
 Err= sum(errs(:).^2);

return
