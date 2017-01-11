function [tidsrekke, time] = convertExceltime(excelrekke) 
%Returnerer tidsrekke - char uttrykk for tid
%Returnerer time - numerisk uttrykk for tid
%midnatt = 0;
Timeline = excelrekke; %obs kolonne
Timeline = cell2char(Timeline);
time = [];

for i = 1:size(Timeline,1)
    try
    %datenum(Y,M,D,H,MN,S):
    l = datenum(str2num(Timeline(i,1:4)),str2num(Timeline(i,6:7)),str2num(Timeline(i,9:10)),...
    str2num(Timeline(i,12:13)),str2num(Timeline(i,15:16)),str2num(Timeline(i,18:19)));
%datestr(l)
    time = [time;l];
    catch
    disp(['Invalid date at ',int2str(i)])
    end
end

tidsrekke = Timeline;

end