### 1.2.1

1. Done
2. Done
3. `ls -Aal > localFiles.txt`
4. `scp ./localFiles.txt alehmann@141.89.108.125:~/hts-exercises/1-2`
5. Done
6. `scp alehmann@141.89.108.125:~/hts-exercises/1-2/localFiles.txt ./`

### 1.2.2

1. Gedit, Vim, Emacs, GVim, VSCode, Visual Studio, Atom, Neovim, Notepad, Notepad++, nano
2. Vim, Emacs, Neovim, nano
3. I do not like Emacs, Emacs is like a bäh-macs. And I do not know to exist this shitty editor, but saving works...ah now...and the date: 26.02.24 Amadeus Lehmann
4. I do like Vim, it works like a shim. Editing made easy: 26.02.24 Amadeus Lehmann
5. Web Applications are going to win. Editing files directly on a server without virtualization and not a browser in between, will become obsolete in the future. The console alone lacks features and has accessability issues. Your favorite text editor controls like vim or emacs can then be easily patched into the web interface. 
VSCode for example has a Remote-SSH Addin, which connects to the server via ssh and then on the server can be worked like locally in VSCode.

### 1.2.3

1. For files and directories, you have the read (4), write (2) and execute (2) permissions. Those are stored and grouped by the access groups: owner, group and other. Rights are usually managed as a 3 letter number, like 755. This would mean only owner may write, read and execute, and all others may read and execute
2. `chmod 755 ./*`
3. `cd /home/hxue && ls -Aal`
4. Permission denied
5. `touch ~/guestbook.txt && chmod 777 ~/guestbook.txt`
6. Nobody has a guestbook
7. `mkdir ~/private && chmod 770 ~/private`

### 1.2.4

1. Linux has 3 standard streams:
   1. stdin --> Input stream
   2. stdout --> Output stream
   3. stderr --> Output stream
2. `2>&1` redirects the stderr along with the standard output, so `command > test.txt 2>&1`
   1. Alternatively `command &> test.txt` should work aswell
3. `command > output.txt 2> error.txt`

### 1.2.5

1. PATH is an environment variable, which is automatically searched for executable programs upon entering a command. Uses are automatically inferring the program path for a given command
2. `export PATH=$PATH:/newpath`
3. add the export command above to the file `~/.profile`
4. The login shell is the first shell, that gets created, when a user logs onto the ssh server. The login shell must read the configuration files, like `.profile` and set environment variables. Those variables are passed to each shell, which is spawned from the login shell hierarchy. This means non login shells must not read the configuration file
5. `bash -l`

### 1.2.6

1. A terminal multiplexer forwards commands from one terminal to any number of other terminals. 
2. It is usefull, when dealing with multiple long running programs. With a multiplexer those programs can be started and monitored, while running in the background. Furthermore, when the ssh connection is terminated, the corresponding programs are terminated, if not multiplexed into background tasks
3. GNU Screen is a terminal multiplexer, which uses the entire screen for new shells. `screen` opens a new shell session
4. 
   1. `screen -S SessionName`
   2. Ctrl + a c (Switching: Ctrl + a 'number')
   3. `screen -d SessionName` or Ctrl + a d
   4. `screen -r SessionName`
5. Add the following text to the file `~/.screenrc`:

```
autodetach on 
startup_message off 
hardstatus alwayslastline 
shelltitle 'bash'

hardstatus string '%{gk}[%{wk}%?%-Lw%?%{=b kR}(%{W}%n*%f %t%?(%u)%?%{=b kR})%{= w}%?%+Lw%?%? %{g}][%{d}%l%{g}][ %{= w}%Y/%m/%d %0C:%s%a%{g} ]%{W}'
```
6. With the initial command `screen -S Name` or Ctrl + a A
7. `screen -L` creates an automatic logfile for the screen
8. tmux seems to be easier to script for with `tmux command [args]`, better window names, status bar can be styled and shell commands in intervalls defined. And the syntax is much more intuitive for me
   1. tmux ls
   2. tmux attach
   3. tmux detach
   4. tmux kill-session
   5. tmux rename
   6. tmux attach -t SessionName
   7. Ctrl + b and 'c' for new window, ',' for rename, `[0-9]` for window selection

### 1.2.7
1. `cat /proc/cpuinfo`
2. `cat /proc/cpuinfo | grep cores` --> 22
3. `who`
4. `top` MiB Mem : 515889.6 total,  14462.6 free, 173660.1 used
5. `df -h` --> 55 TB for silo
6. 5.3 TB

### 1.2.8

1. `wget https://yourlink.com`
2. `ftp domain.com` --> Set location to download to `lcd ~/ftpdownload` --> `get filename`
3. `rsync -a ./syncfolder user@ip:~/syncfolder` first source, then destination