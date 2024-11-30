#!/bin/bash

# Define the temporary output directory (use a valid directory you have write access to)
tmp_dir="$HOME/tmp"
mkdir -p "$tmp_dir"

# Function to mount NAS using CIFS (SMB) without credentials
mount_nas() {
    local nas_ip="$1"
    local mount_point="$HOME/mnt/$(basename "$nas_ip")"

    # Check if mount directory exists, if not, create it
    if [ ! -d "$mount_point" ]; then
        mkdir -p "$mount_point"
    fi

    # Mount the NAS using CIFS (SMB) without credentials
    sudo mount -t cifs "$nas_ip" "$mount_point" -o guest,uid=$(id -u),gid=$(id -g)

    # Check if mount was successful
    if mount | grep -q "$mount_point"; then
        zenity --info --text="NAS mounted successfully at $mount_point!"
        echo "$mount_point"
    else
        zenity --error --text="Failed to mount $nas_ip. Please check your network connection."
        return 1
    fi
}

# Directly attempt to query the NAS at 10.0.0.2 using smbclient without credentials
nas_ip="10.0.0.2"
# Run smbclient to list the shares with SMB3 forced and capture the output
smbclient -L "$nas_ip" -N -m SMB3 2>"$tmp_dir/smbclient_error.log" >"$tmp_dir/smbclient_output.txt"

# Show the error log if there is any
if [ -s "$tmp_dir/smbclient_error.log" ]; then
    cat "$tmp_dir/smbclient_error.log"
fi

# Show the raw smbclient output for debugging purposes
cat "$tmp_dir/smbclient_output.txt"

# Extract the share names (look for lines starting with "Disk" and ignore lines with "IPC$")
nas_shares=$(grep -P '^\s+\S+\s+Disk' "$tmp_dir/smbclient_output.txt" | awk '{print $1}' | grep -v "^IPC$")

# If no shares are found, show an error
if [ -z "$nas_shares" ]; then
    zenity --error --text="No shares found on NAS at $nas_ip."
    exit 1
fi

# Let the user select a NAS share
nas_share_choice=$(zenity --list --title="Select NAS Share to Mount" --column="NAS Shares" $nas_shares)

# If no share is selected, exit
if [ -z "$nas_share_choice" ]; then
    zenity --error --text="No share selected. Exiting..."
    exit 1
fi

# Mount the selected NAS share without credentials
mount_point=$(mount_nas "//${nas_ip}/${nas_share_choice}")
if [ -z "$mount_point" ]; then
    exit 1
fi

# Let the user select the folder within the mounted NAS (i.e., recordings folder)
recordings_folder=$(zenity --file-selection --directory --title="Select Folder to Delete MKVs From" --filename="$mount_point/recordings/")

# Check if the user canceled the selection
if [ -z "$recordings_folder" ]; then
    zenity --error --text="No folder selected. Exiting..."
    exit 1
fi

# Let the user specify the action to perform (delete all or delete old ones)
delete_action=$(zenity --list --title="Select Deletion Option" --column="Option" --radiolist --text="Choose what to delete:" \
    --column="" --column="Action" TRUE "Delete All MKVs" FALSE "Delete MKVs Older Than X Days")

# If user selects "Delete MKVs Older Than X Days", ask for the number of days
if [ "$delete_action" == "Delete MKVs Older Than X Days" ]; then
    days=$(zenity --entry --title="File Age" --text="Enter the number of days before files are considered old:" --entry-text="30")

    # If no valid input, exit
    if [ -z "$days" ] || ! [[ "$days" =~ ^[0-9]+$ ]]; then
        zenity --error --text="Invalid number of days entered. Exiting..."
        exit 1
    fi
    # Set the condition to delete `.mkv` files older than the entered days
    delete_condition="-mtime +$days"
else
    # If user selects "Delete All MKVs", don't apply any age filter
    delete_condition=""
fi

# Ask for confirmation before deletion
confirmation=$(zenity --question --text="Are you sure you want to delete the MKV files in $recordings_folder? This action is irreversible." --ok-label="Yes" --cancel-label="No")

# If the user confirms, run the function to delete the files
if [ $? -eq 0 ]; then
    # Loop through the selected folder and its subfolders and delete `.mkv` files based on the delete condition
    find "$recordings_folder" -type f -name "*.mkv" $delete_condition -exec rm -f {} \;
    zenity --info --text="Old MKV files have been successfully cleared from $recordings_folder and its subfolders!"
else
    zenity --info --text="Operation cancelled."
    exit 0
fi
