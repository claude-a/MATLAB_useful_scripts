function e_export_simulink_to_version(version_name)
%% export Simulink models to older version.
current_dir = pwd;

model_list = dir('**/*.slx');
model_num = size(model_list, 1);

if(nargin == 1)
    
    target_file_name = cell(model_num, 1);
    for i = 1:model_num
        target_file_cell = strsplit(model_list(i).name, '.');
        target_file_name{i} = target_file_cell{1};
    end
    
    % Open and save models.
    for i = 1:model_num
        cd(model_list(i).folder);
        load_system(target_file_name{i});
        save_system(target_file_name{i});
    end
    cd(current_dir);
    
    for i = 1:model_num
        cd(model_list(i).folder);
        load_system(target_file_name{i});
        Simulink.exportToVersion(target_file_name{i}, ...
            [target_file_name{i}, '__', version_name], version_name);
        close_system(target_file_name{i});
        delete(model_list(i).name);
        movefile([target_file_name{i}, '__', version_name, '.slx'], ...
            model_list(i).name);
    end
    
else % zero argument
    
    target_file_name = cell(model_num, 1);
    for i = 1:model_num
        target_file_cell = strsplit(model_list(i).name, '.');
        target_file_name{i} = target_file_cell{1};
    end
    
    % Open and save models.
    for i = 1:model_num
        cd(model_list(i).folder);
        load_system(target_file_name{i});
        save_system(target_file_name{i});
    end
    cd(current_dir);
    
end

cd(current_dir);

bdclose all;

end