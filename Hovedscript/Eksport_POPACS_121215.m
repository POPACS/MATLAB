
% EKSPORTSCRIPT POPACS

cd('M:\POPACS\Matlab')
[g,matfiler] = xlsread('Dirliste POPACS matlabfiler.xlsx');
matfiler = deblank(matfiler)


%Definerer først output fil:
cd('M:\POPACS\Matlab\Output\POPACS_tekstfiler')
fid1 = fopen('Output POPACS Table 1_021215.txt','wt');
fprintf(fid1,'%s\t %s\t %s\t %s\t %s\n', 'PasID','Date','Age','Sex','TimeHDU');

fid2 = fopen('Output POPACS PO veske per time_021215.txt','wt');
fprintf(fid2,'%s\t %s\t %s\t %s\t %s\n','idpers','index','from','to','status');

fid3 = fopen('Output POPACS PO veske status_021215.txt','wt');
fprintf(fid3,'%s\t %s\t %s\t %s\t %s\n','idpers','index','from','to','status');

fid4 = fopen('Output POPACS PO Noradr status_021215.txt','wt');
fprintf(fid4,'%s\t %s\t %s\t %s\t %s\n','idpers','index','from','to','status');

fid5 = fopen('Output POPACS PO opioid per time_021215.txt','wt');
fprintf(fid5,'%s\t %s\t %s\t %s\t %s\n','idpers','index','from','to','status');

fid6 = fopen('Output POPACS PO sirkulasjon status_021215.txt','wt');
fprintf(fid6,'%s\t %s\t %s\t %s\t %s\n','idpers','index','from','to','status');

fid7 = fopen('Output POPACS demographic_table_021215.txt','wt');
fprintf(fid7,'%s\t %s\t %s\t %s\t %s\t %s\t %s\n','PasID','Age','Sex','Weight','Smoker','PrevAbd','Charlson');

fid8 = fopen('Output POPACS HDU per time_021215.txt','wt');
fprintf(fid8,'%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n','idpers','index','from','to','status','kirtype','sortingV','sortingV2');

fid9 = fopen('Output POPACS Tid til av HDU tiltak_021215.txt','wt');
fprintf(fid9,'%s\t %s\n','idpers','timeoffHDU');

fid10 = fopen('Output POPACS PO opioid status_021215.txt','wt');
fprintf(fid10,'%s\t %s\t %s\t %s\t %s\n','idpers','index','from','to','status');

fid11 = fopen('Output POPACS VESKE Table 2_021215.txt','wt');
fprintf(fid11,'%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n', 'PasID','BlodtapPerop','BlodtapPO','VeskePerop','VeskePO','SAGPerop','SAGPO','PlasmaPerop','PlasmaPO');

fid12 = fopen('Output POPACS EPIDURAL PEROP Table 2_021215.txt','wt');
fprintf(fid12,'%s\t %s\n','PasID','Epidural');

fid13 = fopen('Output POPACS EPIDURAL PO Table 2_021215.txt','wt');
fprintf(fid13,'%s\t %s\n','PasID','Epidural');

fid14 = fopen('Output POPACS OPIOID Table2_021215.txt','wt');
fprintf(fid14,'%s\t %s\n','PasID','Opioid');

fid15 = fopen('Output POPACS FENTANYL Table2_021215.txt','wt');
fprintf(fid15,'%s\t %s\n','PasID','Fentanyl');

fid16 = fopen('Output POPACS Regression data_071215.txt','wt');
fprintf(fid16,'%s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\t %s\n','PasID','Alder','Kjønn','BMI','Bloodloss','Kirtid','Timeto_offNA','Timeto_offNA_dich','Peropveske');


%For-løkke gjennom alle Mat-filer
    for I = 1:size(matfiler,1)
    %I = 1;
    cd('M:\POPACS\Matlab\Output\POPACS_matfiler')
    matfil = char(matfiler(I))
    load(matfil)

%Datahåndtering
cd('M:\POPACS\Matlab')

typekir = finneKirtype(PasID)  %%Bestemmer kirurgitype per pasient. 

try
KirTid = (datenum(KirSlutt) - datenum(KirStart))*24; %Kirurgitid i timer
catch
    KirTid = 0;
    disp('Trøbbel med Kir-tid')
end

timetoNAoff = find_timeoffnoradr(Noradr,time,1);
HR = HR.' ;
PO_HR = HR(idx2:end);
PO_sBT = sBT(idx2:end);

