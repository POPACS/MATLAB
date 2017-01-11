function [xx_medmatrix] = spes_medmatrix_POPACS(PasID,time, med_raw,string1,string2, antbokst)
%Funksjon for å returnere matrise med medikamenter mot tid
% Antbokst = antall bokstaver som skal brukes for å skille ord
%To mulige medikament kan kombineres, f.eks morfin og ketorax
%POmedc = char(med_txt(:,3));
%xmed_raw={};
%i = 1;
%for k = 1:size(med_raw,1)
%    if ~isnan(cell2num(med_raw(k,3)))
%        xmed_raw{i} = med_raw{k,:};
%        i = i+1;
%    end
%end


[l, med_time] = convertExceltime(med_raw(:,1));
med_txt = cell2char(med_raw(:,2));
med_num = cell2num(med_raw(:,3));



%Medikament 1:
xx_medmatrix = [];
for i = 1:size(med_txt,1)
  if med_txt(i,1:antbokst) == string1(1:antbokst)
%      idx5 = [idx5;i];
      tidspunktmed = (med_time(i)-time(1))*1440;
      xx_medmatrix = [xx_medmatrix;PasID tidspunktmed med_num(i,1)];  
  end
end


%Medikament 2:
if ~isempty(string2)
for i = 1:size(med_txt,1)
  if med_txt(i,1:antbokst) == string2(1:antbokst)
%      idx5 = [idx5;i];
      tidspunktmed = (med_time(i)-time(1))*1440;
      xx_medmatrix = [xx_medmatrix;PasID tidspunktmed med_num(i,1)];  
  end
end

%Sorterer tilslutt
try
xx_medmatrix = sortrows(xx_medmatrix,2);
catch
    disp('Medmatrix tom')
end


end