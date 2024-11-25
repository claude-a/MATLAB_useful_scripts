function message_out = sy_extend_system(varargin)
%%
% Example1: sy_extend_system("cd")
% Example2: sy_extend_system(where="ps", command="ls")
% Example3: sy_extend_system(where="wsl", dist="Ubuntu", command="cd ~ && ls")
% Example4: sy_extend_system(where="wsl", dist="Ubuntu", dockerContainer="spike-rt-builder", dockerImageTag="ghcr.io/spike-rt/spike-rt:rich", command="./build.sh led-suji")
% 
%%
if ~ispc
    error("This script is for Windows");
end

cmd_to_powershell_prefix = "powershell -Command ";
powershell_run_file_prefix = """PowerShell -ExecutionPolicy RemoteSigned ";
wsl_prefix_1 = "wsl -d ";
wsl_prefix_2 = "-e bash -c ";

powershell_file_name = "sy_extend_system_file.ps1";

%%
switch nargin
    case 1
        [~, out] = system(varargin{1});

    case 4
        if is_powershell(varargin)
            command_text = cmd_to_powershell_prefix + """" + ...
                get_command(varargin) + """";
            [~, out] = system(command_text);
        end
    case 6
        if is_wsl(varargin)
            [dist, command] = get_wsl_info(varargin);
            command_text = wsl_prefix_1 + dist + " " + ...
                wsl_prefix_2 + """" + ...
                command + """";
            [~, out] = system(command_text);
        end
    case 10
        if is_wsl(varargin)
            [dist, docker_container_name, docker_image_name, command] = ...
                get_wsl_docker_info(varargin);
            powershell_command_text = wsl_prefix_1 + dist + " " + ...
                wsl_prefix_2 + "'cd ~ && docker run --rm --name " + ...
                docker_container_name + " -v $(pwd):$(pwd) -w $(pwd) -u \""$(id -u $USER):$(id -g $USER)\"" -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro " + ...
                docker_image_name + " /bin/bash -c \""" + ...
                command + "\""'";

            docker_start_command = wsl_prefix_1 + dist + " --user root " + ...
                wsl_prefix_2 + """service docker start""";

            ps1_file_text = docker_start_command + newline + powershell_command_text;
            writelines(ps1_file_text, powershell_file_name);

            command_text = cmd_to_powershell_prefix + powershell_run_file_prefix + ...
                ".\" + powershell_file_name + """";
            [~, out] = system(command_text);

            delete(powershell_file_name);
        end
    otherwise
        error("number of input is wrong.")
end

%%
message_out = out;

end

function out = is_where(varargin_list, where_text)
out = false;

for i = 1:2:numel(varargin_list{1})
    if (i + 1 > numel(varargin_list{1}))
        break;
    end
    if (strcmp(varargin_list{1}{i}, "where") && ...
            strcmp(varargin_list{1}{i + 1}, where_text) )
        out = true;
    end
end

end

function out = is_powershell(varargin)
out = is_where(varargin(:), "ps");
end

function out = is_wsl(varargin)
out = is_where(varargin(:), "wsl");
end

function command = get_command(varargin)
command = "";

for i = 1:2:numel(varargin{1})
    if (i + 1 > numel(varargin{1}))
        break;
    end
    if strcmp(varargin{1}{i}, "command")
        command = varargin{1}{i + 1};
    end
end

end

function [dist, command] = get_wsl_info(varargin)
dist = "";
command = "";

for i = 1:2:numel(varargin{1})
    if (i + 1 > numel(varargin{1}))
        break;
    end
    if strcmp(varargin{1}{i}, "dist")
        dist = varargin{1}{i + 1};
    end
    if strcmp(varargin{1}{i}, "command")
        command = varargin{1}{i + 1};
    end
end

end

function [dist, docker_container_name, docker_image_name, command] = ...
    get_wsl_docker_info(varargin)
docker_container_name = "";

[dist, command] = get_wsl_info(varargin{1});

for i = 1:2:numel(varargin{1})
    if (i + 1 > numel(varargin{1}))
        break;
    end
    if strcmp(varargin{1}{i}, "dockerContainer")
        docker_container_name = varargin{1}{i + 1};
    end
    if strcmp(varargin{1}{i}, "dockerImageTag")
        docker_image_name = varargin{1}{i + 1};
    end
end

end
