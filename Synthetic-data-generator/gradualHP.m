clear all; close all; 
warning off;

d = 2;
nobj= 25000;
noisePercentage = 0.05;
batchSize = 1000;
numplots = nobj/batchSize;
fname = 'gradTest.txt';

tic
n = [1:nobj/2]';
w(1:nobj/2, 1) = 2*n./nobj;
w(1:nobj/2, 2) = 0.5- 2*n./nobj;
w(nobj/2+1:nobj, 1) = 0.5- 2*n./nobj;
w(nobj/2+1:nobj, 2) = 1-2*n./nobj;

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
dlmwrite(fname,data,'-append','newline','pc');
toc

for i=1:nobj
    if(mod(i-1,batchSize) ==0)
        %figure;
        subplot(4,nobj/(4*batchSize),floor(i/batchSize)+1)
    end
    if(data(i,end)==1)
        plot(data(i,1),data(i,2),'*r'); hold on;                
    else
        plot(data(i,1),data(i,2),'*g'); hold on;        
    end
end

      
