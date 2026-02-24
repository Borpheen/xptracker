# BF6 Rank Tracker

A lightweight desktop app (PySide6) that tracks a Battlefield 6 player's rank and refreshes automatically every 10 minutes.

## Features
- Track a player by name
- Shows the player's rank badge image and rank number overlay
- Auto-refresh countdown (10-minute interval) and live status indicator
- Error messaging for not found / timeout / no connection
- Windows-friendly single-file entry point (`bf6_rank_tracker.py`)

## Requirements
- Python 3.10+
- `pip`

Install dependencies:

```bash
pip install -r requirements.txt
```

## Run the app
From the project directory:

```bash
python bf6_rank_tracker.py
```

## Windows quick start
Open Command Prompt in this folder and run:

```bat
py -m pip install -r requirements.txt
py bf6_rank_tracker.py
```

## Notes
- The app fetches profile data from `api.gametools.network`.
- Internet access is required for profile and image loading.

## Troubleshooting

If you see an error like this:

```text
IndentationError ... <<<<<<< HEAD
```

it means the file still has unresolved Git merge-conflict markers.

Fix steps:

```bash
# inspect conflict markers
rg -n "<<<<<<<|=======|>>>>>>>" README.md bf6_rank_tracker.py

# if found, resolve and remove markers, then verify
python -m py_compile bf6_rank_tracker.py
python -m tabnanny bf6_rank_tracker.py
```

After markers are removed, the app should run normally.

Before committing or opening a PR, you can run:

```bash
python check_merge_conflicts.py
```

This catches unresolved merge markers early.


## Development checks

Before pushing, run:

```bash
python check_merge_conflicts.py
python -m py_compile bf6_rank_tracker.py
python -m tabnanny bf6_rank_tracker.py
```

A GitHub Actions workflow also runs these checks on pull requests.

## Resolving recurring PR conflicts (Windows)

If GitHub shows conflicts in `README.md` and `bf6_rank_tracker.py`, you can run:

```bat
resolve_conflicts_keep_branch.bat codex/improve-ui/ux-and-code-organization-3gr4oq
```

This script fetches `origin/main`, merges, keeps your branch version for the two known files, runs checks, and creates a merge-resolution commit.

