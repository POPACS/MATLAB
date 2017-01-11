function [timemed] = sumTime_medikament(xx_medmatrix, tidpostop)
%Summerer opp væske gitt per tidsenhet til nærmeste time

timemed=[0 0] ;
t1 = 0;
t2 = 60;
med = 0;
idx5 = 1;
idxmed = 1;
sisteidx5 = 0; %for å slutte å adresse idx5 i xx_medmatrix
mark = 1;

if ~isempty(xx_medmatrix)

for i = 1:size(tidpostop,1)%round(tidpostop(end)/60)
if tidpostop(i,1) < t2
    if xx_medmatrix(idx5,2) < tidpostop(i,1)  
        if idx5==size(xx_medmatrix,1)
            if sisteidx5 == 0
%                med = med + xx_medmatrix(idx5,3);  
                %idxmed = idxmed + 1;
                timemed(idxmed,1) = t2/60 -1; %minus 1 for å starte på tid 0
                timemed(idxmed,2) = xx_medmatrix(idx5,3);        
                mark = 1;
                sisteidx5 = 1; 
            end    
        else %if idx5 < size(xx_medmatrix,1)
            med = med + xx_medmatrix(idx5,3);
            idx5 = idx5 + 1;     
        end
    end
else
    if mark == 1
        mark = 0;
        idxmed = idxmed + 1;
    else
        timemed(idxmed,1) = t2/60 -1; %minus 1 for å starte på tid 0
        timemed(idxmed,2) = med;        
        idxmed = idxmed + 1;
    end
    med = 0;
    t1 = t2;
    t2 = t2 + 60;   
    
end
%if (tidpostop(i+1) - tidpostop(i)) > 60
%    disp('Over 60 min mellom tidsenheter')
%end
if i == size(tidpostop,1)
    timemed(idxmed,1) = t2/60 -1; %minus 1 for å starte på tid 0
    timemed(idxmed,2) = med;
end
end

else
    timemed = [];
end

end





