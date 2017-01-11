function [data] = cleanData(v, type)
% Funksjon som renser datarekke fra Excel og tvinger den inn i et format
%
%Type = 1 - tall
%Type = 2 - tekst

%v = str2num(cell2mat(fys_raw(:,4))) 
%v = fys_raw(:,4);
%x = cell2char(v);
for i = 1:length(v)
    y(i) = str2double(v(i,:)) ;
    %NULLidx = [NULLidx; i];
end


%NULLidx = [];
%for i = 1:length(v)
%if strmatch('NULL',cell2mat(v(i)))
%    v(i) = 'NaN'
%    %NULLidx = [NULLidx; i];
%end
%end

data = y;
end