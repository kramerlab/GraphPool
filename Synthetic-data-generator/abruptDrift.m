clear all; close all; 
warning off;

d = 2;
nobj= 1000000;
noisePercentage = 0.05;
batchSize = 1000;
numplots = nobj/batchSize;
fname = 'abruptHP.txt';

tic
n = [1:nobj/2]';
w(1:nobj/4, 1) = 1;
w(1:nobj/4, 2) = 1;
w(nobj/4+1:nobj/2, 1) = 1;
w(nobj/4+1:nobj/2, 2) = -1;
w(nobj/2+1:3*nobj/4, 1) = 1;
w(nobj/2+1:3*nobj/4, 2) = 1;
w(3*nobj/4+1:nobj, 1) = 1;
w(3*nobj/4+1:nobj, 2) = -1;

%generate random points
attVal = rand(nobj,2);
s = sum(w.*attVal,2);
sw = sum(w,2);
label = (s >= 0.5*sw);

%add noise
r = rand(nobj,1);
ns = (r <= noisePercentage);
indx = (ns == 1);
for i=1:nobj
    if ns(i) == 1
        label(i) = 1-label(i);
    end
end
data = [attVal label];

toc

tic
dlmwrite(fname,data,'newline','pc');
toc
      
