#!/bin/bash

# Debugging file
debug_log="$HOME/debug_log.txt"
echo "Starting script..." > "$debug_log"

# Function to mount NAS using CIFS
mount_nas() {
    local nas_ip="$1"
    local nas_share="$2"
    local mount_point="$HOME/mnt/${nas_share}"

    echo "Mounting NAS Share //${nas_ip}/${nas_share}" >> "$debug_log"

    if [ ! -d "$mount_point" ]; then
        mkdir -p "$mount_point"
    fi

    sudo mount -t cifs "//${nas_ip}/${nas_share}" "$mount_point" -o guest,uid=$(id -u),gid=$(id -g)

    if mount | grep -q "$mount_point"; then
        echo "NAS mounted successfully at $mount_point" >> "$debug_log"
        echo "$mount_point"
    else
        zenity --error --text="Failed to mount NAS share."
        echo "Failed to mount NAS share //${nas_ip}/${nas_share}" >> "$debug_log"
        exit 1
    fi
}

# Set NAS details
nas_ip="10.0.0.2"
nas_share="example_share" # Update to your share

# Mount the share
mount_point=$(mount_nas "$nas_ip" "$nas_share")

# Let the user select a folder
recordings_folder=$(zenity --file-selection --directory --title="Select Folder to Delete MKVs From" --filename="$mount_point/")
if [ -z "$recordings_folder" ]; then
    zenity --error --text="No folder selected. Exiting..."
    echo "No folder selected." >> "$debug_log"
    exit 1
fi
echo "Folder selected: $recordings_folder" >> "$debug_log"

# Ask the user for the deletion option
delete_action=$(zenity --list --radiolist \
    --title="Delete MKVs" \
    --text="Choose an option:" \
    --column="Select" --column="Action" \
    TRUE "Delete All MKVs" FALSE "Delete MKVs Older Than X Days")

if [ -z "$delete_action" ]; then
    zenity --error --text="No valid option selected. Exiting..."
    echo "No valid option selected." >> "$debug_log"
    exit 1
fi
echo "Delete action selected: $delete_action" >> "$debug_log"

# If "Delete Older Than X Days" is selected, get the number of days
if [[ "$delete_action" == "Delete MKVs Older Than X Days" ]]; then
    days=$(zenity --entry --title="File Age" --text="Enter the number of days:" --entry-text="30")
    if [ -z "$days" ] || ! [[ "$days" =~ ^[0-9]+$ ]]; then
        zenity --error --text="Invalid number of days entered. Exiting..."
        echo "Invalid days entered: $days" >> "$debug_log"
        exit 1
    fi
    delete_condition="-mtime +$days"
    echo "Delete condition set to: $delete_condition" >> "$debug_log"
else
    delete_condition=""
    echo "Delete All MKVs selected" >> "$debug_log"
fi

# Confirm deletion
zenity --question --text="Are you sure you want to delete the MKV files in $recordings_folder? This action cannot be undone."
if [ $? -ne 0 ]; then
    zenity --info --text="Operation cancelled."
    echo "Operation cancelled by user." >> "$debug_log"
    exit 0
fi

# Execute the deletion
echo "Executing deletion with condition: $delete_condition" >> "$debug_log"
find "$recordings_folder" -type f -name "*.mkv" $delete_condition -exec rm -f {} \;

# Notify completion
zenity --info --text="Deletion completed successfully."
echo "Deletion completed for folder: $recordings_folder" >> "$debug_log"
