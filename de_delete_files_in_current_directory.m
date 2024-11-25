function de_delete_files_in_current_directory()

delete('*.*');
try
    rmdir('*','s');
catch
    % Do Nothing
end

clc;

end
