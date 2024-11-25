function cln_from_git_repository(url_to_clone, GitHub_user_name, GitHub_token)
% clone from git repository and open folder.
%%
if nargin == 1
    gitclone(url_to_clone, RecurseSubmodules=true);
elseif nargin == 3
    gitclone(url_to_clone, ...
        RecurseSubmodules=true, ...
        Username=GitHub_user_name, ...
        Token=GitHub_token);
else
    error("Invalid argument number");
end

%%
text = strsplit(url_to_clone, '/');
folder_name = strsplit(text{end}, '.');

cd([pwd, filesep, folder_name{1}]);

%%
if nargin == 3
    head_text = "https://";
    url_split = strsplit(url_to_clone, head_text);

    if numel(url_split) == 2
        new_url = head_text + GitHub_user_name + ":" + ...
            GitHub_token + "@" + url_split{2};

        command_text = "git remote set-url origin " + new_url;
        system(command_text);
    end
end

end
