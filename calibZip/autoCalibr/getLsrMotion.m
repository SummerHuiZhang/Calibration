function [lsrR, lsrt,nlsrPts1,nlsrPts2]=getLsrMotion(lsrDs1,lsrDs2)
% compute motion (R, t) of the laser rangefinder by matching 
% two sets of laser range points. And return the laser points 
% in the overlapping part
 
 theta=(0:179)/180*pi;   
 
 lsrPts1=repmat(lsrDs1,[2,1]).*[cos(theta);sin(theta)];
 lsrPts2=repmat(lsrDs2,[2,1]).*[cos(theta);sin(theta)];    
  
 % find the odd laser measurements
 indx1= find([abs(diff(lsrDs1)),0]<0.75);
 indx2= find([abs(diff(lsrDs2)),0]<0.75);
 
 nPts1=lsrPts1(:,indx1);
 nPts2=lsrPts2(:,indx2);
 
 thrd=1e-4;
 preV=zeros(3,1);
 
 [R,t,nPts1,nPts2]=ICP2DPts_bak(nPts1,nPts2,eye(2),zeros(2,1));
 
 for i=1:10; 
   [R,t,nPts1,nPts2]=ICP2DPts(nPts1,nPts2);
   itrDff=norm([acos(R(1));t]-preV);
   if itrDff<thrd
       break;
   end
   preV=[acos(R(1));t];
 end
 
lsrPts12=R*lsrPts1+ repmat(t,[1 length(lsrPts1)]);
 plot(lsrPts1(1,:), lsrPts1(2,:),'g-', ...
     lsrPts12(1,:), lsrPts12(2,:),'r-',lsrPts2(1,:), lsrPts2(2,:),'b-');
 axis equal

 R=[R(1,1) 0 R(1,2); 0 1 0; R(2,1) 0 R(2,2)];
 t=[t(1) 0 t(2)]';
 

 
 
 