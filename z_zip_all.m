function z_zip_all()
%% Zip all folder in current folder.
%%
folder_list = dir('*');

folder_flag = false(numel(folder_list), 1);
for i = 1:numel(folder_list)
    if (~strcmp(folder_list(i).name, '.')) && ...
       (~strcmp(folder_list(i).name, '..')) && ...
       (folder_list(i).isdir)
        folder_flag(i) = true;
    end
end
valid_folder_list = folder_list(folder_flag);

%%
for i = 1:numel(valid_folder_list)
    zip([valid_folder_list(i).name, '.zip'], valid_folder_list(i).name);
end

end