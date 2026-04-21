#!/bin/bash
# Initialize planning files for a new session
# Usage: ./init-session.sh [task-title]

set -e

TASK_TITLE="${1:-task}"
DATE=$(date +%Y%m%d)

# Replace spaces with underscores, strip special characters
SAFE_TITLE=$(echo "$TASK_TITLE" | tr ' ' '_' | tr -cd '[:alnum:]_')

TASK_PLAN_FILE=".idea/task_plan_${SAFE_TITLE}_${DATE}.md"
FINDINGS_FILE=".idea/findings_${SAFE_TITLE}_${DATE}.md"
PROGRESS_FILE=".idea/progress_${SAFE_TITLE}_${DATE}.md"

# Ensure .idea directory exists
mkdir -p .idea

echo "Initializing planning files for: $TASK_TITLE"

# Create task_plan file if it doesn't exist
if [ ! -f "$TASK_PLAN_FILE" ]; then
    cat > "$TASK_PLAN_FILE" << 'EOF'
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
EOF
    echo "Created $TASK_PLAN_FILE"
else
    echo "$TASK_PLAN_FILE already exists, skipping"
fi

# Create findings file if it doesn't exist
if [ ! -f "$FINDINGS_FILE" ]; then
    cat > "$FINDINGS_FILE" << 'EOF'
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
EOF
    echo "Created $FINDINGS_FILE"
else
    echo "$FINDINGS_FILE already exists, skipping"
fi

# Create progress file if it doesn't exist
if [ ! -f "$PROGRESS_FILE" ]; then
    cat > "$PROGRESS_FILE" << EOF
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
EOF
    echo "Created $PROGRESS_FILE"
else
    echo "$PROGRESS_FILE already exists, skipping"
fi

echo ""
echo "Planning files initialized!"
echo "Directory: .idea/"
echo "Files: $TASK_PLAN_FILE, $FINDINGS_FILE, $PROGRESS_FILE"
