"""Fail fast if unresolved Git merge markers exist in tracked text files."""

from pathlib import Path
import subprocess
import sys

MARKERS = ("<<<<<<<", "=======", ">>>>>>>")


def tracked_files():
    result = subprocess.run(
        ["git", "ls-files"],
        capture_output=True,
        text=True,
        check=True,
    )
    return [Path(line) for line in result.stdout.splitlines() if line.strip()]


def is_likely_text(path: Path) -> bool:
    suffix = path.suffix.lower()
    return suffix in {".py", ".md", ".txt", ".json", ".yml", ".yaml", ".toml", ".ini", ".cfg", ".bat"}


def find_conflicts(path: Path):
    try:
        lines = path.read_text(encoding="utf-8").splitlines()
    except UnicodeDecodeError:
        return []

    hits = []
    for idx, line in enumerate(lines, start=1):
        if any(line.startswith(marker) for marker in MARKERS):
            hits.append((idx, line.strip()))
    return hits


def main() -> int:
    problems = []
    for path in tracked_files():
        if not is_likely_text(path) or not path.exists():
            continue
        hits = find_conflicts(path)
        if hits:
            problems.append((path, hits))

    if not problems:
        print("No unresolved merge markers found.")
        return 0

    print("Unresolved merge markers detected:\n")
    for path, hits in problems:
        for line_no, marker in hits:
            print(f"{path}:{line_no}: {marker}")

    print("\nResolve the files above, then run this check again.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
