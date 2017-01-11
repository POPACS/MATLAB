% Innlastning av data fra Excel_CRF

disp('Start exceluttrekk')
cd('M:\POPACS\Matlab\Input\Fysiologisk WEB-CRF')
fil_w = datafiler(I,2) %web-crf
fil_w = deblank(char(fil_w));
[a,b,crf_raw] = xlsread(fil_w,'A2:CV60');

cd('M:\POPACS\Matlab')

%Uttrekk fra Excel - CRF
Excel_PasID = cell2num(crf_raw(1,2));
if Excel_PasID ~= PasID
    disp('Feil PasID i Excel-CRF!!')
end
tPO_dummy = cell2num(crf_raw(7,3))*24;
POtime = Dato + datenum([0,0,0,floor(tPO_dummy),(tPO_dummy-floor(tPO_dummy))*60,0]);
%datestr(POtime);
[a idx2] = min(abs(time-POtime));%Finner idx for tidspunkt nærmest POtime i time
startPOtid = time(idx2);
datestr(startPOtid);
try
t1_dummy = cell2num(crf_raw(3,3))*24;
t1_Bloodsample = Dato + datenum([0,0,0,floor(t1_dummy),(t1_dummy-floor(t1_dummy))*60,0]);
datestr(t1_Bloodsample);
catch
    t1_Bloodsample = nan;
    disp('Mangler tidspunkt Blodprøve 1')
end
try
t2_dummy = cell2num(crf_raw(5,3))*24;
t2_Bloodsample = Dato + datenum([0,0,0,floor(t2_dummy),(t2_dummy-floor(t2_dummy))*60,0]);
datestr(t2_Bloodsample);
catch
    t2_Bloodsample = nan;
    disp('Mangler tidspunkt Blodprøve 2')
end
try
t3_dummy = cell2num(crf_raw(6,3))*24;
t3_Bloodsample = Dato + 1 + datenum([0,0,0,floor(t3_dummy),(t3_dummy-floor(t3_dummy))*60,0]);
datestr(t3_Bloodsample);
catch
   t3_Bloodsample = nan;
   disp('Mangler tidspunkt Blodprøve 3')
end

ECRF_rTime = cell2num(crf_raw(8,4:100)); %Relative time 0-1440
ECRF_RR = cell2num(crf_raw(14,4:100));
ECRF_Temp = cell2num(crf_raw(15,4:100));
ECRF_PainStatic = cell2num(crf_raw(16,4:100));
ECRF_PainMob = cell2num(crf_raw(17,4:100));
ECRF_PONV = cell2num(crf_raw(18,4:100));
for k = 4:100 % Assigns number 9 to cells with S in sedation
    try
        if strmatch(crf_raw(19,k),'S')
        crf_raw(19,k) = {9};
        end
    end
end
ECRF_Sedation = cell2num(crf_raw(19,4:100));
ECRF_RA_in = abs(replaceNaNwithzero(crf_raw(45,2)));
ECRF_NaCl_in = abs(replaceNaNwithzero(crf_raw(46,2)));
ECRF_Medfluid_in = abs(replaceNaNwithzero(crf_raw(47,2)));
ECRF_Otherfluid_in = abs(replaceNaNwithzero(crf_raw(48,2)));
Perop_veske = ECRF_RA_in + ECRF_NaCl_in + ECRF_Medfluid_in + ECRF_Otherfluid_in;
ECRF_SAG_in = abs(replaceNaNwithzero(crf_raw(49,2)));
ECRF_Plasma_in = abs(replaceNaNwithzero(crf_raw(50,2)));
ECRF_bloodloss_perop = abs(replaceNaNwithzero(crf_raw(54,2)));
ECRF_diuresis_perop = abs(replaceNaNwithzero(crf_raw(55,2)));
ECRF_thirdspace = abs(replaceNaNwithzero(crf_raw(56,2)));

ECRF_bloodloss_total = abs(replaceNaNwithzero(crf_raw(54,4)));
ECRF_diuresis_total = abs(replaceNaNwithzero(crf_raw(55,4)));

