#!/usr/bin/env bash
set -euo pipefail

BRANCH="${1:-}"
if [[ -z "$BRANCH" ]]; then
  echo "Usage: ./resolve_conflicts_keep_branch.sh <branch-name>"
  exit 1
fi

echo "[1/6] Fetching latest refs..."
git fetch origin

echo "[2/6] Checking out $BRANCH..."
git checkout "$BRANCH"

echo "[3/6] Merging origin/main into $BRANCH..."
if ! git merge origin/main; then
  echo "Merge reported conflicts. Applying keep-branch strategy for known files..."
fi

echo "[4/6] Resolving known conflict files by keeping current branch version..."
git checkout --ours README.md bf6_rank_tracker.py
git add README.md bf6_rank_tracker.py

echo "[5/6] Validating repository checks..."
python check_merge_conflicts.py
python -m py_compile bf6_rank_tracker.py
python -m tabnanny bf6_rank_tracker.py

echo "[6/6] Committing merge resolution..."
git commit -m "Resolve main conflicts; keep branch versions for README and bf6_rank_tracker"

echo "Done. Push with:"
echo "  git push origin $BRANCH"
