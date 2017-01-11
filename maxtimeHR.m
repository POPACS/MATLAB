function [timeHR] = maxtimeHR(perioptime, HR)


maxHR = [];
t1 = 0;
t2 = 60;
tv = 0;
idxHR = 1;
timeHR = [];
idxmaxHR = 1;

try
for i = 1:size(HR,1)
if perioptime(i,1) < t2
    maxHR(idxmaxHR) =  HR(i,1);
    idxmaxHR = idxmaxHR + 1;
else
    timeHR(idxHR,1) = t2/60 -1; %minus 1 for å starte på tid 0
    timeHR(idxHR,2) = max(maxHR);
    idxHR = idxHR + 1;
    t1 = t2;
    t2 = t2 +60;   
    maxHR = [];
    idxmaxHR = 1;
end    
if i == size(HR,1)
    timeHR(idxHR,1) = t2/60 -1; %minus 1 for å starte på tid 0
    timeHR(idxHR,2) = max(maxHR);
end
end
catch
    disp('Break at time HR:')
    disp(int2str(perioptime(i)))
end
timeHR


end
