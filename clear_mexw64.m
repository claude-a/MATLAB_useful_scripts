%% This script is used when clearing current Simulink works.
% Search and delete all mexw64 file in the current directory.

%% Global
top_dir = pwd;
clear functions;

%% clear cache (mexw64 files)
mexw64_list = dir('**/*.mexw64');

for i = 1:size(mexw64_list, 1)
    cd(mexw64_list(i).folder)
    delete(mexw64_list(i).name);
end

cd(top_dir);
clear top_dir mexw64_list i;
