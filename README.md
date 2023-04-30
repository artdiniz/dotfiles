# artdiniz dotfiles


# `programs*/<program_name>` folders

## `install*.sh` files
Install scripts. Each file can be a different way to install the program.
## `installed*.sh` files
Scripts that tell dotfiles lib that a program ins installed (this is checked before allowing any other scripts to run).
If not set dotfiles lob will just check if <program_name> is a valid command in the current shell with `which <program_name>`.
## `postinstall*.sh` files
Setup scripts to run after successfull install
## `link*.sh` file
This should `echo` the path to the files you want to symlink
## `copy*.sh` file
This should `echo` the path to the files you want to copy
## `files` folder
All files that will be linked, copied or used in install and postinstall scripts live here.
## `backup*.sh` files
The `backup` command automatically backups files listed by `copy*.sh` and `link*.sh` in the `files` folder, but that's not always enough;
When backup is not from a file, when it's the output of some command or some manual stuff, use `backup*.sh` files.
They can run whatever is needed, gather the data to be backed up and create their respective files in `files`;
They can just open web pages or show instructions on how you can backup stuff;
## `.shell_env` and `.shell_env_private` files
This files are sourced any time a new shell is created. Any shell env settings and modifications a progra needs should lay here.
A common example is a program that need to add itself to the PATH variable.
All `.shell_env_private` files are ignored on versioning and are usually created by a `postinstall*.sh` script (e.g. git to set author name and email).
## `.terminal_env` and `.terminal_env_private` files
Quite the same as `.shell_env` and `.shell_env_private` the only difference being that it's sourced whenever a terminal program is in use (when the shell is interactive).
Those are perfect to setup command aliases and change ps1|prompt and other things that should be only important for your usage of the terminal.
