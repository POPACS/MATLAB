function HDU_status_spell = convertHDU_status(PO_veske_spell, PO_noradr_spell, PO_timemed_spell)
%Funksjon som deler opp HDU intervensjoner i kategorier
% Doserange: Noradrenalin (1 = < 0.05; 2=<0.1;3=<0.15;
% 4=<0.2;5=<0.25;6=<0.30;7=>0.30)


%Tar utgangspunkt i veske_spell, for å ha et rammeverk:
HDU_status_spell = PO_veske_spell;

if size(PO_veske_spell,1) == size(PO_noradr_spell,1) & size(PO_veske_spell,1) == size(PO_timemed_spell,1)
    %disp('PO_veske_spell og PO_noradr_spell er like lange')

    for k = 1:size(PO_veske_spell,1)
    
    if PO_veske_spell(k,5) < 500 & PO_noradr_spell(k,5) == 0 & PO_timemed_spell(k,5) < 7.5
       HDU_status_spell(k,5) = 1; %Ingen HDU-tiltak
    end   
    if PO_veske_spell(k,5) >= 500 & PO_noradr_spell(k,5) == 0 & PO_timemed_spell(k,5) < 7.5
       HDU_status_spell(k,5) = 2; %Væske > 500
    end   
    if PO_veske_spell(k,5) < 500 & PO_noradr_spell(k,5) > 0 & PO_timemed_spell(k,5) < 7.5
       HDU_status_spell(k,5) = 3; %Noradr > 0
    end
    if PO_veske_spell(k,5) < 500 & PO_noradr_spell(k,5) == 0 & PO_timemed_spell(k,5) >= 7.5
       HDU_status_spell(k,5) = 4; %Opioid > 7.5
    end   
    if PO_veske_spell(k,5) >= 500 & PO_noradr_spell(k,5) > 0 & PO_timemed_spell(k,5) < 7.5
       HDU_status_spell(k,5) = 5; %Væske > 500 + Noradr > 0
    end   
    if PO_veske_spell(k,5) < 500 & PO_noradr_spell(k,5) > 0 & PO_timemed_spell(k,5) >= 7.5
       HDU_status_spell(k,5) = 6; %Noradr > 0 +  Opioid > 7.5
    end   
    if PO_veske_spell(k,5) >= 500 & PO_noradr_spell(k,5) == 0 & PO_timemed_spell(k,5) >= 7.5
       HDU_status_spell(k,5) = 7; %Væske > 500 +  Opioid > 7.5
    end   
    if PO_veske_spell(k,5) >= 500 & PO_noradr_spell(k,5) > 0 & PO_timemed_spell(k,5) >= 7.5
       HDU_status_spell(k,5) = 8; %Væske > 500 +  Noradr > 0 + Opioid > 7.5
    end   

    end

else
    disp('PO_veske_spell og PO_noradr_spell er IKKE LIKE LANGE')
    HDU_status_spell(:,5) = 99; %Trøbbel med ulik lengde, settes forløpig til missing (99)
end


end