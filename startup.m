%% run with "cpr_cleanRestartProject.m"
if (exist('run__startup__script__m__', 'file') == 2)
    run__startup__script__m__;
    delete('run__startup__script__m__.m');
end

%% run with "rs_MATLAB.m"
if (exist('run__startup__script__m__r', 'file') == 2)
    run__startup__script__m__r;
    delete('run__startup__script__m__r.m');
end
