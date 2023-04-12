# About the shell environement setup files (.*sh_profile, .*shrc and etc)

Files as `.bash_profile`, `.bashrc` and others are just normal **shell** scripts. They can run commands, create and/or export variables, functions (more commands) and aliases.

What diferentiate them from others is that those scripts are run by default in specific situations and steps in the lifecycle of a **shell** program. Most of them are executed before anything gets to be executed, in an initialization step. Some of them are executed after everything has executed and the **shell** program is exiting.

From now on this document will only talk about the init scripts.

All the exported variables, functions and aliases created by those init scripts are exported to the root level **shell environment**, and are accessible by all subsequential scripts and commands, thus the variables created by those scripts are usually called **Environment Varibles**.

For sake of organization and ease of maintenance, init scripts can be distributed in multiple files and then sourced (imported) in the main init script with: `. script-name-to-source.sh`.

## Why those files are executed

  1. Programs often depend on externally or user defined values. An example is a program that need the path to a folder where you installed some other program. You as a user get to decide where to install and put things, so the program needs to get those kind of values from you. Instead of always asking you, it can expect you to set a  **Environment Variable** saying where it is. Examples of those are **ANDROID_SDK_ROOT**, **JAVA_HOME** and others.

  2.  You as a **Terminal user**, may execute some shell commands often, e.g. `ls -la` or `sudo !!`. If you prefer to not always type the whole command, you can type less characters by creating aliases: `alias ll='ls -la'`.

  3. You as a **Terminal user** may want to have a short name for not one, but a set of more complex commands that you often execute. For those you can create a function; `function name { #commands }`

  4. You as a **Terminal user** may want to have useful info displayed before every command is inputted. This info is wha we call a Prompt String. The most important and almost always present information is the indication that command input is available with the dollar sign: `$`. Many people like to have the current user, host and directory displayed too: `artdiniz@macbookpro:~/Desktop $`. This is done by creating a **Environment Variable** named **PS1**.

TL;DR;
  - To enable access of externally or user defined values to **other programs** running in your machine, including the **shell** program itself.
  - To suit the **shell interaction** (almost always via a Terminal Application) to the preferences and usage pattern of the user and programs of that machine.

So there are two main targets here:
    - Other programs that need externally or user defined values
    - You as a user of a interactive shell (shell running in terminal).

It's all about the user!

## What files are executed and when they are executed?

First, a formal explanation about the invocation conditions and order of each file with this excerpt from `man bash`:

```
INVOCATION
    A  login shell is one whose first character of argument zero is a -, or
    one started with the --login option.

    An interactive shell is one started without  non-option  arguments  and
    without the -c option whose standard input and error are both connected
    to terminals (as determined by isatty(3)), or one started with  the  -i
    option.   PS1 is set and $- includes i if bash is interactive, allowing
    a shell script or a startup file to test this state.

    The following paragraphs describe how bash executes its startup  files.
    If  any  of  the files exist but cannot be read, bash reports an error.
    Tildes are expanded in file names as described below under Tilde Expan-
    sion in the EXPANSION section.

    When  bash is invoked as an interactive login shell, or as a non-inter-
    active shell with the --login option, it first reads and executes  com-
    mands  from  the file /etc/profile, if that file exists.  After reading
    that file, it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile,
    in  that order, and reads and executes commands from the first one that
    exists and is readable.  The --noprofile option may be  used  when  the
    shell is started to inhibit this behavior.

    When  a  login  shell  exits, bash reads and executes commands from the
    file ~/.bash_logout, if it exists.

    When an interactive shell that is not a login shell  is  started,  bash
    reads  and executes commands from ~/.bashrc, if that file exists.  This
    may be inhibited by using the --norc option.  The --rcfile file  option
    will  force  bash  to  read  and  execute commands from file instead of
    ~/.bashrc.

    When bash is started non-interactively, to  run  a  shell  script,  for
    example, it looks for the variable BASH_ENV in the environment, expands
    its value if it appears there, and uses the expanded value as the  name
    of  a  file to read and execute.  Bash behaves as if the following com-
    mand were executed:
            if [ -n "$BASH_ENV" ]; then . "$BASH_ENV"; fi
    but the value of the PATH variable is not used to search for  the  file
    name.

    [...] (about POSIX compatibility mode when called as `sh`)
```

### My words from what I understand from this excerpt:

There are 2 major ways of running a **shell**:
  1. Interactive shell: opening a terminal 
    - the shell is always executing something or prompting the user for the next command;
    - it only exits on user commands, never automatically;

  2. Non-interactive shell: executing a bash script file `bash file-name` or command with `bash -c "command"` 
    - the shell executes a pre defined set of commands and then exits

**Item 2** executes the file defined by the **BASH_ENV** environment variable. This variable is not set by default and thats good because scripts I write with the intention to be run in other machines would trigger a user defined environment setup each time they're executed. As pointed out before, this setup scripts are about the user and its machine, **not about my script**.

**Item 2** only executes **.*sh_profile** files when executed as a login shell (will prompt for user name and password): `bash --login file-name`. And that makes sense, because user defined values may be inmportant for this script.

If before executing a bash script (as in step 2), you first open a terminal (as in step 1), locate the file and then execute it, we can assume that the already setup environment is available for the script that will be executed. **But the setup scripts are not run again**.

Only cases left for now on are for interactive shells.

... TODO how Terminal apps run shell interactivelly and therefore we can assume interactive shell scripts

.... TODO about terminal applications starting shell interactivelly always. 

... TODO about macOS running launchd when accessing Desktop from the login screen - ** plist files (non related to shell) **
    && about Ubuntu running a login shell when accessing the Desktop from the login screen - **`*sh_profile`**

... TODO about macOS: as you didn't logged in shell before, it runs a login shell always when opening Terminal – **`*sh_profile`**

... TODO about Ubuntu: as you logged in shell before, when accessing your user it runs a non-login shell always when opening Terminal () – **`.*shrc`**


###### # .*sh_profile
```sh
. ~/dotfiles/.all_env_setup

# If in an interactive shell
case "$-" in 
    *i*)
        . ~/dotfiles/.interactive_env_setup
    ;;
esac

# login shell environment
```

###### # .*shrc
```sh
. ~/dotfiles/.login_env_setup

# We can assume we are in an interactive shell
. ~/dotfiles/.interactive_env_setup
```

###### # ~/dotfiles/.login_env_setup
```sh
# important environment stuff for all scripts and programs running

JAVA_HOME=""
```

###### # ~/dotfiles/.interactive_env_setup
```sh
# important things to the Terminal/Interactive shell users and other interacion/terminal related programs

. /usr/local/etc/bash_completion.d/git-completion.bash
. /usr/local/etc/bash_completion.d/git-prompt.sh
PS1="\u@\h:\W $(__git_ps1)\n$" 
```