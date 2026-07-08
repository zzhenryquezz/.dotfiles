#!/bin/bash

set -e

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Error: not inside a git repository"
    exit 1
fi

STAGED=$(git diff --cached --name-only)
UNSTAGED=$(git diff --name-only)

if [ -z "$STAGED" ] && [ -z "$UNSTAGED" ]; then
    echo "No changes to commit"
    exit 1
fi

# Use staged diff; fall back to unstaged
DIFF=$(git diff --cached)
[ -z "$DIFF" ] && DIFF=$(git diff)

PROMPT_FILE=$(mktemp)
trap 'rm -f "$PROMPT_FILE"' EXIT

cat > "$PROMPT_FILE" << 'PROMPT_EOF'
You are a git commit message generator. Based on the following git diff, generate exactly 5 commit message options following conventional commits format (feat, fix, chore, docs, refactor, style, test, etc.).

Output ONLY the options in this EXACT format — no numbering, no extra text before or after:

---
Subject: <type(scope): short subject, max 72 chars>
Description: <what changed and why, 1-2 sentences>
---
Subject: <type(scope): short subject, max 72 chars>
Description: <what changed and why, 1-2 sentences>
---
Subject: <type(scope): short subject, max 72 chars>
Description: <what changed and why, 1-2 sentences>
---
Subject: <type(scope): short subject, max 72 chars>
Description: <what changed and why, 1-2 sentences>
---
Subject: <type(scope): short subject, max 72 chars>
Description: <what changed and why, 1-2 sentences>

Git diff:
PROMPT_EOF

echo "$DIFF" | head -400 >> "$PROMPT_FILE"

echo "⏳ Generating commit message options..."

RESPONSE=$(gh copilot -- -p "$(cat "$PROMPT_FILE")" --model cheats --no-tools 2>/dev/null \
    || gh copilot -- -p "$(cat "$PROMPT_FILE")" --model cheats 2>/dev/null)

# Parse Subject/Description pairs from the response
SUBJECTS=()
DESCRIPTIONS=()

while IFS= read -r line; do
    if [[ "$line" == Subject:* ]]; then
        SUBJECTS+=("${line#Subject: }")
    elif [[ "$line" == Description:* ]]; then
        DESCRIPTIONS+=("${line#Description: }")
    fi
done <<< "$RESPONSE"

NUM_OPTIONS=${#SUBJECTS[@]}

if [ "$NUM_OPTIONS" -eq 0 ]; then
    echo "Error: failed to parse options from response."
    echo ""
    echo "Raw response:"
    echo "$RESPONSE"
    exit 1
fi

# Display options
echo ""
echo "Select a commit message:"
echo ""

for i in "${!SUBJECTS[@]}"; do
    echo "  $((i+1)). ${SUBJECTS[$i]}"
    echo "     ${DESCRIPTIONS[$i]}"
    echo ""
done

read -rp "Enter option number (1-$NUM_OPTIONS): " CHOICE

if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt "$NUM_OPTIONS" ]; then
    echo "Invalid choice"
    exit 1
fi

IDX=$((CHOICE - 1))
SUBJECT="${SUBJECTS[$IDX]}"
DESCRIPTION="${DESCRIPTIONS[$IDX]}"

echo ""
echo "Selected:"
echo "  Subject: $SUBJECT"
echo "  Description: $DESCRIPTION"
echo ""

read -rp "Edit the message before committing? (y/N): " EDIT_CHOICE

COMMIT_FILE=$(mktemp /tmp/git-commit-XXXXXX.txt)
trap 'rm -f "$PROMPT_FILE" "$COMMIT_FILE"' EXIT

printf '%s\n\n%s\n' "$SUBJECT" "$DESCRIPTION" > "$COMMIT_FILE"

if [[ "$EDIT_CHOICE" =~ ^[Yy]$ ]]; then
    ${EDITOR:-vi} "$COMMIT_FILE"
fi

# Read back subject (line 1) and description (lines 3+)
FINAL_SUBJECT=$(sed -n '1p' "$COMMIT_FILE")
FINAL_DESC=$(sed -n '3,$p' "$COMMIT_FILE" | sed '/^[[:space:]]*$/d')

if [ -z "$FINAL_SUBJECT" ]; then
    echo "Commit message is empty, aborting"
    exit 1
fi

if [ -n "$STAGED" ]; then
    COMMIT_ARGS=()
else
    echo "No staged changes detected. Staging all changes (git add -A)..."
    git add -A
fi

if [ -z "$FINAL_DESC" ]; then
    git commit -m "$FINAL_SUBJECT"
else
    git commit -m "$FINAL_SUBJECT" -m "$FINAL_DESC"
fi

echo ""
echo "✅ Committed successfully!"
