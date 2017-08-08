function [R,t]=getCamMotion(pts1,pts2,K);
%compute fundamental matrix F which minimize the distances from point to
%their projected epipolar lines, (with Sampson distance error)

 [R, t] = RecvMotion(pts1,pts2,K);
 ptsNum=size(pts1,2);
 
 pts1=[pts1;ones(1,ptsNum)];
 pts2=[pts2;ones(1,ptsNum)];
 options = optimset('LargeScale','off','LevenbergMarquardt','on','MaxFunEvals',1e+4,'Display','off');
 params0=[rodrigues(R);t];
 [params,fval] =fminunc(@getSampsonErr,params0,options,pts1,pts2,K);
 R=rodrigues(params(1:3));
 t=params(4:end);
 t=t/norm(t);
 %[params(1:3);t]'
 
 F=inv(K')*SkewSymMat(t)*R*inv(K);
 return
  
 %-------------------------------------------------------------------
function err=getSampsonErr(params,pts1,pts2,K)
 
 R=rodrigues(params(1:3));
 t=params(4:end);

 F=inv(K')*SkewSymMat(t)*R*inv(K);   % F=inv(K')*[T]R*inv(K)
 
 lines2=F*pts1;          %Epipolar lines on the image 2
 lines1=F'*pts2;         %Epipolar lines on the image 1
 
 mags1=sum(lines1(1:2,:).^2)+eps;
 mags2=sum(lines2(1:2,:).^2)+eps;
 err= sum(((sum(pts2.*lines2)).^2).*(1./(mags1 + mags2)))...
           + 10*(params(1:3)'*t)^2 +10*(norm(t)-1)^2  ;  %sampson distance
 %err= sum(((sum(pts2.*lines2)).^2).*(1./(mags1 + mags2)));  %sampson distance
 return
    