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
