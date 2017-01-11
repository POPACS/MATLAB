function [timetoevent] = find_timeoffnoradr_sisteevent(PO_Noradr,tidpostop)

%a = [tidpostop PO_Noradr]

idx = [];
timetoevent = 0;
if size(PO_Noradr,1) ~= size(tidpostop,1)
    disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!lengde noradr-matrise feil')
end

if PO_Noradr(end)>0 %Noradrenalin hele veien
    timetoevent = tidpostop(end)
    disp('Noradrenalin hele veien')
else
    
if nansum(PO_Noradr) == 0;
timetoevent = 0;
else
for i = 1:(size(PO_Noradr,1)-1)
    if PO_Noradr(i) == 0 & PO_Noradr(i-1) > 0 %Finner kombinasjonen 1 - 0, dvs noradr av.
        idx = [idx;i];
    end
       
end

if isempty(idx)
timetoevent = 0;
end
if size(idx,1) > 1 %På noradrenalin igjen minst en gang
        disp('På noradrenalin igjen')
        timetoevent = tidpostop(idx(end));
else
        timetoevent = tidpostop(idx(1));
end

end %nansum

end %PO_Noradr(end)>0

end
