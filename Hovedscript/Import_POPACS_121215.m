%% IMPORTSCRIPT POPACS

format short g

cd('M:\POPACS\Matlab')

[g,datafiler] = xlsread('Dirliste PICIS datafiler POPACS.xlsx');
cd('M:\POPACS\Matlab\Input')
[a,b,demographics] = xlsread('WebCRF_Demographic data highlighted StOlav.xlsx');

for I = 35 %size(datafiler,1)+1
cd('M:\POPACS\Matlab')
    
fil_f = datafiler(I,1) %fys
fil_f = deblank(char(fil_f));
PasID = cell2num(demographics(I+1,4))


%Lese inn PICIS data
cd('M:\POPACS\Matlab\Input\PICIS Uttrekk med v�skedata')
[a,b,fys_raw] = xlsread(fil_f,'M�ledata','A2:AA4000');
[a,b,med_raw] = xlsread(fil_f,'Medikamenter','A2:D100');
[a,b,bg_raw] = xlsread(fil_f,'Blodgass','A2:C500');
clearvars a b %sletter un�dvendige variabler

cd('M:\POPACS\Matlab')

%Demografi
Alder = cell2num(demographics(I+1,2));
Kjonn = cell2num(demographics(I+1,7)); % 1 = mann, 0 = kvinne
vekt = str2num(cell2mat(fys_raw(2,3)));
try
hoyde = str2num(cell2mat(fys_raw(2,2)));
bmi = vekt/(hoyde/100*hoyde/100);
catch
    hoyde = nan;
    bmi = nan;
end

%%%%%%% TIDSVARIABLER - Hente ut tidspunkter for prim�r tidsrekke:

[tidsrekke, time] = convertExceltime(fys_raw(:,1));
tidlengde = length(time); %Lengde p� tidsvektor
fys_raw = fys_raw(1:tidlengde,:);
[l,AneStart] = convertExceltime(fys_raw(1,12));
[l,AneSlutt] = convertExceltime(fys_raw(1,15));
[l,KirStart] = convertExceltime(fys_raw(1,13));
[l,KirSlutt] = convertExceltime(fys_raw(1,14));
Dato =  datenum(str2num(l(1,1:4)),str2num(l(1,6:7)),str2num(l(1,9:10)),0,0,0);
AneStart = datestr(AneStart)
AneSlutt = datestr(AneSlutt);
KirStart = datestr(KirStart);
KirSlutt = datestr(KirSlutt);
perioptime = [];
for i = 1:tidlengde
l = (time(i)-time(1)) * 1440;
perioptime = [perioptime;l]; 
end

%Excel CRF
cd('M:\POPACS\Matlab\Hovedscript')
Import_POPACS_Excel_CRF_121215 %Laster aktuelle data fra ExcelCRF

%Demografiske data
cd('M:\POPACS\Matlab\Hovedscript')
Import_POPACS_demographics_121215 %Laster aktuelle data fra WebCRF-demographic

cd('M:\POPACS\Matlab')

%Aktuelle tidsvariabler
startPOtid = perioptime(idx2); %Antall minutter etter start PICIS
tidpostop = [0]; 
k=1;
for i = 1:(size(perioptime(idx2:end),1)-1)
l = (perioptime(i+idx2)-perioptime(idx2));
tidpostop = [tidpostop;l]; 
k = k + 1;
end


%Fysiologiske data
HR = cleanData(fys_raw(:,4),1); %Heart rate
SpO2 = cleanData(fys_raw(:,5),1);
Resp_rate = cleanData(fys_raw(:,6),1);
nisBT = cleanData(fys_raw(:,7),1);
nidBT = cleanData(fys_raw(:,8),1);
isBT = cleanData(fys_raw(:,9),1);
idBT = cleanData(fys_raw(:,10),1);
sBT = []; %Kombinert invasivt og non-invasivt
dBT = [];
for i = 1:size(isBT,2)
    if ~isnan(isBT(i)) %Hvis invBT ikke er NaN, sjekk NIBT
        sBT = [sBT; isBT(i)];
        dBT = [dBT; idBT(i)];
    else %ta inn non-invasivt trykk
        sBT = [sBT; nisBT(i)];
        dBT = [dBT; nidBT(i)];
    end
end
MAP = dBT(:,1) + (1/3)*(sBT(:,1) - dBT(:,1)); %Mean Arterial Pressure (MAP)
[Noradr] = replaceNaNwithzero(fys_raw(:,20));        %Noradr         


%%%%%% V�skedata
Plasma = fys_raw(:,24);
SAG = fys_raw(:,25);
Trombocytt = fys_raw(:,26);
Isoveske1 = fys_raw(:,21);
Isoveske2 = fys_raw(:,22);
Isoveske3 = fys_raw(:,23);
[Isoveskearray1] = veskepertidsenhet(perioptime, Isoveske1);
[Isoveskearray2] = veskepertidsenhet(perioptime, Isoveske2);
[Isoveskearray3] = veskepertidsenhet(perioptime, Isoveske3);
Isoveskearray = [];
for i = 1:size(Isoveskearray1,1)
    sum1 = Isoveskearray1(i,2) + Isoveskearray2(i,2) + Isoveskearray3(i,2);
    Isoveskearray = [Isoveskearray; Isoveskearray1(i,1) sum1];
end
PO_Isoveskearray = [tidpostop Isoveskearray(idx2:end,2)];
PO_Noradr = Noradr(idx2:end);

PO_sBT = sBT(idx2:end);

cd('M:\POPACS\Matlab\Output\POPACS_matfiler')
filnavn = ['POPACS_', int2str(PasID)]
save(filnavn);

clearvars -except datafiler demographics %fid1 

end







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Testing av plotting
%plot(ECRF_rTime/60, ECRF_RR,'o') %Resp.frekvens
%axis([-1,25,0,40])
%line(ECRF_rTime/60, ECRF_Temp,'Marker','X')

%plot(ECRF_rTime/60, ECRF_Temp,'o')


%plot(time, HR(1:length(time)), 'o')


