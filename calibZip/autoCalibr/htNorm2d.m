function [Ptn,Mnorm] = Htnorm2d(Pt);

% HTNORM2D Normalize an input matrix of 2D points, as hartley proposal. The matrix
%   structure is [x1 coordinate, y1 coordinate; ... ;xn coordinate, yn coordinate].
%
% Usage : [Ptn,Mnorm] = Htnorm2d(Pt) or Ptn=Htnorm2d(Pt)
%    Input  : One vector of 2D points, Pt
%    Output : The normalised vector, Ptn
%           : The matrix that achieve the normalization, Mnorm
%
% This code comes with no guarantee or warranty of any kind.
%
% Nuno Alexandre Cid Martins
% Coimbra, Mar 1, 2001

erro=-1;
if (nargin==0),
  erro=0;
else
  if (isstr(Pt)),
    erro=0;
  else
    if (size(Pt,1)==2 & size(Pt,2)~=2),
      Pts=Pt';
    else
      Pts=Pt;
    end;
    if (size(Pts,2)~=2),
      erro=0;
    else
      d=[];
      if (size(Pts,1)<2),
        erro=1;
      else
        s=sum(Pts);
        x=s(1)/size(Pts,1);
        y=s(2)/size(Pts,1);
        Ptn=Pts-[x*ones(size(Pts,1),1) y*ones(size(Pts,1),1)];
        for i=1:size(Ptn,1),
          d=[d;sqrt(Ptn(i,1)^2+Ptn(i,2)^2)];
        end;
        Dm=mean(d);
        sf=sqrt(2)/Dm;
        for i=1:size(Ptn,1),
          Ptn(i,1)=Ptn(i,1)*sf;
          Ptn(i,2)=Ptn(i,2)*sf;
        end;
        Ptn=Ptn';
        Mnorm=[sf 0 -sf*x;0 sf -sf*y;0 0 1];
      end;
    end;
  end;
end;
switch erro,
  case 0,
    error('Requires a matrix of 2D points, [x1,y1; ... ;xn,yn], as input argument.');
  case 1,
    error('The matrix should has, at least, two points.');
end;
