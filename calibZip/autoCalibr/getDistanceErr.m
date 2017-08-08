function [meanErr, errs]=getDistanceErr(F,pts1,pts2)

num=size(pts1,2);
pts1=[pts1;ones(1,num)];
pts2=[pts2;ones(1,num)];

lines1=F*pts1;
lines2=F'*pts2;

mags1=sqrt(sum(lines1(1:2,:).^2));
mags2=sqrt(sum(lines2(1:2,:).^2));

errs=abs(sum(pts2.*lines1)).*(1./mags1+1./mags2);
meanErr=sum(errs)/(2*num);
