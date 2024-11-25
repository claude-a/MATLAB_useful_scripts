function res_model_color_tab()
%% Reset the color of Simulink model blocks.
%%
model_name = bdroot;
block_list = find_system(model_name);

for i = 2:size(block_list, 1)
    set_param(block_list{i, 1}, 'ForegroundColor', 'black');
    set_param(block_list{i, 1}, 'BackgroundColor', 'white');
    
    close_system(block_list{i, 1});
end

end