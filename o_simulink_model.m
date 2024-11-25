function o_simulink_model(file_name)
%% open Simulink model or create empty model.
%% if file name is '_', create model for embedded function.
%%
window_size_offset = [400; 100];

%%
if (nargin ~= 1)
    h = new_system;
    open_system(h);
elseif strcmp(file_name, '_')
    h = new_system;
    open_system(h);
    file_name = get_param(0,'CurrentSystem');
    myConfigObj = getActiveConfigSet(file_name);
    
    solver_setting = myConfigObj.getComponent('Solver');
    solver_setting.SolverType = 'Fixed-step';
    solver_setting.Solver = 'FixedStepDiscrete';
    solver_setting.FixedStep = '0.01';
    
    codegen_setting = myConfigObj.getComponent('Code Generation');
    set_param(codegen_setting, 'SystemTargetFile', 'ert.tlc');
    codegen_setting.GenerateReport = 'on';
    codegen_setting.LaunchReport = 'on';
%     codegen_setting.GenerateWebview = 'on';
    codegen_setting.GenerateCodeMetricsReport = 'on';
else
    h = '';

    open_system(file_name);
    save_system(file_name, file_name);
end

%%
if ~isempty(h)
    try
        model_location = get_param(h, 'Location');
    catch
        model_location = '';
    end

    if (~isempty(model_location(model_location <= 0)) || isempty(model_location))
        % 位置情報にマイナス値がある場合、またはLocationが取れない場合、
        % ウィンドウ位置を正しく動かせないのでここで中断する。
        return;
    end

    model_location(3) = model_location(3) + window_size_offset(1);
    model_location(4) = model_location(4) + window_size_offset(2);
    set_param(h, 'Location', model_location);
end

end
