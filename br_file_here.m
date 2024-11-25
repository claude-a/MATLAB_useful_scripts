function br_file_here(file_name)
%%
% find and copy "file_name" and paste current folder.
%%
if (nargin ~= 1)
    return;
end

if ispc
    separator = '\';
else
    separator = '/';
end

%%
file_path_full = which(file_name);
[~, file_name_body, ext] = fileparts(file_path_full);
copyfile(file_path_full, [pwd, separator, file_name_body, ext], 'f');

end