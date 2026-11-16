# File Organizer

A simple command-line tool that automatically organizes files into categorized folders based on their file extensions.

Built with **Python** and **Windows Batch Script**, this project helps keep your Downloads folder clean and organized.

## Features

- **Automatic File Sorting** – Organizes files based on their extensions.
- **Folder Creation** – Automatically creates destination folders if they don't exist.
- **Custom Directory** – Allows users to specify which folder to organize.
- **Error Handling** – Handles invalid paths, permission issues, and unexpected errors.
- **Terminal Interface** – Clean CLI interface with colored output and status messages.
- **No External Dependencies** – Python version uses only built-in libraries.

## File Categories

| Category | Supported Extensions |
|---|---|
| Photos | `.jpg`, `.jpeg`, `.png` |
| Documents | `.doc`, `.pdf`, `.xlsx` |
| Applications | `.exe`, `.msi`, `.apk` |
| Others | All other file types |

## Technologies Used

- Python 3
- Windows Batch Script (`.bat`)
- Python Standard Libraries:
  - `os`
  - `shutil`
  - `time`

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/LlightBoth/File-Organizer.git
```

### 2. Navigate to the project directory

```bash
cd File-Organizer
```

### 3. Run the Python version

```bash
python file_organizer_python.py
```

### 4. Run the Batch version

Double-click `file_organizer_win.bat` or execute:

```cmd
file_organizer_win.bat
```

## Usage

1. Run the application.
2. Enter the full path of the folder you want to organize.
3. The program scans the files in the selected folder.
4. Files are moved into their corresponding categories.
5. A completion message displays the number of organized files.

**Example input:**

```text
C:\Users\YourName\Downloads
```

**Example directory structure:**

Before:

```text
Downloads/
├── photo.jpg
├── resume.pdf
├── setup.exe
├── wallpaper.png
└── music.mp3
```

After:

```text
Downloads/
├── Photos/
│   ├── photo.jpg
│   └── wallpaper.png
├── Documents/
│   └── resume.pdf
├── Applications/
│   └── setup.exe
└── Others/
    └── music.mp3
```

## Important Notes

- Files are moved, not copied.
- Existing folders are reused.
- Only files in the selected directory are organized; subdirectories are skipped.
- Test the application with a temporary folder before organizing important files.
- The Batch version is designed for Windows.
