cd('M:\POPACS\Matlab')
[g,matfiler] = xlsread('Dirliste POPACS matlabfiler.xlsx');
matfiler = deblank(matfiler);

ECRF_PainStaticMatrix = zeros(length(matfiler),6);

for I = 1:44%:44%size(matfiler,1)   
cd('M:\POPACS\Matlab\Output\POPACS_matfiler')
matfil = char(matfiler(I));
load(matfil);

ECRF_PainStatic = ECRF_PainStatic([1 13 25 49 97]);
ECRF_PainStaticVector = [PasID, ECRF_PainStatic(1,1:end)]; 
ECRF_PainStaticMatrix(I-1,1:end) = ECRF_PainStaticVector;

clearvars -except matfiler ECRF_PainStaticMatrix
end
