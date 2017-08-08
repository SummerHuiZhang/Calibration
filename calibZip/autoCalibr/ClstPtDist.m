function  residual = ClstPtDist(R, t, Pts1, Pts2, opt)
% R 2x2 matrix t-2x1

if (nargin<5)
    opt=0;
end

T=repmat(t,[1,size(Pts1,2)]);
Pts12=R*Pts1+T;

sqrDists1 = DistPtsSets(Pts12,Pts2);
residual=sum(sqrDists1);

if (opt==1)
    plot(Pts1(1,:), Pts1(2,:),'g-', ...
        Pts12(1,:), Pts12(2,:),'r-',Pts2(1,:), Pts2(2,:),'b-');
    axis equal
end

return
