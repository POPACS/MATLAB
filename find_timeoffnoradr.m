function [timetoevent] = find_timeoffnoradr(Noradr,time,idx2)

idx = [];
timetoevent = 0;
if size(Noradr,1) ~= size(time,1)
    disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!lengde noradr-matrise feil')
end

lengde = (size(Noradr,1));

for i = idx2:(lengde-1)
   if Noradr(i+1) == 0 && Noradr(i) > 0
%       disp(i+1)
        idx = i;
   end       
  
   %if i > idx2+1 
   if Noradr(i+1) > 0 && Noradr(i) == 0 
       disp('P� NORADRENALIN IGJEN') 
       i
       idx = 10000;%OBS! f�r ikke tidspunkt for p� nora og av igjen
       %disp(num2str(datestr(time(i+1))))
   end 
   %end       
   if i == lengde-1
   if Noradr(lengde) > 0
%       disp(i+1)
        idx = 10000;
        disp('P� NORARENALIN ved 24 timer')
   end
   end
  
  
end
%

if isempty(idx)
    timetoevent = 0;
else
    if(idx == 10000)
    timetoevent = 1440; %P� nora ved 24 timer / eller p� igjen!!
    else
    timetoevent = (time(idx+1)-time(idx2))*1440;
    end
end

end