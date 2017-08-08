function F = EightPtsAlg(Pts1,Pts2,opt)
% Compute Fundamental matrix between two vector of 2d points by eigenvalue analysis.
% min sqr(norm(U*f)) subject to norm(f)=1
if (nargin==2) opt=1; end;
num = length(Pts1);

[pts1,H1] = htNorm2d(Pts1);
[pts2,H2] = htNorm2d(Pts2);

pts1 = [pts1;ones(1, num)];
pts1 = repmat(pts1,[3,1]);
pts2 = [repmat(pts2(1,:),[3,1]);
        repmat(pts2(2,:),[3,1]);
        ones(3,num)];
U = (pts1.*pts2)';

[V,D] = eig(U'*U);
[orderD,indx] = sort(diag(D));
V = V(:,indx);
F = reshape(V(:,1),[3,3])';
if (opt) 
    F = imprank2(F);
end
F = H2'*F*H1;

return

U = U(:,1:end-1);
F = U\-ones(num,1);
F = [F;1];
F = reshape(F,[3,3])';
F = imprank2(F);
F = H2'*F*H1;


