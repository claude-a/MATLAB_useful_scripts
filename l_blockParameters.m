function l_blockParameters(model_name)
%% Init
COMMA = char(39);

if (nargin ~= 1)
    model_name = gcb;
end

    %% get lists
    obj_param_lists = get_param(model_name, 'ObjectParameters');
    obj_param_names = fieldnames(obj_param_lists);

    %% get setting and save
    param_setting_list = cell(size(obj_param_names));
    for i = 1:size(obj_param_names, 1)
        try
            param_setting_list{i, 1} = get_param(model_name, obj_param_names{i});
        catch
        end
    end
    obj_param_name_setting = [obj_param_names, param_setting_list];
    save('obj_param_name_setting.mat', 'obj_param_name_setting');

    %% output
    evalin('base', ['load(', COMMA, 'obj_param_name_setting.mat', COMMA, ');']);
    openvar('obj_param_name_setting');

end