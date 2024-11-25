%% This script is used when clearing current Simulink works.
% Search and delete all exe, hex, bin file in the current directory.

%% Global
top_dir = pwd;
clear functions;

%% clear cache (exe files)
exe_list = dir('**/*.exe');

for i = 1:size(exe_list, 1)
    cd(exe_list(i).folder)
    delete(exe_list(i).name);
end
cd(top_dir);

%% clear cache (hex files)
hex_list = dir('**/*.hex');

for i = 1:size(hex_list, 1)
    cd(hex_list(i).folder)
    delete(hex_list(i).name);
end
cd(top_dir);

%% clear cache (bin files)
bin_list = dir('**/*.bin');

for i = 1:size(bin_list, 1)
    cd(bin_list(i).folder)
    delete(bin_list(i).name);
end
cd(top_dir);

%%
clear top_dir exe_list i;
