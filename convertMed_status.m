function PO_timemed_status_spell = convertMed_status(PO_timemed_spell)
%Funksjon som deler opp veske gitt i kategorier
PO_timemed_status_spell = PO_timemed_spell;

for k = 1:size(PO_timemed_spell,1)
   if PO_timemed_spell(k,5) < 1
       PO_timemed_status_spell(k,5) = 1;
   end   
   if PO_timemed_spell(k,5) >= 1
       PO_timemed_status_spell(k,5) = 2;
   end
   if PO_timemed_spell(k,5) >= 7.5
       PO_timemed_status_spell(k,5) = 3;
   end   
   if PO_timemed_spell(k,5) >= 10
       PO_timemed_status_spell (k,5) = 4;
end



end