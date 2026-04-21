# Initialize planning files for a new session
# Usage: .\init-session.ps1 [task-title]

param(
    [string]$TaskTitle = "task"
)

$DATE = Get-Date -Format "yyyyMMdd"

# Replace spaces with underscores, strip special characters
$SafeTitle = $TaskTitle -replace '\s', '_' -replace '[^\w]', ''

$TaskPlanFile = ".idea\task_plan_${SafeTitle}_${DATE}.md"
$FindingsFile = ".idea\findings_${SafeTitle}_${DATE}.md"
$ProgressFile = ".idea\progress_${SafeTitle}_${DATE}.md"

# Ensure .idea directory exists
if (-not (Test-Path ".idea")) {
    New-Item -ItemType Directory -Path ".idea" | Out-Null
}

Write-Host "Initializing planning files for: $TaskTitle"

# Create task_plan file if it doesn't exist
if (-not (Test-Path $TaskPlanFile)) {
    @"
# Task Plan: [Brief Description]

## Goal
[One sentence describing the end state]

## Current Phase
Phase 1

## Phases

### Phase 1: Requirements & Discovery
- [ ] Understand user intent
- [ ] Identify constraints
- [ ] Document in .idea/findings_*.md
- **Status:** in_progress

### Phase 2: Planning & Structure
- [ ] Define approach
- [ ] Create project structure
- **Status:** pending

### Phase 3: Implementation
- [ ] Execute the plan
- [ ] Write to files before executing
- **Status:** pending

### Phase 4: Testing & Verification
- [ ] Verify requirements met
- [ ] Document test results in .idea/progress_*.md
- **Status:** pending

### Phase 5: Delivery
- [ ] Review outputs
- [ ] Deliver to user
- **Status:** pending

## Decisions Made
| Decision | Rationale |
|----------|-----------|

## Errors Encountered
| Error | Resolution |
|-------|------------|
"@ | Out-File -FilePath $TaskPlanFile -Encoding UTF8
    Write-Host "Created $TaskPlanFile"
} else {
    Write-Host "$TaskPlanFile already exists, skipping"
}

# Create findings file if it doesn't exist
if (-not (Test-Path $FindingsFile)) {
    @"
# Findings & Decisions

## Requirements
-

## Research Findings
-

## Technical Decisions
| Decision | Rationale |
|----------|-----------|

## Issues Encountered
| Issue | Resolution |
|-------|------------|

## Resources
-
"@ | Out-File -FilePath $FindingsFile -Encoding UTF8
    Write-Host "Created $FindingsFile"
} else {
    Write-Host "$FindingsFile already exists, skipping"
}

# Create progress file if it doesn't exist
if (-not (Test-Path $ProgressFile)) {
    @"
# Progress Log

## Session: $DATE

### Current Status
- **Phase:** 1 - Requirements & Discovery
- **Started:** $DATE

### Actions Taken
-

### Test Results
| Test | Expected | Actual | Status |
|------|----------|--------|--------|

### Errors
| Error | Resolution |
|-------|------------|
"@ | Out-File -FilePath $ProgressFile -Encoding UTF8
    Write-Host "Created $ProgressFile"
} else {
    Write-Host "$ProgressFile already exists, skipping"
}

Write-Host ""
Write-Host "Planning files initialized!"
Write-Host "Directory: .idea\"
Write-Host "Files: $TaskPlanFile, $FindingsFile, $ProgressFile"
