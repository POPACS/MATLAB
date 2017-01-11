function [Bspell] = konvBtilSPELLformat_generisk(B, EKG, xlim)
%Funksjon som konverterer B til SPELL format (TraMineR)
%xlim er hvor lenge absorberende tilstand skal stå (min)

%xlim = xlim *60;
B1 = B;
Bs = [];
lengde = size(B1,1);
nysistelinje = 1;

for i = 1:(lengde-1)
 if (B1(i,1) < xlim)
    Bs(i,1) = EKG; % idpers
    Bs(i,2) = i;   % index
    Bs(i,3) = B1(i,1); %from
    
    if (B1(i+1,1) > xlim) %break,resten skal ikke med
        Bs(i,4) = xlim; %to, setter inn fra siste til xlim
        nysistelinje = 0;
    else
        Bs(i,4) = B1(i+1,1); % to        
    end
    
    Bs(i,5) = B1(i,2); %status
%    Bs(i,6) = B1(1,2); %initialrytme
%    Bs(i,7) = B1(end,2); %slutt-tilstand
    I = i;
 end
end
    if nysistelinje == 1 %resterende status skal gå til tid xlim
    Bs(I+1,1) = EKG; % idpers
    Bs(I+1,2) = I+1;   % index
    Bs(I+1,3) = B1(I+1,1); %from
    Bs(I+1,4) = xlim; % to
    Bs(I+1,5) = B1(I+1,2); %status
%    Bs(I+1,6) = B1(1,2); %initialrytme
%    Bs(I+1,7) = B1(end,2); %slutt-tilstand
    end

Bspell = Bs;
end %function

