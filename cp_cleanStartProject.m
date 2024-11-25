function cp_cleanStartProject(g_flag)
%% clean and start PJ.
%%
cl_MATLAB;

if(nargin < 1)
    g_RevertClean;
else
    g_RevertClean(g_flag);
end

clc;

%%
prj_list = dir('**/*.prj');
if ~isempty(prj_list)
    uiopen(prj_list(1).name, 1);
end
clear prj_list;

end
