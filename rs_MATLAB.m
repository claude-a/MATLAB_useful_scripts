function rs_MATLAB()
%%
if ~ispc
    error('OS is not Windows');
end

%%
if isSimulinkStarted

    loaded_models = Simulink.allBlockDiagrams('model');
    loaded_models_name = get_param(loaded_models,'Name');

    if ~isempty(loaded_models)

        if ~iscell(loaded_models_name)
            temp = cell(1, 1);
            temp{1} = loaded_models_name;
            loaded_models_name = temp;
        end

        save_and_close_loaded_models(loaded_models_name);

        file_text = get_genText(loaded_models_name);
        writematrix(file_text, 'run__startup__script__m__r.m', ...
            'FileType', 'text', ...
            'QuoteStrings', false);

    end
end

%%
[~, raw_list] = system('where matlab');

%%
list = strsplit(raw_list, newline);

%%
ML_dir_file = 'bin\matlab.exe';

path_flag = false(size(list));
for i = 1:size(list, 2)
    num = strfind(list{i}, ML_dir_file);
    
    if ~isempty(num)
        path_flag(i) = true;
    end
end

valid_list = list(path_flag);

%%
this_ML_version = version('-release');

for i = 1:size(valid_list, 2)
    num = strfind(valid_list{i}, this_ML_version);
    
    if ~isempty(num)
        break;
    end
end

%%
this_script_name = 'rs_MATLAB.m';
script_path = which(this_script_name);
script_path = strsplit(script_path, this_script_name);

eval(['!"', script_path{1} ,'restart_MATLAB_sh.bat" ', '"', valid_list{i}, '"']);

end

%%
function text = get_genText(loaded_models_name)
text = "";
for i = 1:numel(loaded_models_name)
    text = text + ...
        "open_system(" + "'" + loaded_models_name{i} + "'" + ");" + newline;
end

end

function save_and_close_loaded_models(loaded_models_name)

for i = 1:numel(loaded_models_name)
    close_system(loaded_models_name{i}, 1);
end

end
