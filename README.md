# NAS Mount and Clear

This script provides an easy-to-use GUI-based tool for mounting a NAS, navigating through its folders, and managing `.mkv` files. It offers options to delete `.mkv` files either completely or based on their age.

## Features
- Detect and list NAS shares on the network.
- Mount a selected NAS share using a simple GUI.
- Navigate through folders in the mounted NAS.
- Choose between:
  - Deleting all `.mkv` files.
  - Deleting `.mkv` files older than a specified number of days.
- Ensure confirmation before performing irreversible actions.

## How to Use
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/<your-username>/NAS-Mount-and-Clear.git
   cd NAS-Mount-and-Clear

    Make the script executable:

chmod +x mount_nas_clear.sh

Run the script:

    ./mount_nas_clear.sh

    Follow the GUI prompts to:
        Mount a NAS share.
        Navigate to the desired folder.
        Manage .mkv files as needed.

Requirements

    zenity
    smbclient
    findutils
    bash

Ensure these tools are installed on your system before using the script.
License

This project is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).
You are free to:

    Share: Copy and redistribute the material in any medium or format.
    Adapt: Remix, transform, and build upon the material.

Under the following terms:

    Attribution: You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial: You may not use the material for commercial purposes.

The full license can be found at Creative Commons.
