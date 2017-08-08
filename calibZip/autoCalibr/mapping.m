function mapping(Indx,Phi,Delta,K,kc);

if nargin<5;
    kc=zeros(5,1);
end

imgFiles=filesInPath('./','jpg'); % load image filenames in the path
logFiles=filesInPath('./','log'); % load laser reading filenames in the path

img=imread(imgFiles{Indx});
log=readLaserLog(logFiles{Indx});
mapLaserPts(img,log,Phi,Delta,K,kc);

