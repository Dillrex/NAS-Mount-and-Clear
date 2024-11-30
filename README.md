# NAS Mount and Clear

A GUI-based Bash script designed for mounting NAS shares, navigating folders, and managing `.mkv` files. This tool simplifies managing files on your network storage by providing an intuitive interface for mounting NAS shares and performing cleanup tasks.

---

## Features
- **Auto-detect NAS Shares**: Lists available NAS shares on your network.
- **Simple NAS Mounting**: Mount shares without requiring credentials (for public shares).
- **Folder Navigation**: Use a GUI to browse through mounted NAS folders.
- **File Cleanup**:
  - Delete all `.mkv` files in a selected folder and its subfolders.
  - Delete `.mkv` files older than a specified number of days.

---

## Installation

Follow these steps to set up and run the script:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Dillrex/NAS-Mount-and-Clear.git
   cd NAS-Mount-and-Clear

Install Required Dependencies (for Ubuntu/Debian-based systems):

    sudo apt update
    sudo apt install smbclient zenity findutils

Make the Script Executable:

    chmod +x NAS-Mount-and-Clear.sh

Run the Script:

    ./mount_nas_clear.sh

Usage
Example Workflow:

  Start the script using the command:

    ./mount_nas_clear.sh

  Select a NAS share (e.g., Videos) from the list.
  Use the GUI to browse and locate the desired folder.
  Choose cleanup options:
      Delete all .mkv files.
      Delete .mkv files older than a specified number of days.
  Confirm your selection, and the script will perform the cleanup.

Common Commands for Troubleshooting:

Check NAS Shares Manually:

    smbclient -L <NAS_IP_ADDRESS> -N

Example:

    smbclient -L 10.0.0.2 -N

Manually Mount a NAS Share:

    sudo mount -t cifs //<NAS_IP>/<SHARE_NAME> /mnt/<MOUNT_POINT> -o guest

Example:

    sudo mount -t cifs //10.0.0.2/Videos /mnt/Videos -o guest

This project is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).
You are free to:

    Share: Copy and redistribute the material in any medium or format.
    Adapt: Remix, transform, and build upon the material.

Under the following terms:

    Attribution: You must give appropriate credit, provide a link to the license, and indicate if changes were made.
    NonCommercial: You may not use the material for commercial purposes.

The full license can be found at Creative Commons.
