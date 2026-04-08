# Syncronization Tool for The Binding Of Isaac (s-tboi)

This is a simple synchronization tool for The Binding of Isaac: Repentance that uses Git instead of Steam Cloud to synchronize save files across different devices.

The tool allows you to quickly upload, download, and manage local checkpoints of your game progress using a lightweight command-line interface.

> **Disclaimer**: This is a fan-made project and is not affiliated with or endorsed by the developers of The Binding of Isaac. It is provided as-is and is not guaranteed to work in all environments. Always keep a backup of your save files.

[TOC]

## How this works

The tool tracks the game's save directory with a Git repository. Each device connects to the same remote repository (e.g., GitHub, GitLab, or a private server). Synchronization is achieved through simple Git commands wrapped in an easy-to-use CLI.

> **Important**: Always close the game before running any command to prevent save corruption.
> **Important**: Check to have set the `SteamCloud` flag equal to 0 in the `options.ini` file (you find it in the same folder as the game's save directory).

## CLI

The main command-line interface of the tool provides:

| Command      | Description                                                                                                                                             |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `push [msg]` | Upload the current game state to the remote repository.                                                                                                 |
| `pull`       | Synchronize the game with the latest upload from another PC.                                                                                            |
| `save [msg]` | Save a local checkpoint of the game. Use this with the game **closed**. To restore this state, close the game, run `discard`, and then reopen the game. |
| `discard`    | Discard all local changes and revert to the latest checkpoint.                                                                                          |
| `help`       | Display usage information.                                                                                                                              |

## Windows Setup

### Install Git

Download and install [Git for Windows](https://git-scm.com/download/win)

### Locate the Save Folder

The default save directory for The Binding of Isaac: Repentance is:

```bash
C:\Users\<YourUsername>\Documents\My Games\Binding of Isaac Repentance
```

### Initialize the Git Repository

Open Command Prompt or PowerShell and run:

```bash
cd "C:\Users\<YourUsername>\Documents\My Games\Binding of Isaac Repentance"
git init
git remote add origin <YOUR_REMOTE_REPOSITORY_URL>
git add --all
git commit -m "Initial save"
git push -u origin main
```

Replace <YOUR_REMOTE_REPOSITORY_URL> with your GitHub/GitLab repository URL.

### Edit the s-tboi.bat

Change the path of the `REPO_DIR` variable in the `s-tboi.bat` with your current game's save file.

### Add s-tboi.bat to the PATH

1. Move `s-tboi.bat` to a folder such as `C:\Scripts`.
2. Add such folder to the System `PATH`:
    - Open System Properties → Advanced → Environment Variables.
    - Edit the Path variable and add C:\Scripts.
3. Restart your terminal.

### Usage

```bash
s-tboi push "Unlocked new character"
s-tboi pull
s-tboi save "Before attempting boss rush"
s-tboi discard
```

## Linux Setup

### Install Git (Linux)

On most Linux distributions:

```bash
# Debian/Ubuntu
sudo apt update && sudo apt install git

# Fedora
sudo dnf install git

# Arch Linux
sudo pacman -S git
```

### Locate the Save Folder (Linux)

For the native or Proton version of the game, the save directory is typically located at:

```bash
~/Documents/My Games/Binding of Isaac Repentance
```

If you are using Steam Proton, it may instead be located at:

```bash
~/.steam/steam/steamapps/compatdata/250900/pfx/drive_c/users/steamuser/Documents/My Games/Binding of Isaac Repentance
```

### Initialize the Git Repository (Linux)

Open a terminal and:

```bash
cd "~/Documents/My Games/Binding of Isaac Repentance"
git init
git remote add origin <YOUR_REMOTE_REPOSITORY_URL>
git add --all
git commit -m "Initial save"
git push -u origin main
```

Replace <YOUR_REMOTE_REPOSITORY_URL> with your GitHub/GitLab repository URL.

### Make the Script Executable and Accessible

#### Step 1 : Make the Script Executable

```bash
chmod +x s-tboi.bash
```

#### Step 2 : Move and Rename the Script

```bash
mkdir -p ~/.local/bin
mv s-tboi.bash ~/.local/bin/s-tboi
```

#### Step 3: Ensure ~/.local/bin Is in Your PATH

Most modern Linux distributions already include ~/.local/bin in the PATH. You can verify this with

```bash
echo $PATH
```

If it is not present, add it by appending the following line to your shell configuration file (e.g., `~/.bashrc`)

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Edit the s-tboi.bash

Change the path of the `REPO_DIR` variable in the `s-tboi.bash` with your current game's save file.

### Usage (Linux)

```bash
s-tboi push "Defeated Mega Satan"
s-tboi pull
s-tboi save "Before starting a new run"
s-tboi discard
```