function fh = my_matlabFunction(fsym)
% This function imitates a feature of the built-in "matlabFunction", (not
% all features); to be used when matlabFunction is not available.
% 
% It converts a "symbolic" function expression into an anonymous
% function, and return it. The anonymous function returned is a "function
% handle" data type, which can be used to plug-in array of numbers. See
% example below.
% 
% Limitation: only works correctly with expression with one variable with 
% one character as its name. E.g. "x" or "t", but not "x1" or "x_prime".
% The algorithm simply looks for a word with one char length. It could
% get confuse if "i", "j", other user defined constants like "a","b" are
% in the symbolic expression.
% 
% Input:  (fsym) a symbolic variable of a function expression
% Output: (fh) a "function handle" variable of that function.
%         specifically, fh will be an "anonymous function".
% Ex: fsym = x^2+exp(x)/(x*x)         (symbolic data type)
%     fh   = @(x) x.^2+exp(x)./(x.*x) (a function handle)
%     fh([2,1,7]) will return [5.8473,    3.7183,   71.3803]
%
% Details of operation: this function converts symbolic to string, then 
% string to function handle. Regexp is used to identify variable name 
% automatically, detecting a word with one char length. Possible bugs are
% expected. Use with cautions. Compatible with other built-in functions 
% like exp, log, pi. Though, not heavily debug tested.
% 
% See documentation: "anonymous function", "function handle"


s = char(fsym); % Convert sym data type to string
% Identify variable name e.g. "x" or "t". Note: compatible with exp, log.
var = regexp(s,'[^A-Za-z]([A-Za-z])[^A-Za-z]','tokens');
var = [var{:}];
var = unique(var);
var = var{1};

% Add . to */^ so they become array-operator. So can plug-in vectors/mat.
s = strrep(s,'*','.*'); % replace * with .*
s = strrep(s,'^','.^');
s = strrep(s,'/','./');

% Construct string, definition of the anonymous function.
s = sprintf('@(%c)%s', var, s);
fh = str2func(s); % convert string to function handle

% ==== Developer Note: ===== Ver 1.0 ==== Aug 7, 2017 (sp694@drexel.edu)
% Can revise to take 2 or more inputs (varargin), with additional inputs 
% being optional. The additional optional inputs can be used to define 
% variables. For example, my_matlabfunction(fsym, x11,x12) will return an
% anonymous function with @(x11,x12) ...
% --- However, by design choice, keep it simple and structurally comparable
% to the real "f_handle = matlabFunction(fsym)", i.e., when used to return
% function handle.