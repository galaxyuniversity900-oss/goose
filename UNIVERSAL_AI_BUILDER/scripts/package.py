#!/usr/bin/env python3
"""Build a portable ZIP of the Universal AI Builder configuration layer."""
from __future__ import annotations
import argparse
import hashlib
import json
import pathlib
import zipfile

ROOT = pathlib.Path(__file__).resolve().parents[1]
DEFAULT_OUT = ROOT / "dist" / "universal-ai-builder-config-pack.zip"
EXCLUDED_PARTS = {"dist", "__pycache__"}
EXCLUDED_SUFFIXES = {".pyc", ".bak"}

def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=pathlib.Path, default=DEFAULT_OUT)
    args = parser.parse_args()
    output = args.output.resolve()
    output.parent.mkdir(parents=True, exist_ok=True)

    files = []
    for path in sorted(ROOT.rglob("*")):
        if not path.is_file() or path.resolve() == output:
            continue
        rel = path.relative_to(ROOT)
        if any(part in EXCLUDED_PARTS for part in rel.parts):
            continue
        if path.suffix in EXCLUDED_SUFFIXES:
            continue
        files.append((path, rel.as_posix()))

    manifest = []
    with zipfile.ZipFile(output, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for path, rel in files:
            data = path.read_bytes()
            archive.writestr("UNIVERSAL_AI_BUILDER/" + rel, data)
            manifest.append({
                "path": rel,
                "size": len(data),
                "sha256": hashlib.sha256(data).hexdigest(),
            })
        archive.writestr(
            "UNIVERSAL_AI_BUILDER/MANIFEST.json",
            json.dumps({"format": 1, "files": manifest}, indent=2) + "\n",
        )

    with zipfile.ZipFile(output, "r") as archive:
        bad = archive.testzip()
        if bad:
            raise RuntimeError(f"ZIP integrity check failed at {bad}")
    print(f"Created: {output}")
    print(f"Files: {len(files)}")
    print(f"Bytes: {output.stat().st_size}")
    print("ZIP integrity: PASS")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
