function [t,fval]=getCamTranslation(pts1,pts2,K);
%assume camera does translation without rotation
%compute translation t which minimizes the distances from point to
%their projected epipolar lines, (with Sampson distance error)
 
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
 
 pts1=[pts1;ones(1,num)];
 pts2=[pts2;ones(1,num)];
 
 options = optimset('LargeScale','off','LevenbergMarquardt','on','Display','off');
 params0=[t];
 [params,fval] =fminunc(@getSampsonErr,params0,options,pts1,pts2,K);
 
 t=params;
 t=t/norm(t);
 
 R=eye(3);
 M=compute3DPt(pts1(1:2,1),pts2(1:2,1),R,t,K,1);
 if (M(3)<0)
     t=-t;
 end
 
 return
  
%-------------------------------------------------------------------
function err=getSampsonErr(params,pts1,pts2,K)
 
 t=params;

 F=inv(K')*SkewSymMat(t)*eye(3)*inv(K);   % F=inv(K')*[T]R*inv(K)
 
 lines2=F*pts1;          %Epipolar lines on the image 2
 lines1=F'*pts2;         %Epipolar lines on the image 1
 
 mags1=sum(lines1(1:2,:).^2)+eps;
 mags2=sum(lines2(1:2,:).^2)+eps;
 err= sum(((sum(pts2.*lines2)).^2).*(1./(mags1 + mags2)))...
           + 10*(norm(t)-1)^2  ;  %sampson distance
 %err= sum(((sum(pts2.*lines2)).^2).*(1./(mags1 + mags2)));  %sampson distance
 return
 