%Ny timetoNAoff
timetoNAoff_siste = find_timeoffnoradr_sisteevent(PO_Noradr,tidpostop)
timetoNAoff_siste_dichotom = 0;
if timetoNAoff_siste >= 300 %
timetoNAoff_siste_dichotom = 1;
end


timeveske = sumAllTimeveske_gen2(perioptime, Isoveskearray);
timeNoradr = maxtimeNoradr(perioptime, Noradr);
timesBT = maxtimesBT(perioptime, sBT);
timeHR = maxtimeHR(perioptime,HR);

PO_timesBT = maxtimesBT(tidpostop, PO_sBT);
PO_timeHR = maxtimeHR(tidpostop, PO_HR);

PO_timeveske = sumAllTimeveske_gen2(tidpostop, PO_Isoveskearray);
PO_timeNoradr = maxtimeNoradr(tidpostop, PO_Noradr);

if PasID == 4701018
    PO_timeNoradr = PO_timeveske;
    PO_timeNoradr(1:end,2)=0;
end

veske_spell = konvBtilSPELLformat_generisk(timeveske, PasID, timeveske(end,1)+1);
noradr_spell = konvBtilSPELLformat_generisk(timeNoradr, PasID, timeNoradr(end,1)+1);
HR_spell = konvBtilSPELLformat_generisk(timeHR, PasID, timeHR(end,1)+1);
sBT_spell = konvBtilSPELLformat_generisk(timesBT, PasID, timesBT(end,1)+1);

PO_veske_spell = konvBtilSPELLformat_generisk(PO_timeveske, PasID, PO_timeveske(end,1)+1);
PO_noradr_spell = konvBtilSPELLformat_generisk(PO_timeNoradr, PasID, PO_timeNoradr(end,1)+1);
PO_sBT_spell =  konvBtilSPELLformat_generisk(PO_timesBT, PasID, PO_timesBT(end,1)+1);
PO_HR_spell= konvBtilSPELLformat_generisk(PO_timeHR, PasID, PO_timeHR(end,1)+1);

veske_status_spell = convertVeske_status(veske_spell);  %for kategorier av veskebehov
PO_veske_status_spell = convertVeske_status(PO_veske_spell);  %for kategorier av veskebehov

sirkulasjon_status_spell = convertSirkulasjon_status(sBT_spell, HR_spell);
PO_sirkulasjon_status_spell = convertSirkulasjon_status(PO_sBT_spell, PO_HR_spell);

%%%%%% Medikamenter
%startPOtid = perioptime(idx2); %Antall minutter etter start PICIS
[opioid_medmatrix] = spes_medmatrix_POPACS(PasID,time, med_raw,'Morfin','Ketorax', 4);
if ~isempty(opioid_medmatrix)
[timemed] = sumTime_medikament(opioid_medmatrix, perioptime);
timemed_spell = konvBtilSPELLformat_generisk(timemed, PasID, timemed(end,1)+1);
PO_opioid_medmatrix = opioid_medmatrix(opioid_medmatrix(:,2) >= startPOtid,:);
PO_opioid_medmatrix(:,2) = PO_opioid_medmatrix(:,2)-startPOtid;
[PO_timemed] = sumTime_medikament(PO_opioid_medmatrix, tidpostop);
PO_timemed_spell = konvBtilSPELLformat_generisk(PO_timemed, PasID, PO_timemed(end,1)+1);
else
PO_timemed_spell = PO_veske_spell;
PO_timemed_spell(:,5) = 0;
end

PO_timemed_status_spell = convertMed_status(PO_timemed_spell);

if size(PO_veske_spell,1) == size(PO_noradr_spell,1)
    %%%%%% HDU status
    HDU_status_spell = convertHDU_status_T(PO_veske_spell, PO_noradr_spell, PO_timemed_spell);
    a = HDU_status_spell(HDU_status_spell(:,5) == 1,3);
    if ~isempty(a)
    timeoffHDU = a(1,1);
    else
        if HDU_status_spell(end,5) > 1 %Fortsatt på noradrenalin i slutten av HDU_status_spell
        timeoffHDU = HDU_status_spell(end,4); %obs kolonne 4 og ikke 3
        disp('Fortsatt på noradrenalin i slutten av HDU_status_spell')
        end
    end

