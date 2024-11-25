function result = w_when_implemented(varargin)
    result = cell(nargin,2);
    for ii=1:nargin
        funcName = varargin{ii};
        result{ii,1} = funcName;
        result(ii,2) = extract(help(funcName),regexpPattern('R20[0-9][0-9].*?\n'));
    end
end
