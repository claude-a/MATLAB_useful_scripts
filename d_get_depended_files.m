function d_get_depended_files()
%%
bdclose all
projObj = currentProject;

%%
all_files_obj = projObj.Files;
files_index = false(size(all_files_obj));

for i = 1:numel(all_files_obj)
    if (exist(all_files_obj(1, i).Path, 'dir') ~= 7)
        files_index(1, i) = true;
    end
end

files_obj = all_files_obj(files_index);
files_path_list = cell(numel(files_obj), 2);
for i = 1:numel(files_obj)
    files_path_list{i, 1} = char(files_obj(1, i).Path);
    text = strsplit(files_obj(1, i).Path, filesep);
    files_path_list{i, 2} = char(text(end));
end

%%
files_path_list_sorted = sortrows(files_path_list, 2);

%%
[RM_indx, ~] = listdlg('ListString', files_path_list_sorted(:, 2), ...
    'PromptString', {'取り出すファイルの依存元を選択してください：'}, ...
    'ListSize', [300, 400]);
if isempty(RM_indx)
    return;
end

%%
updateDependencies(projObj);
depend_info = projObj.Dependencies;

extract_list = cell(numel(RM_indx), 1);
for i = 1:numel(RM_indx)
    try
        extract_list{i} = bfsearch(depend_info, files_path_list_sorted{RM_indx(i), 1});
    catch
        extract_list{i} = files_path_list_sorted{RM_indx(i), 1};
    end
end

%%
folder_dir = 'extracted__files';
if exist(folder_dir, 'dir')
    rmdir(folder_dir, 's');
end
mkdir(folder_dir);

for i = 1:numel(extract_list)
    extract_files = extract_list{i};
    
    for j = 1:numel(extract_files)
        if (exist(extract_files{j}, 'file') == 2) || ...
                (exist(extract_files{j}, 'file') == 4)
            copyfile(extract_files{j}, [pwd, filesep, folder_dir]);
        end
    end
end

%%
cd(folder_dir);
mov_to_temp

end