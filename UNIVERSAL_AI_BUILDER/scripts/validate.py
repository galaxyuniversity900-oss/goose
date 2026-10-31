#!/usr/bin/env python3
"""Static validation for Universal AI Builder YAML and recipe contracts."""
from __future__ import annotations
import pathlib
import sys

BASE = pathlib.Path(__file__).resolve().parents[1]
try:
    import yaml  # type: ignore
except ImportError:
    print("ERROR: PyYAML required: python -m pip install PyYAML")
    raise SystemExit(2)

errors: list[str] = []
yaml_files = sorted(BASE.rglob("*.yaml")) + sorted(BASE.rglob("*.yml"))
for path in yaml_files:
    try:
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
    except Exception as exc:
        errors.append(f"{path.relative_to(BASE)}: invalid YAML: {exc}")
        continue
    if path.parent.name == "recipes":
        if not isinstance(data, dict):
            errors.append(f"{path.relative_to(BASE)}: recipe must be a mapping")
            continue
        for key in ("title", "description"):
            if not isinstance(data.get(key), str) or not data[key].strip():
                errors.append(f"{path.relative_to(BASE)}: missing/empty {key}")
        if not (data.get("instructions") or data.get("prompt")):
            errors.append(f"{path.relative_to(BASE)}: requires instructions or prompt")
        if "extensions" in data and not isinstance(data["extensions"], list):
            errors.append(f"{path.relative_to(BASE)}: recipe extensions must be a list")
    if path.name in {"config.example.yaml", "extensions.example.yaml", "init-config.yaml"}:
        if not isinstance(data, dict):
            errors.append(f"{path.relative_to(BASE)}: config must be a mapping")
print(f"Scanned {len(yaml_files)} YAML files.")
if errors:
    for error in errors: print("ERROR:", error)
    raise SystemExit(1)
print("PASS: YAML syntax and basic Goose recipe/config contracts.")
print("NOTE: This does not replace Goose runtime/schema validation.")
