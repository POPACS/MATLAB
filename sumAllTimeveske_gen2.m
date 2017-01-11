function [timeveske] = sumAllTimeveske_gen2(tidpostop, veskearray)
%Summerer opp alle v�sker gitt per tidsenhet til n�rmeste time
%OBS Flere rader med v�ske - bruk sumTimeveske dersom kun en rad

%Bytter ut alle NaN med 0 (tomme felter = 0 v�ske dokumentert)
%POveske(isnan(POveske)) = 0;
%veskebeh = [tidpostop POveske];
%timeveske = [0 0];
veskebeh = veskearray;
timeveske = [];
t1 = 0;
t2 = 60;
tv = 0;
idxveske = 1;



for i = 1:size(veskebeh,1)
    
if veskebeh(i,1) < t2
    tv = tv + veskebeh(i,2);
else
    timeveske(idxveske,1) = t2/60 -1; %minus 1 for � starte p� tid 0
    timeveske(idxveske,2) = tv;
    idxveske = idxveske +1;
    tv = veskebeh(i,2); 
    t1 = t2;
    t2 = t2 +60;   
end
%siste:
if i == size(veskebeh,1)
    timeveske(idxveske,1) = t2/60-1; %minus 1 jamf�r over
    timeveske(idxveske,2) = tv;    
    end
end
%%%%%%%



end

