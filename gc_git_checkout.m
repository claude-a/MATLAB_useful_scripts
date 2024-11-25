function gc_git_checkout()
%% checkout branch
%%
[~,cmdout] = system('git branch -a');

branch_list = strsplit(cmdout, newline);
current_flag_idx = 1;
valid_flag = true(numel(branch_list), 1);

for i = 1:(numel(branch_list) - 1)
    if strcmp(branch_list{i}(1:2), '* ')
        current_flag_idx = i;
    end
    if ~isempty(strfind(branch_list{i}, '/HEAD'))
        valid_flag(i) = false;
    else
        branch_list{i} = branch_list{i}(3:end);
    end
end

branch_list = branch_list(valid_flag);
branch_list{end} = '<create new branch>';

%%
[RM_indx, ~] = listdlg('ListString', branch_list, ...
    'PromptString', {'切り替える先のブランチ名を指定してください：'}, ...
    'SelectionMode','single', ...
    'InitialValue', current_flag_idx, ...
    'ListSize', [300, 400]);
if isempty(RM_indx)
    return;
end

%%
if (RM_indx == numel(branch_list))
    %%
    prompt = {'新規ブランチ名:'};
    dlgtitle = 'Input';
    dims = [1 35];
    definput = {''};
    answer = inputdlg(prompt,dlgtitle,dims,definput);

    if (isempty(answer) || isempty(answer{1}))
        return;
    end

    system(['git branch ', answer{1}]);
    system(['git checkout ', answer{1}]);
else
    text_list = strsplit(branch_list{RM_indx}, '/');
    if strcmp(text_list{1}, 'remotes')
        system(['git fetch origin ', text_list{end}]);
        system(['git checkout ', text_list{end}]);
    else
        system(['git checkout ', branch_list{RM_indx}]);
    end
end

end
