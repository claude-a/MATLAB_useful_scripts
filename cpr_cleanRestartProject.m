function cpr_cleanRestartProject(g_flag)
%% clean and restart PJ.
%%
cl_MATLAB;

if(nargin < 1)
    g_RevertClean;
else
    g_RevertClean(g_flag);
end

clc;

%%
file_text = get_genText();
writematrix(file_text, 'run__startup__script__m__.m', ...
            'FileType', 'text', ...
            'QuoteStrings', false);

%%
rs_MATLAB;

end

%%
function text = get_genText()
    text = "prj_list = dir('**/*.prj');" + newline + ...
           "if ~isempty(prj_list)" + newline + ...
           "    uiopen(prj_list(1).name, 1);" + newline + ...
           "end" + newline + ...
           "clear prj_list;";
end
