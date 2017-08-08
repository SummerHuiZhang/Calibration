%add_path('./TOOLBOX_calib')
f=128/tan(22.5/180*pi);  %focal lens of the camera ( camera view angle is 45 degree )
K=[f  0  127.5;
   0  f  127.5;
   0  0      1];         % K is camera internal matrix, and image resolution is 256 x 256 

Phi=rodrigues([-20/180*pi,-10/180*pi, 0]);  % extact camera orientation Phi and position Delta
Delta=[-0.15 -0.5 -0.25]';

% suppose the robot moved straightforward,  camera and laser data was
% captured at the time instants 0 ~ 10, and the image files were named as, say, 
% 0.jpg ~ 10.jpg, and laser readings were saved as 0.log ~ 10.log 
% here, for example, the data from at consecutive time instants was grouped as one motion
lpair=[0:9; 1:10]; % 10 motions 
for i=1:size(lpair,2)
    a=imread([int2str(lpair(1,i)),'.jpg']); a=rgb2gray(a); % read image I
    b=imread([int2str(lpair(2,i)),'.jpg']); b=rgb2gray(b); % read image I'
    
    [pts1,pts2]=ransacSteroMatch(a, b, .75); % extact feature correspondances between I and I' 
    
    %------- or given SIFT features from I and I', extract feature correspondances ---%    
    % akey=[int2str(lpair(1,i)),'.key'];
    % bkey=[int2str(lpair(1,i)),'.key'];
    % [pts1,pts2]=StereoMatchSIFT( a,akey, b, bkey);
    
    
    lptSet1{i}=pts1;  
    lptSet2{i}=pts2;
end

% compute camera Z axis in the reference frame of the laser range finder
zvec=calibZAxis(lptSet1, lptSet2, K); 


% more camera and laser data was captured as the robots moved around with
% rotations and translations.

rpair=[11 12 15 16 17;
       12 14 16 17 18];  % 5 motions 

for i=1:size(rpair,2)
    
    a=imread([int2str(rpair(1,i)),'.jpg']); a=rgb2gray(a); % read image I
    b=imread([int2str(rpair(2,i)),'.jpg']); b=rgb2gray(b); % read image I'
    
    [pts1,pts2]=ransacSteroMatch(a, b, .75 );  % extact feature correspondances between I and I'

    %------- or given SIFT features from I and I', extract feature correspondances ---%    
    % akey=[int2str(lpair(1,i)),'.key'];
    % bkey=[int2str(lpair(1,i)),'.key'];
    % [pts1,pts2]=StereoMatchSIFT( a,akey, b, bkey);
    
    rptSet1{i}=pts1;
    rptSet2{i}=pts2;
    
    lsr1=readlaserlog([int2str(rpair(1,i)),'.log']); % read laser reading l
    lsr2=readlaserlog([int2str(rpair(2,i)),'.log']); % read laser readung l'
    
    [R, t, lsrPts1{i},lsrPts2{i}]=getLsrMotion(lsr1,lsr2); % estimate the motion (R, t) of laser range finder
    
    Rf{i}=R;
    tf{i}=t;
end   

% compute camera y axis in the reference frame of the laser range finder 
[yvec,Rcs,tcs]=calibYAxis(rptSet1, rptSet2, Rf, K);

xvec=cross(yvec,zvec); % camera x axis is cross product of camera y and z axis

phi=[xvec,yvec,zvec]'; 
phi=rodrigues(rodrigues(phi)); % camera orientation

delta=zeros(3,1);

% with initial guess of camera orientation, do global optimization on the coherent motions
% constraints  
[nphi,ndelta]=optimizeCalib(rptSet1,rptSet2,Rf,tf,phi,delta,K);

