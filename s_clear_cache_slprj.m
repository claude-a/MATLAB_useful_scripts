%% select which you want to clear, slxc or/and slprj.
function s_clear_cache_slprj(all_flag)
%% Init

%%
sccs_list = {'slprj', 'cache', 'ert_rtw', 'exe', 'mexw64', 'elf'};

if(nargin < 1)
    [sccs_indx, ~] = listdlg('ListString',sccs_list, ...
        'InitialValue', 1:numel(sccs_list));

    if isempty(sccs_indx)
        return;
    end
else
    sccs_indx = 1:numel(sccs_list);
end

%%
for i = 1:numel(sccs_indx)
    switch sccs_indx(i)
        case 1
            clear_slprj;
        case 2
            clear_cache;
        case 3
            clear_ert_rtw;
        case 4
            clear_exe;
        case 5
            clear_mexw64;
        case 6
            clear_elf;
        otherwise
            % Do Nothing
    end
end

%% terminate
end
