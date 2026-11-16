
import os
import shutil
import time

# Terminal colors (ANSI)
CYAN = "\033[96m"
GREEN = "\033[92m"
YELLOW = "\033[93m"
RED = "\033[91m"
WHITE = "\033[97m"
GRAY = "\033[90m"
RESET = "\033[0m"
BOLD = "\033[1m"


def clear_screen():
    os.system("cls" if os.name == "nt" else "clear")


def display_header():
    print(CYAN + BOLD + r"""

        ███████╗██╗██╗     ███████╗███████╗
        ██╔════╝██║██║     ██╔════╝██╔════╝
        █████╗  ██║██║     █████╗  ███████╗
        ██╔══╝  ██║██║     ██╔══╝  ╚════██║
        ██║     ██║███████╗███████╗███████║
        ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝        
    """ + RESET)

    print(CYAN + "=" * 55 + RESET)
    print(WHITE + BOLD + "         FILE ORGANIZER         by: k.virakboth" + RESET)
    print(CYAN + "=" * 55 + RESET)

    print(GRAY + "       Organize your files automatically" + RESET)
    print()
    print(WHITE + "  [-] Photos            JPG, PNG, JPEG")
    print(WHITE + "  [-] Documents         DOC, PDF, XLSX")
    print(WHITE + "  [-] Applications      EXE, MSI, APK")
    print(WHITE + "  [-] Others            Other file types")
    print(CYAN + "-" * 55 + RESET)


def organize_files(folder_input):
    moved_count = 0

    for file in os.listdir(folder_input):
        file_path = os.path.join(folder_input, file)

        if not os.path.isfile(file_path):
            continue

        extension = os.path.splitext(file)[1].lower()

        if extension in [".jpg", ".png", ".jpeg"]:
            folder_name = "Photos"
        elif extension in [".doc", ".pdf", ".xlsx"]:
            folder_name = "Documents"
        elif extension in [".exe", ".msi", ".apk"]:
            folder_name = "Applications"
        else:
            folder_name = "Others"

        new_folder = os.path.join(folder_input, folder_name)
        os.makedirs(new_folder, exist_ok=True)

        shutil.move(file_path, new_folder)

        moved_count += 1
        print(GREEN + f"  [+] {file} -> {folder_name}" + RESET)

    return moved_count


# Main application
clear_screen()
display_header()

try:
    print(GRAY + "  [INPUT INSTRUCTIONS]" + RESET)
    print(GRAY + "  Enter the full folder path you want to organize." + RESET)
    print(GRAY + "  Example: C:\\Users\\YourName\\Downloads" + RESET)


    folder_input = input(CYAN + "\n  Enter folder path => " + WHITE).strip().strip('"')

    if not os.path.isdir(folder_input):
        raise NotADirectoryError

    print(YELLOW + "\n  Organizing files...\n" + RESET)

    total = organize_files(folder_input)

    print()
    print(CYAN + "=" * 55 + RESET)
    print(GREEN + BOLD + f"  SUCCESS! {total} files organized." + RESET)
    print(CYAN + "=" * 55 + RESET)

except FileNotFoundError:
    print(RED + "\n  [ERROR] Folder or file not found!" + RESET)
except NotADirectoryError:
    print(RED + "\n  [ERROR] Invalid directory path!" + RESET)
except PermissionError:
    print(RED + "\n  [ERROR] Permission denied!" + RESET)
except KeyboardInterrupt:
    print(RED + "\n  [CANCELLED] Operation stopped by user!" + RESET)
except shutil.Error as e:
    print(RED + f"\n  [ERROR] File operation failed: {e}" + RESET)
except OSError as e:
    print(RED + f"\n  [ERROR] System error: {e}" + RESET)
except Exception as e:
    print(RED + f"\n  [ERROR] Unexpected error: {e}" + RESET)
finally:
    print(GRAY + "\n  Thank you for using File Organizer!" + RESET)