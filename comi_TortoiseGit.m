function comi_TortoiseGit()
%% Open TortoiseGit commit window.
current_dir = pwd;

system(['"C:\Program Files\TortoiseGit\bin\TortoiseGitProc.exe"', ...
    ' /command:commit /path:"', current_dir, '" &']);

end
