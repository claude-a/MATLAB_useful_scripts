%% This script is used when clearing current Simulink works.
% Search and delete all simulink cache in the current directory.

%% Global
top_dir = pwd;
clear functions;

%% clear cache (slxc files)
cache_list = dir('**/*.slxc');

for i = 1:size(cache_list, 1)
    cd(cache_list(i).folder)
    delete(cache_list(i).name);
end

cd(top_dir);
clear top_dir cache_list i;
