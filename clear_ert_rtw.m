%% This script is used when clearing current Simulink works.
% Search and delete all "_ert_rtw" named folder in the current directory.

%% Global
clear functions;

%% find "_ert_rtw"
folder_list = dir('**/*_ert_rtw');

%%

if ispc
    sep_char = '\';
else
    sep_char = '/';
end

for i = 1:size(folder_list, 1)
    try
        rmdir([folder_list(i).folder, sep_char, folder_list(i).name], 's');
    catch % when the folder doesn't exist.
        % Do nothing.
    end
end

clear folder_list sep_char i;
