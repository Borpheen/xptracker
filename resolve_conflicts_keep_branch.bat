@echo off
setlocal

if "%~1"=="" (
  echo Usage: resolve_conflicts_keep_branch.bat ^<branch-name^>
  echo Example: resolve_conflicts_keep_branch.bat codex/improve-ui/ux-and-code-organization-3gr4oq
  exit /b 1
)

set BRANCH=%~1

echo [1/6] Fetching latest refs...
git fetch origin || exit /b 1

echo [2/6] Checking out %BRANCH%...
git checkout %BRANCH% || exit /b 1

echo [3/6] Merging origin/main into %BRANCH%...
git merge origin/main || (
  echo Merge reported conflicts. Applying keep-branch strategy for known files...
)

echo [4/6] Resolving known conflict files by keeping current branch version...
git checkout --ours README.md bf6_rank_tracker.py || exit /b 1
git add README.md bf6_rank_tracker.py || exit /b 1

echo [5/6] Validating repository checks...
python check_merge_conflicts.py || exit /b 1
python -m py_compile bf6_rank_tracker.py || exit /b 1
python -m tabnanny bf6_rank_tracker.py || exit /b 1

echo [6/6] Committing merge resolution...
git commit -m "Resolve main conflicts; keep branch versions for README and bf6_rank_tracker" || exit /b 1

echo Done. Push with:
echo   git push origin %BRANCH%
endlocal
