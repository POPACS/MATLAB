function [timesBT] = maxtimesBT(perioptime, sBT)


maxsBT = [];
t1 = 0;
t2 = 60;
tv = 0;
idxsBT = 1;
timesBT = [];
idxmaxsBT = 1;

try
for i = 1:size(sBT,1)
if perioptime(i,1) < t2
    maxsBT(idxmaxsBT) =  sBT(i,1);
    idxmaxsBT = idxmaxsBT + 1;
else
    timesBT(idxsBT,1) = t2/60 -1; %minus 1 for å starte på tid 0
    timesBT(idxsBT,2) = min(maxsBT);
    idxsBT = idxsBT + 1;
    t1 = t2;
    t2 = t2 +60;   
    maxsBT = [];
    idxmaxsBT = 1;
end    
if i == size(sBT,1)
    timesBT(idxsBT,1) = t2/60 -1; %minus 1 for å starte på tid 0
    timesBT(idxsBT,2) = min(maxsBT);
end
end
catch
    disp('Break at time sBT:')
    disp(int2str(perioptime(i)))
end
timesBT


end
