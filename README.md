# DeDuplicator
This is a set of file management scripts for scanning hard drive after backup and look for duplicate files by file hash and file name.

# DeDuplicator PowerShell Script

## Author
- EverStaR
- GPTChat V4.5 AI

## Date
- 9/27/2023

## Version
- 1.0

## Contact
- For comments and questions, please reach out to [scripter@everstar.com](mailto:scripter@everstar.com)

---

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Requirements](#requirements)
4. [Usage](#usage)
5. [Error Handling and Logging](#error-handling-and-logging)
6. [Preparation](#preparation)
7. [Contributing](#contributing)
8. [License](#license)

---

## Introduction
The DeDuplicator PowerShell script is designed to scan a directory for duplicate files based on their hash and name. It moves the duplicates to a 'DUPLICATES' folder and logs the details in a CSV file. This script is ideal for cleaning up storage spaces and organizing files.

## Features
- Scans a directory recursively for duplicate files.
- Uses SHA-256 hashing algorithm to identify duplicates.
- Moves duplicates to a 'DUPLICATES' folder.
- Logs duplicate details in a CSV file.
- Logs errors and warnings in a separate CSV file.
- User-friendly interface with progress bar and summary.
- Robust error handling.

## Requirements
- Windows OS
- PowerShell 5.1 or higher

## Usage
1. Download the script from this repository.
2. Open PowerShell as an administrator.
3. Navigate to the directory where the script is located.
4. Run the script using `.\DeDuplicator.ps1` or provide a directory as an argument `.\DeDuplicator.ps1 "C:\Your\Directory"`.

## Error Handling and Logging
- The script logs errors and warnings in a file named `DeDupeErrorLog.csv`.
- Each row in the CSV file contains details like error type, file path, time, and date.

## Preparation
Before running this script, it's a good idea to backup your files. You can use the [Backup Utility](https://github.com/ScripterOne/BackupUtility) available on GitHub to create a backup of your important files.

## Contributing
If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.

---

For more information, please contact [scripter@everstar.com](mailto:scripter@everstar.com).
