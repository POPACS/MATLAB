function HDU_status_spell = convertHDU_status(PO_veske_spell, PO_noradr_spell, PO_timemed_spell)
%Funksjon som deler opp veske gitt i kategorier
HDU_status_spell = PO_veske_spell;

for k = 1:size(PO_veske_spell,1)
   if all([PO_veske_spell(k,5) >= 500,PO_noradr_spell(k,5) >= 1,PO_timemed_spell(k,5) >= 7,5])
       HDU_status_spell(k,5) = 1;
   
   elseif PO_noradr_spell(k,5) >= 1
       HDU_status_spell(k,5) = 2;
   
   elseif all([PO_noradr_spell(k,5) >= 1,PO_veske_spell(k,5) >= 500])
         HDU_status_spell(k,5) = 3;
   
   elseif all([PO_noradr_spell(k,5) >= 1,PO_timemed_spell(k,5) >= 7,5])
         HDU_status_spell(k,5) = 4;
       
   elseif all([PO_veske_spell(k,5) >= 500,PO_timemed_spell(k,5) >= 7,5])
       HDU_status_spell(k,5) = 5;
   
   elseif PO_veske_spell(k,5) >= 500
       HDU_status_spell(k,5) = 6;
   
   elseif PO_timemed_spell(k,5) >=7,5
       HDU_status_spell(k,5) = 7;
   
   else HDU_status_spell(k,5) = 8;
   
   end
   %if veske_spell(k,5) >= 500
      % veske_status_spell(k,5) = 3;
   %end   
end



end