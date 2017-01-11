function sirkulasjon_status_spell = convertSirkulasjon_status(sBT_spell, HR_spell)
%Funksjon som deler opp veske gitt i kategorier
sirkulasjon_status_spell = sBT_spell;

for k = 1:size(sBT_spell,1)
   if sBT_spell(k,5) < 90
       sirkulasjon_status_spell(k,5) = 2;
   elseif HR_spell(k,5) >= 110
       sirkulasjon_status_spell(k,5) = 2;
   
   else sBT_spell(k,5) >= 90;
         sirkulasjon_status_spell(k,5) = 1;
   end
   %if veske_spell(k,5) >= 500
      % veske_status_spell(k,5) = 3;
   %end   
end



end