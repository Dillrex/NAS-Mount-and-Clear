# NAS Mount and Clear

A GUI-based Bash script designed for mounting NAS shares, navigating folders, and managing `.mkv` files. This tool simplifies managing files on your network storage by providing an intuitive interface for mounting NAS shares and performing cleanup tasks.

## Features
- **Auto-detect NAS Shares**: Lists available NAS shares on your network.
- **Simple NAS Mounting**: Mount shares without requiring credentials (for public shares).
- **Folder Navigation**: Use a GUI to browse through mounted NAS folders.
- **File Cleanup**:
  - Delete all `.mkv` files in a selected folder and its subfolders.
  - Delete `.mkv` files older than a specified number of days.

## Prerequisites
Ensure the following tools are installed on your system:
- `bash` (default shell on Linux)
- `zenity` (for GUI dialogs)
- `smbclient` (for detecting and mounting SMB shares)
- `findutils` (for searching and managing files)

### Install Dependencies on Ubuntu/Debian:

  'sudo apt update'
  'sudo apt install smbclient zenity findutils'

Clone the Repository:

git clone https://github.com/Dillrex/NAS-Mount-and-Clear.git
cd NAS-Mount-and-Clear

Make the Script Executable:

chmod +x mount_nas_clear.sh

Run the Script:

    ./mount_nas_clear.sh

    Follow GUI Prompts:
        Select a NAS share to mount.
        Navigate through folders to locate the folder of interest.
        Choose whether to delete all .mkv files or only those older than a certain number of days.
Example Workflow

    Start the script.
    Select the NAS share (e.g., Videos).
    Use the GUI to browse and locate the desired folder.
    Choose cleanup options:
        Delete all .mkv files.
        Delete .mkv files older than a specified number of days.
    Confirm your selection, and the script will perform the cleanup.

Screenshots

Include screenshots here if desired.
License

This project is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).
You are free to:

    Share: Copy and redistribute the material in any medium or format.
    Adapt: Remix, transform, and build upon the material.

Under the following terms:

    Attribution: You must give appropriate credit, provide a link to the license, and indicate if changes were made.
    NonCommercial: You may not use the material for commercial purposes.

The full license can be found at Creative Commons.
