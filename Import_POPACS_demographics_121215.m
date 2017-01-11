
cd('M:\POPACS\Matlab')
disp('Starter demografiuttrekk')
disp('  ')


%% Komorbiditet

Cb_Smoker = cell2num(demographics(I+1, 19));
Cb_PrevAbd = cell2num(demographics(I+1, 20));
Cb_ChrPain = cell2num(demographics(I+1, 21));
Cb_ChrPainDose = cell2num(demographics(I+1, 22));
Cb_Charlson = cell2num(demographics(I+1, 23));

%% Komplikasjoner

Cm_Bleeding = cell2num(demographics(I+1, 26));
Cm_BleedingDate = cell2num(demographics(I+1, 27));
Cm_AnLeak = cell2num(demographics(I+1, 28));
Cm_AnLeakDate = cell2num(demographics(I+1, 29));
Cm_Angina = cell2num(demographics(I+1, 30));
Cm_MI = cell2num(demographics(I+1, 31));
Cm_PulmEd = cell2num(demographics(I+1, 32));
Cm_Arrhytmia = cell2num(demographics(I+1, 33));
Cm_DVT = cell2num(demographics(I+1, 34));
Cm_LE = cell2num(demographics(I+1, 35));

%% Blodprøver

Bloodtest_Date = datestr(datenum(demographics(I+1,36),'dd.mm.yyyy'), 'dd-mmm-yyyy');
B_Hb = cell2num(demographics(I+1, 37));
B_Wbc = cell2num(demographics(I+1, 38));
B_DiffNeu = cell2num(demographics(I+1, 39));
B_DiffLym = cell2num(demographics(I+1, 40));
B_DiffMon = cell2num(demographics(I+1, 41));
B_DiffOth = cell2num(demographics(I+1, 42));
B_Plt = cell2num(demographics(I+1, 43));
B_MCV = cell2num(demographics(I+1, 44));
B_Crea = cell2num(demographics(I+1, 45));
B_Bil = cell2num(demographics(I+1, 46));
B_Alb = cell2num(demographics(I+1, 47));
B_CRP = cell2num(demographics(I+1, 48));











