
#!/bin/bash


# Terminal colors (ANSI)
CYAN='\033[96m'
GREEN='\033[92m'
YELLOW='\033[93m'
RED='\033[91m'
WHITE='\033[97m'
GRAY='\033[90m'
RESET='\033[0m'
BOLD='\033[1m'


clear_screen() {
    clear 2>/dev/null || true
}


display_header() {
    printf "${CYAN}${BOLD}"
    cat << "EOF"

        ███████╗██╗██╗     ███████╗███████╗
        ██╔════╝██║██║     ██╔════╝██╔════╝
        █████╗  ██║██║     █████╗  ███████╗
        ██╔══╝  ██║██║     ██╔══╝  ╚════██║
        ██║     ██║███████╗███████╗███████║
        ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

EOF

    printf "${RESET}"

    echo -e "${CYAN}=======================================================${RESET}"
    echo -e "${WHITE}${BOLD}         FILE ORGANIZER         by: k.virakboth${RESET}"
    echo -e "${CYAN}=======================================================${RESET}"
    echo -e "${GRAY}       Organize your files automatically${RESET}"
    echo ""
    echo -e "${WHITE}  [-] Photos            JPG, PNG, JPEG"
    echo -e "  [-] Documents         DOC, PDF, XLSX"
    echo -e "  [-] Applications      EXE, MSI, APK"
    echo -e "  [-] Others            Other file types${RESET}"
    echo -e "${CYAN}-------------------------------------------------------${RESET}"
}


organize_files() {
    folder_input="$1"
    moved_count=0

    # Include hidden files and handle empty folders
    shopt -s dotglob nullglob

    for file_path in "$folder_input"/*; do
        # Skip directories and non-files
        if [[ ! -f "$file_path" ]]; then
            continue
        fi

        filename=$(basename "$file_path")
        extension="${filename##*.}"

        # Handle files without extensions
        if [[ "$filename" != *.* || -z "$extension" || "$filename" == .* && "$filename" != *.*.* ]]; then
            extension=""
        else
            extension=".${extension,,}"
        fi

        # Determine destination folder
        case "$extension" in
            ".jpg"|".png"|".jpeg")
                folder_name="Photos"
                ;;
            ".doc"|".pdf"|".xlsx")
                folder_name="Documents"
                ;;
            ".exe"|".msi"|".apk")
                folder_name="Applications"
                ;;
            *)
                folder_name="Others"
                ;;
        esac

        # Create destination folder
        new_folder="$folder_input/$folder_name"

        if ! mkdir -p -- "$new_folder"; then
            echo -e "${RED}  [ERROR] Could not create $folder_name folder!${RESET}"
            continue
        fi

        # Move file
        if mv -- "$file_path" "$new_folder/"; then
            moved_count=$((moved_count + 1))
            echo -e "${GREEN}  [+] $filename -> $folder_name${RESET}"
        else
            echo -e "${RED}  [FAILED] Could not move $filename${RESET}"
        fi
    done

    # Return organized file count
    return 0
}


# Main application
clear_screen
display_header

# Handle cancellation
handle_interrupt() {
    echo -e "${RED}\n  [CANCELLED] Operation stopped by user!${RESET}"
    exit 130
}

trap handle_interrupt INT

# Display input instructions
echo -e "${GRAY}  [INPUT INSTRUCTIONS]${RESET}"
echo -e "${GRAY}  Enter the full folder path you want to organize.${RESET}"
echo -e "${GRAY}  Example: C:\\Users\\YourName\\Downloads${RESET}"

# Get folder path
echo ""
read -r -p "$(echo -e "${CYAN}  Enter folder path => ${WHITE}")" folder_input

# Remove surrounding quotation marks
folder_input="${folder_input#\"}"
folder_input="${folder_input%\"}"

# Validate folder path
if [[ ! -d "$folder_input" ]]; then
    echo ""
    if [[ ! -e "$folder_input" ]]; then
        echo -e "${RED}  [ERROR] Folder or file not found!${RESET}"
    else
        echo -e "${RED}  [ERROR] Invalid directory path!${RESET}"
    fi
    exit 1
fi

# Start organizing
echo -e "${YELLOW}\n  Organizing files...\n${RESET}"

organize_files "$folder_input"

# Display summary
echo ""
echo -e "${CYAN}=======================================================${RESET}"
echo -e "${GREEN}${BOLD}  SUCCESS! $moved_count files organized.${RESET}"
echo -e "${CYAN}=======================================================${RESET}"
echo -e "${GRAY}\n  Thank you for using File Organizer!${RESET}"