function op_open_preferences_general()
%% check locale
locale = feature('locale');
lang = split(locale.messages, '.');

%%
if strcmp(lang{1}, 'ja_JP')
    preferences('一般');
else
    preferences('General');
end


end
