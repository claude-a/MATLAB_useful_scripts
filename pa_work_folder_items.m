function pa_work_folder_items(folder_name)
%% pack the folders and files in current work directory.
%%
current_dir = pwd;

temp = strsplit(current_dir, filesep);
dir_folder_name = temp{1,end};

%%
if (nargin > 0)
    answer = cell(1, 1);
    answer{1} = folder_name;
else
    answer = cell(1, 1);
    answer{1} = dir_folder_name;
end

%% check git files
if exist('.git', 'dir')
    git_flag = true;
else
    git_flag = false;
end

%%
same_name_flag = false;
if (size(answer{1}, 2) == size(dir_folder_name, 2))
    same_name_flag = true;
    temp = answer{1} == dir_folder_name;
    for i = 1:size(temp, 2)
        if (temp(1, i) == false)
            same_name_flag = false;
            break;
        end
    end
end

%%
if git_flag
    [gf_index, ~] = listdlg(...
        'SelectionMode', 'single', ...
        'ListString', ...
        {'include .git', 'exclude .git'});

    if isempty(gf_index)
        return;
    end
else
    gf_index = 0;
end

%%
if (gf_index == 2)
    cmd_text = ['git archive HEAD --worktree-attributes --prefix=', ...
        answer{1}, '/ --output=', ...
        answer{1}, '.zip'];
    system(cmd_text);
   
    movefile([answer{1}, '.zip'], '../');
    cd('../');
else
    cd('../');
    if same_name_flag
        zip(answer{1}, answer{1});
    else
        copyfile(dir_folder_name, answer{1}, 'f');
        zip(answer{1}, answer{1});
        rmdir(answer{1}, 's');
    end
    
end

end

