function u_unzip_all()
%% Unzip all zip files in current folder.
%%
zip_list = dir('*.zip');

for i = 1:numel(zip_list)
    unzip(zip_list(i).name);
end

end