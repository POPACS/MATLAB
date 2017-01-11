function [timeNoradr] = maxtimeNoradr(perioptime, Noradr)
%Summerer opp alle væsker gitt per tidsenhet til nærmeste time
%OBS Flere rader med væske - bruk sumTimeveske dersom kun en rad
% Doserange: Noradrenalin (1 = < 0.05; 2=<0.1;3=<0.15;
%4=<0.2;5=<0.25;6=<0.30;7=>0.30)

maxNA = [];
t1 = 0;
t2 = 60;
tv = 0;
idxNA = 1;
timeNoradr = [];
idxmaxNA = 1;

try
for i = 1:size(Noradr,1)
if perioptime(i,1) < t2
    maxNA(idxmaxNA) =  Noradr(i,1);
    idxmaxNA = idxmaxNA + 1;
else
    timeNoradr(idxNA,1) = t2/60 -1; %minus 1 for å starte på tid 0
    timeNoradr(idxNA,2) = max(maxNA);
    idxNA = idxNA + 1;
    t1 = t2;
    t2 = t2 +60;   
    maxNA = [];
    idxmaxNA = 1;
end    
if i == size(Noradr,1)
    timeNoradr(idxNA,1) = t2/60 -1; %minus 1 for å starte på tid 0
    timeNoradr(idxNA,2) = max(maxNA);
end
end
catch
    disp('Break at index Noradr:')
    disp(int2str(perioptime(i)))
end


end

