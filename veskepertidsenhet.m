function [nyveskearray] = veskepertidsenhet(tid, veske1)

%veske1tid = [tidperiop cell2mat(Isoveske1)];
veske1tid = [tid cell2mat(veske1)];
fluidarray = [];

idx_start = find(veske1tid(:,2) >= 0); %må gjøres før NaN byttes med 0
%idx_stopp = find(veske1 == 0) 
veske1(idx_start);

%veske1tid = [tidperiop cell2mat(Isoveske1)];
veske1tid(isnan(veske1tid)) = 0; %bytter ut alle NaN med 0
nyveskearray = veske1tid; %denne skal det fylles inn i 

idx_idx_start = 1;
try
%for i = 1:size(veske1)
for i = 1:idx_start(end) %løper bare til siste element der registrert
    if ismember(i,idx_start) 
    pose = veske1tid(i,2);
    idx_idx_start = idx_idx_start + 1;
    posetid = veske1tid(idx_start(idx_idx_start),1) - veske1tid(idx_start(idx_idx_start - 1),1);
    rate = pose/posetid;
    for k = idx_start(idx_idx_start-1):idx_start(idx_idx_start)-1
    diff = veske1tid(k+1,1) - veske1tid(k,1);
    nyveskearray(k,2) = diff*rate;
    end
end
end
catch
    %disp(['Problemer i indexering på linje ' int2str(i)])
end

%sum(nyveskearray(:,2))
end
