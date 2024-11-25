function m_make_dir_and_move(dir_name, move_flag)

mkdir(dir_name);

%%
if (nargin > 1.5)
    file_list = dir('*');
    if numel(file_list) <= 3
        cd([pwd, filesep, dir_name]);
        return;
    end
    file_list_active = file_list(3:end);

    exclude_dir_folder_vec = true(numel(file_list_active), 1);
    for i = 1:numel(file_list_active)
        if (strcmp(file_list_active(i).name, dir_name) && ...
                file_list_active(i).isdir)
            exclude_dir_folder_vec(i) = false;
        end
    end

    file_list_to_move = file_list_active(exclude_dir_folder_vec);

    for i = 1:numel(file_list_to_move)
        movefile(file_list_to_move(i).name, dir_name);
    end

    cd([pwd, filesep, dir_name]);
else
    cd([pwd, filesep, dir_name]);
end

end