function pr_start_project(project_folder_path)
%%
if (nargin == 1)
    cd(project_folder_path);
end

%%
prj_list = dir('**/*.prj');
if ~isempty(prj_list)
        uiopen(prj_list(1).name, 1);
end

end
