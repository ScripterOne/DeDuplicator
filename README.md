# DeDuplicator
This is a set of file management scripts for scanning hard drive after backup and look for duplicate files by file hash and file name.

DeDuplicator PowerShell Script
Author
EverStaR
GPTChat V4.5 AI
Date
9/27/2023
Version
1.0
Contact
For comments and questions, please reach out to scripter@everstar.com
Table of Contents
Introduction
Features
Requirements
Usage
Error Handling and Logging
Preparation
Contributing
License
Introduction
The DeDuplicator PowerShell script is designed to scan a directory for duplicate files based on their hash and name. It moves the duplicates to a 'DUPLICATES' folder and logs the details in a CSV file. This script is ideal for cleaning up storage spaces and organizing files.

Features
Scans a directory recursively for duplicate files.
Uses SHA-256 hashing algorithm to identify duplicates.
Moves duplicates to a 'DUPLICATES' folder.
Logs duplicate details in a CSV file.
Logs errors and warnings in a separate CSV file.
User-friendly interface with progress bar and summary.
Robust error handling.
Requirements
Windows OS
PowerShell 5.1 or higher
Usage
Download the script from this repository.
Open PowerShell as an administrator.
Navigate to the directory where the script is located.
Run the script using .\DeDuplicator.ps1 or provide a directory as an argument .\DeDuplicator.ps1 "C:\Your\Directory".
Error Handling and Logging
The script logs errors and warnings in a file named DeDupeErrorLog.csv.
Each row in the CSV file contains details like error type, file path, time, and date.
Preparation
Before running this script, it's a good idea to backup your files. You can use the Backup Utility available on GitHub to create a backup of your important files.

Contributing
If you find any bugs or have suggestions for improvements, please open an issue or submit a pull request.

License
This project is licensed under the MIT License. See the LICENSE.md file for details.

For more information, please contact scripter@everstar.com.
