$ErrorActionPreference = "Stop"

$Git = "D:\Git\cmd\git.exe"
$Repo = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "========================================"
Write-Host " Publish measurement-demo to GitHub"
Write-Host "========================================"
Write-Host ""

if (!(Test-Path -LiteralPath $Git)) {
  Write-Host "Git not found: $Git" -ForegroundColor Red
  Write-Host "Please check your Git install path."
  Read-Host "Press Enter to exit"
  exit 1
}

Set-Location -LiteralPath $Repo

Write-Host "Repository:"
Write-Host $Repo
Write-Host ""

Write-Host "Current status:"
& $Git status --short --branch
Write-Host ""

Write-Host "Staging all changes..."
& $Git add .

Write-Host ""
Write-Host "Checking whether a new commit is needed..."
& $Git diff --cached --quiet
$HasStagedChanges = $LASTEXITCODE -ne 0

if ($HasStagedChanges) {
  $CommitMessage = "update measurement demo"
  Write-Host "Creating commit: $CommitMessage"
  & $Git commit -m $CommitMessage
} else {
  Write-Host "No new file changes to commit."
}

Write-Host ""
Write-Host "Pushing to GitHub..."
& $Git push

Write-Host ""
Write-Host "========================================"
Write-Host " Publish finished"
Write-Host "========================================"
Write-Host ""
Write-Host "GitHub Pages:"
Write-Host "https://linmh0425-lang.github.io/measurement-demo/"
Write-Host ""
Write-Host "If the website is not updated yet, wait 1-3 minutes and refresh."
Write-Host ""
Read-Host "Press Enter to close"
