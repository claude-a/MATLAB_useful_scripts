%% This script is used when clearing current Simulink works.
% Search and delete all "slprj" folder in the current directory.

%% Global
clear functions;

%% clear slprj
slprj_list = dir('**/slprj');

for i = 1:size(slprj_list, 1)
    try
        rmdir(slprj_list(i).folder,'s');
    catch % when the folder doesn't exist.
        % Do nothing.
    end
end

clear slprj_list i;
