
cd('M:\POPACS\Matlab');

%%Lager idx3 som tilsvarer 24 timer postop:
POtime24 = POtime+1

[a idx3] = min(abs(time-POtime24));%Finner idx for tidspunkt nærmest POtime i time
stoppPOtid = time(idx3);
datestr(stoppPOtid);

%%BLODTAP

t2_bloodloss_perop = ECRF_bloodloss_perop;
t2_bloodloss_postop = ECRF_bloodloss_total - ECRF_bloodloss_perop;

%% DIURESE

t2_diuresis_perop = ECRF_diuresis_perop;
t2_diuresis_postop = ECRF_diuresis_total - ECRF_diuresis_perop;

%%BLODPRODUKTER

t2_ery_perop = sum(replaceNaNwithzero(SAG(1:idx2-1,1)));
t2_ery_PO = sum(replaceNaNwithzero(SAG((idx2):idx3)));
t2_ery_total = sum(replaceNaNwithzero(SAG));

t2_plasma_perop = sum(replaceNaNwithzero(Plasma(1:idx2-1,1)));
t2_plasma_PO = sum(replaceNaNwithzero(Plasma((idx2):idx3)));
t2_plasma_total = sum(replaceNaNwithzero(Plasma));

%%VÆSKE


    
t2_veske_perop = sum(Isoveskearray1(1:idx2-1,2))+sum(Isoveskearray2(1:idx2-1,2))...
    + sum(Isoveskearray3(1:idx2-1,2));

%%%OBSOBSOBS: for å akommodere pasient 048. Gir alle pasienter som har fått 0 væske under operasjon = 3900 (som 048).
if t2_veske_perop==0
    t2_veske_perop = 3900
end

t2_veske_PO = sum(Isoveskearray1(idx2:idx3,2))+sum(Isoveskearray2(idx2:idx3,2))...
    + sum(Isoveskearray3(idx2:idx3,2));
t2_veske_total = t2_veske_perop + t2_veske_PO
t2_veske_perop_liter=t2_veske_perop/1000;

%%EPIDURAL

[Epidural1] = replaceNaNwithzero(fys_raw(:,18));
[Epidural2] = replaceNaNwithzero(fys_raw(:,19));
t2_epidural_total = [];
for i = 1:size(Epidural1,1)                         %%%Legger sammen alle verdier i "vanlig blanding" og "sterkblanding" i en kolonne. 
    sum2 = Epidural1(i,1) + Epidural2(i,1);
    t2_epidural_total = [t2_epidural_total; sum2];
end


t2_epidural_perop = t2_epidural_total(1:idx2-1,1);
t2_epidural_PO = t2_epidural_total(idx2:end,1);


t2_epidural_peropNY = median(t2_epidural_perop(t2_epidural_perop>0 & t2_epidural_perop <40,:));
t2_epidural_PONY = median(t2_epidural_PO(t2_epidural_PO>0 & t2_epidural_PO <40,:));

%%Analgesi


[fentanyl_medmatrix] = spes_medmatrix_fentanyl_POPACS(PasID,time, med_raw,'Fentanyl', 4);

if ~isempty(fentanyl_medmatrix)
t2_fentanyl_total = fentanyl_medmatrix(1:end, 3)
t2_fentanyl_totalNY = sum(t2_fentanyl_total(t2_fentanyl_total<1,:))

else t2_fentanyl_total = 0.225;    %% OBS TAR høyde for pasient 48 der dette legges inn manuelt.
    t2_fentanyl_totalNY = 0.225;
end

if ~isempty(opioid_medmatrix)
opioid_medmatrix_dummy = opioid_medmatrix(1:end,2)
opioid_medmatrix_dummy2 = opioid_medmatrix_dummy(opioid_medmatrix_dummy<=(perioptime(idx3)))
opioid_medmatrix24 = opioid_medmatrix(1:size(opioid_medmatrix_dummy2),1:3)
 t2_opioid_postop = sum(opioid_medmatrix24(1:end,3))
   
else t2_opioid_postop = 0
    
end






