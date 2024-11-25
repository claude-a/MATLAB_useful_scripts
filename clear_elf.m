%% This script is used when clearing current Simulink works.
% Search and delete all elf file in the current directory.

%% Global
top_dir = pwd;
clear functions;

%% clear cache (elf files)
elf_list = dir('**/*.elf');

for i = 1:size(elf_list, 1)
    cd(elf_list(i).folder)
    delete(elf_list(i).name);
end

cd(top_dir);
clear top_dir elf_list i;
