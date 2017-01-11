function typekir = finneKirtype(PasID)
%"Juksefunksjon" for å enkelt finne ut type kirurgi basert på manuelt utvalgte PasID. 

typekir = 0; %Default hvis ikke del av listene under

if ismember(PasID, [4701041
4701005
4701038
4701047
4701009
4701021
4701027])
    typekir = 1; %Karkirurgi, dvs AAA
end

if ismember(PasID, [4701006
4701016
4701022
4701023
4701030
4701036
4701042
4701019
4701053
])
typekir = 2; %Urologisk kirurgi
end

if ismember(PasID, [4701045
4701003
4701034
4701004
4701037
4701040
4701044
4701024
4701001
4701031
4701014
4701026
4701032
4701035
4701043
4701002
4701012
4701033
4701046
4701049
4701018
4701039
4701015
4701011
4701017
4701048
4701007
4701051
4701020
4701052
4701010
4701013
4701025
4701028
4701029
4701050
4701008])
typekir = 3; %Gastrokirurgi
end

end
