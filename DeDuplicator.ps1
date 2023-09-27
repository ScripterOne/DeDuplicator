# Author: EverStaR and GPTChat V4.5 AI
# Date: 9/27/2023
# Version: 1.0
# Comments and questions to: scripter@everstar.com

# Function to write to Error Log CSV
function WriteToErrorLog ($errorType, $filePath, $time, $date) {
    $errorLogPath = "DeDupeErrorLog.csv"
    if (-not (Test-Path $errorLogPath)) {
        Add-Content $errorLogPath "Error Type,File Path,Time,Date"
    }
    Add-Content $errorLogPath "$errorType,$filePath,$time,$date"
}

# Display warning message
Write-Host "WARNING: This script scans a directory for duplicate files based on their hash and name, and moves them to a 'DUPLICATES' folder. Proceed with caution." -ForegroundColor Red
Read-Host "Press any key to continue..."
Clear-Host

# Initialize error count
$errorCount = 0

# Check for command-line argument for directory, else prompt user
if ($args.Count -eq 0) {
    $directory = Read-Host "Enter the root directory to scan for duplicates"
} else {
    $directory = $args[0]
}

# Validate the provided directory path
if (-Not (Test-Path $directory)) {
    Write-Host "Invalid directory path. Exiting."
    Exit
}

# Initialize hash tables for file hashes and file names
$hashTable = @{}
$nameTable = @{}

# Initialize variables for CSV details and counters
$csvRowLimit = 250000
$csvRowCount = 0
$csvFileIndex = 1
$csvFilePath = "duplicate_files_$csvFileIndex.csv"
$duplicateCount = 0
$processedFiles = 0

# Create a folder named 'DUPLICATES' if it doesn't exist
$duplicatesDir = Join-Path $directory "DUPLICATES"
if (-Not (Test-Path $duplicatesDir)) {
    New-Item -Path $duplicatesDir -ItemType Directory | Out-Null
}

# Initialize a flag for header writing
$headerWritten = $false

# Function to write to CSV
function WriteToCsv ($fileName, $origDate, $dupDate, $origSize, $dupSize, $fileHash) {
    if (-not $script:headerWritten) {
        Add-Content $csvFilePath "File Name,Original Date,Duplicate Date,Original Size,Duplicate Size,Common File Hash"
        $script:headerWritten = $true
    }
    Add-Content $csvFilePath "$fileName,$origDate,$dupDate,$origSize,$dupSize,$fileHash"
    $script:csvRowCount++
    if ($script:csvRowCount -ge $csvRowLimit) {
        $script:csvRowCount = 0
        $script:csvFileIndex++
        $csvFilePath = "duplicate_files_$csvFileIndex.csv"
        $script:headerWritten = $false
    }
}

# Function to calculate SHA-256 hash of a file
function Get-FileHash256 ($filePath) {
    $hasher = [System.Security.Cryptography.HashAlgorithm]::Create('SHA-256')
    $stream = New-Object System.IO.FileStream($filePath, [System.IO.FileMode]::Open)
    $hash = $hasher.ComputeHash($stream)
    $stream.Close()
    return [BitConverter]::ToString($hash) -replace '-'
}

# Start scanning files and identifying duplicates
$files = Get-ChildItem -Path $directory -File -Recurse

# Initialize the progress bar
$totalFiles = $files.Count
$progress = @{
    Activity = "Scanning for duplicates..."
    Status = "Processing"
    PercentComplete = 0
}

foreach ($file in $files) {
    try {
        $processedFiles++
        $progress["PercentComplete"] = ($processedFiles / $totalFiles) * 100
        Write-Progress @progress

        $filePath = $file.FullName
        $fileName = $file.Name
        $fileSize = $file.Length
        $fileHash = Get-FileHash256 -filePath $filePath

        # Check for duplicate based on file hash
        if ($hashTable.ContainsKey($fileHash)) {
            $duplicateCount++
            $existingFile = $hashTable[$fileHash]
            $destinationPath = Join-Path $duplicatesDir ("hash_" + $fileName)
            if (Test-Path $existingFile) {
                Move-Item -Path $existingFile -Destination $destinationPath -Force
            } else {
                WriteToErrorLog -errorType "FileNotFound" -filePath $existingFile -time (Get-Date -Format "HH:mm:ss") -date (Get-Date -Format "yyyy-MM-dd")
                $errorCount++
            }
            WriteToCsv -fileName $fileName -origDate $file.LastWriteTime -dupDate $file.LastWriteTime -origSize $fileSize -dupSize $fileSize -fileHash $fileHash
        } else {
            $hashTable[$fileHash] = $filePath
        }

    } catch {
        $errorType = $_.Exception.GetType().FullName
        $filePath = $file.FullName
        $time = Get-Date -Format "HH:mm:ss"
        $date = Get-Date -Format "yyyy-MM-dd"
        WriteToErrorLog -errorType $errorType -filePath $filePath -time $time -date $date
        $errorCount++
    }
}

Write-Host "Processing complete. $duplicateCount duplicates found and moved."
Write-Host "Total errors logged: $errorCount. Check DeDupeErrorLog.csv for details."
