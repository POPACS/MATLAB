function [y] = replaceNaNwithzero(data)
x = [];
y = 0;

for i = 1:size(data,1)
if isnan(cell2num(data(i)))
x = [x;y];
else
z = cell2num(data(i));
x = [x;z];
end
end

y = x;
end