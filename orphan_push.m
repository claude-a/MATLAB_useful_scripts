function orphan_push()
%% Init
if exist('.git', 'dir') ~= 7
    return;
end

DateString = string(datetime('now', 'Format', 'yyyyMMddHHmmss'));

system("git config --local core.pager ""LESSCHARSET=utf-8 less""");
system("git config --local core.quotepath ""false""");

%% List
% all_files = dir("**/*.*");
% all_file_num = numel(all_files);
% is_managed_by_git = false(numel(all_files), 1);
% 
% display_limit = 0;
% 
% for i = 1:all_file_num
%     is_dot_git = strfind(all_files(i).folder, ".git");
%     is_dot_file = strcmp(all_files(i).name, ".") || strcmp(all_files(i).name, "..");
% 
%     if (isempty(is_dot_git) && ~is_dot_file && ~all_files(i).isdir)
%         file_full_path = string([all_files(i).folder, filesep, all_files(i).name]);
%         [~, system_command] = system("git ls-files """ + file_full_path + """");
%         if ~isempty(system_command)
%             is_managed_by_git(i) = true;
%         end
%     end
% 
%     if (i / all_file_num > display_limit)
%         disp("Git管理されているファイルをリスト化 " + ...
%             string(i * 100 / all_file_num) + " % 完了");
% 
%         display_limit = display_limit + 0.1;
%     end
% end
% 
% git_managed_files = all_files(is_managed_by_git);
% git_file_list = cell(numel(git_managed_files), 1);
% for i = 1:numel(git_managed_files)
%     git_file_list{i} = string([git_managed_files(i).folder, filesep, git_managed_files(i).name]);
% end

%% Orphan
[~, system_command] = system("git branch");
branch_list = strsplit(system_command, newline);
for i = 1:numel(branch_list)
    if strcmp(branch_list{i}(1:2), '* ')
        branch_name = string(branch_list{i}(3:end));
        break;
    end
end

temp_branch_name = strrep(branch_name + DateString, newline, "");

system("git checkout --orphan " + temp_branch_name);

%% Add
% system("git reset HEAD");
% 
% git_file_list_num = numel(git_file_list);
% display_limit = 0;
% 
% for i = 1:git_file_list_num
%     system("git add " + """" + git_file_list{i} + """");
% 
%     if (i / git_file_list_num > display_limit)
%         disp("orphanブランチにファイルを追加 " + ...
%             string(i * 100 / git_file_list_num) + " % 完了");
% 
%         display_limit = display_limit + 0.1;
%     end
% end

%% Commit
system("git commit -m " + """orphan push""");

%% Push
system("git push origin " + temp_branch_name);

%% Delete Branch
system("git push --delete origin " + branch_name);
system("git branch -D " + branch_name);

%% Rename
system("git branch -m " + branch_name);
system("git push origin " + branch_name);

system("git push origin --delete " + temp_branch_name);

end
