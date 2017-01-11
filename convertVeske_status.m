function veske_status_spell = convertVeske_status(veske_spell)
%Funksjon som deler opp veske gitt i kategorier
veske_status_spell = veske_spell;

for k = 1:size(veske_spell,1)
   if veske_spell(k,5) < 250
       veske_status_spell(k,5) = 1;
   end   
   if veske_spell(k,5) >= 250 %&& < 500
       veske_status_spell(k,5) = 2;
   end
   if veske_spell(k,5) >= 500
       veske_status_spell(k,5) = 3;
   end   
end



end