function cl_MATLAB()
%% This script is used when clearing current Simulink works.
%% close project
try
    proj = currentProject;
    proj.close;
catch
    % Do Nothing
end

%% Init
ver_list = ver;

have_Requirements = false;
have_Test = false;
have_pct = false;

for i = 1:numel(ver_list)
    if strcmp(ver_list(i).Name, 'Requirements Toolbox')
        have_Requirements = true;
    end
    
    if strcmp(ver_list(i).Name, 'Simulink Test')
        have_Test = true;
    end
    
    if strcmp(ver_list(i).Name, 'Parallel Computing Toolbox')
        have_pct = true;
    end
end

%% Global
evalin('base','clear functions;');

%% MATLAB Editor
allDocs = matlab.desktop.editor.getAll;
allDocs.close;

%% Figure
evalin('base', 'close all force;');

%% sldd
Simulink.data.dictionary.closeAll('-discard');

%% Data Inspector
Simulink.sdi.clear;
Simulink.sdi.clearPreferences;
Simulink.sdi.close;

%% Requirements
if (have_Requirements)
    evalin('base', 'bdclose all;');
    slreq.clear();
end

%% Test Manager
if (have_Test)
    sltest.testmanager.clear;
    sltest.testmanager.clearResults;
    sltest.testmanager.close;
end

%% Parallel
if (have_pct)
    poolobj = gcp('nocreate');
    delete(poolobj);
end

%% Others
evalin('base', 'clear all;');
evalin('base', 'bdclose all;');
evalin('base', 'rehash;');
evalin('base', 'clc;');

end
