%% move the current work directory files and folders to temp folder.
function mov_to_temp(file_name)
if (nargin < 0.5)

    %% Init
    clear all;
    bdclose all;
    clc;
    current_dir = pwd;

    %% get folder name.
    temp_path = getenv('TEMPORARY');
    folder_path = strsplit(current_dir, filesep);
    folder_name = folder_path{1, end};
    end_path = [temp_path, filesep, folder_name];

    %% create folder.
    mkdir(temp_path, folder_name);

    %% move
    cd('../');

    copyfile(current_dir, end_path, 'f');
    rmdir(current_dir, 's');

    cd(end_path);

    %% terminate
    clear all;
    clc;

else
    temp_path = getenv('TEMPORARY');
    if exist(file_name, "file")
        movefile([pwd, filesep ,file_name], temp_path);
        cd(temp_path);
    else
        cd(temp_path);
    end
end

end