else disp('PO_veske_spell og PO_noradr_spell er IKKE LIKE LANGE')
     PO_noradr_spell_dummy = PO_veske_spell;
     PO_noradr_spell_dummy(1:10,5) = PO_noradr_spell(1:10,5);
     PO_noradr_spell_dummy(11:end,5) = 0;
     PO_noradr_spell = PO_noradr_spell_dummy;
     clearvars PO_noradr_spell_dummy;
     
     HDU_status_spell = convertHDU_status_T(PO_veske_spell, PO_noradr_spell, PO_timemed_spell);
     a = HDU_status_spell(HDU_status_spell(:,5) == 1,3);
       if ~isempty(a)
       timeoffHDU = a(1,1);
       else
        if HDU_status_spell(end,5) > 1 %Fortsatt på noradrenalin i slutten av HDU_status_spell
        timeoffHDU = HDU_status_spell(end,4); %obs kolonne 4 og ikke 3
        disp('Fortsatt på noradrenalin i slutten av HDU_status_spell')
        end
       end

end
HDU_tid_timer = tidpostop(end,1)/60;

HDU_status_spell(:,6)=typekir
HDU_status_spell(:,7)=timetoNAoff_siste
HDU_status_spell(:,8)=HDU_tid_timer

cd('M:\POPACS\Matlab\Output\POPACS_tekstfiler')

fprintf(fid9,'%4d\t %2d\n',PasID,timeoffHDU);

cd('M:\POPACS\Matlab\Hovedscript')
Import_POPACS_Tabell2data_121215

%%EKSPORTSCRIPT for tabell 2
cd('M:\POPACS\Matlab\Hovedscript')
Eksport_POPACS_tabell2data_121215


%%%%%%%% Output av demografiske data
cd('M:\POPACS\Matlab\Output\POPACS_tekstfiler')

fprintf(fid1,'%3d\t %5s\t %3d\t %4d\t %3.2f\n',PasID,datestr(Dato),Alder, Kjonn, HDU_tid_timer);

fprintf(fid7,'%3d\t %3d\t %3d\t %3d\t %3d\t %3d\t %3d\n',PasID,Alder,Kjonn,vekt,Cb_Smoker,Cb_PrevAbd,Cb_Charlson);

fprintf(fid16,'%3d\t %3d\t %3d\t %3d\t %3d\t %3d\t %3d\t %3d\t %3d\n',PasID,Alder,Kjonn,bmi,t2_bloodloss_perop,KirTid,timetoNAoff_siste,timetoNAoff_siste_dichotom,t2_veske_perop_liter);


for l = 1:size(PO_veske_spell,1)
    fprintf(fid2,'%4d\t %2d\t %2d\t %2d\t %4.3f\n',PO_veske_spell(l,:));
end

for l = 1:size(PO_veske_status_spell,1)
    fprintf(fid3,'%4d\t %2d\t %2d\t %2d\t %2d\n',PO_veske_status_spell(l,:));
end

for l = 1:size(PO_noradr_spell,1)
    fprintf(fid4,'%4d\t %2d\t %2d\t %2d\t %2d\n',PO_noradr_spell(l,:));
end

for l = 1:size(PO_timemed_spell,1)
    fprintf(fid5,'%4d\t %2d\t %2d\t %2d\t %4.1f\n',PO_timemed_spell(l,:));
end

for l = 1:size(PO_sirkulasjon_status_spell,1)
    fprintf(fid6,'%4d\t %2d\t %2d\t %2d\t %2d\n',PO_sirkulasjon_status_spell(l,:));
end

for l = 1:size(HDU_status_spell,1)
    fprintf(fid8,'%4d\t %2d\t %2d\t %2d\t %2d\t %2d\t %2d\t %2d\n',HDU_status_spell(l,:));
end

for l = 1:size(PO_timemed_status_spell,1)
    fprintf(fid10,'%4d\t %2d\t %2d\t %2d\t %2d\n',PO_timemed_status_spell(l,:));
end

%Eventuell plotting av væskebehov for test:

%plot(tidpostop/60, PO_Isoveskearray(1:end,2),'-') %Væskebehov i PO-tid
%axis([-1,40,0,1000])
%line(perioptime/60, sBT,'Marker','V')
%line(perioptime/60, dBT,'Marker','o')
%plotnavn = ['Væskebehov pasient ' int2str(PasID)];
%title(plotnavn)
%print(plotnavn,'-dpng')


clearvars -except matfiler fid1 fid2 fid3 fid4 fid5 fid6 fid7 fid8 fid9 fid10 fid11 fid12 fid13 fid14 fid15 fid16

end

clearvars
disp ('fuckoff')



