function s = strjoin(c, delimiter)
%STRJOIN Join strings in a cell array, using a delimiter.
%   S = STRJOIN(C, DELIMITER) joins the strings of cell array C into a
%   single string, separating them with string DELIMITER.
%
%   Example:
%
%   >> c = {'A martini', 'shaken', 'not stirred.'};
%   >> strjoin(c, ', ')
%
%   ans =
%
%   A martini, shaken, not stirred.
%
%   >>
%
%   Joao F. Henriques, 2012

	assert(iscellstr(c), 'C should be a cell array of strings.')
	assert(ischar(delimiter), 'DELIMITER should be a string.')

	if isempty(c),
		s = '';
	else
		%odd cells are from the original array, even cells are delimiters
		s = cell(1, 2 * numel(c) - 1);
		s(1:2:end) = c;
		s(2:2:end) = {delimiter};
		s = [s{:}];  %concatenate into a single string
	end
end

