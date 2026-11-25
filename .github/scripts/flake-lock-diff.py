#!/usr/bin/env python3
"""Print a Markdown summary of input changes between two flake.lock files."""

import json
import sys
from datetime import datetime, timezone

MARKER = "<!-- flake-lock-diff -->"


def load(path):
    try:
        with open(path) as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return {"root": "root", "nodes": {"root": {}}}


def walk(lock):
    """Map each input path (e.g. `home-manager/nixpkgs`) to its node, skipping follows."""
    nodes = lock["nodes"]
    result = {}

    def visit(node_name, prefix, seen):
        for name, ref in nodes[node_name].get("inputs", {}).items():
            # A list is a `follows` to another input, which is listed under its own path
            if not isinstance(ref, str) or ref in seen:
                continue
            path = f"{prefix}{name}"
            result[path] = nodes[ref]
            visit(ref, f"{path}/", seen | {ref})

    visit(lock["root"], "", {lock["root"]})
    return result


def repo_url(locked):
    if locked.get("type") == "github":
        return f"https://github.com/{locked['owner']}/{locked['repo']}"
    return None


def describe(node):
    locked = node.get("locked", {})
    rev = locked.get("rev")
    date = ""
    if "lastModified" in locked:
        date = datetime.fromtimestamp(locked["lastModified"], timezone.utc).strftime("%Y-%m-%d")
    if not rev:
        return date or locked.get("narHash", "")[:15]
    url = repo_url(locked)
    short = f"`{rev[:7]}`"
    if url:
        short = f"[{short}]({url}/commit/{rev})"
    return f"{date} {short}".strip()


def compare(old, new):
    old_locked, new_locked = old.get("locked", {}), new.get("locked", {})
    url = repo_url(new_locked)
    if url and repo_url(old_locked) == url and old_locked.get("rev") and new_locked.get("rev"):
        return f"[compare]({url}/compare/{old_locked['rev']}...{new_locked['rev']})"
    return ""


def rows(paths, before, after):
    lines = ["| Input | Before | After | |", "| --- | --- | --- | --- |"]
    for path in paths:
        old, new = before.get(path), after.get(path)
        lines.append(
            "| `{}` | {} | {} | {} |".format(
                path,
                describe(old) if old else "_added_",
                describe(new) if new else "_removed_",
                compare(old, new) if old and new else "",
            )
        )
    return lines


def main(base_path, head_path):
    before, after = walk(load(base_path)), walk(load(head_path))
    changed = sorted(
        path
        for path in before.keys() | after.keys()
        if before.get(path, {}).get("locked") != after.get(path, {}).get("locked")
    )
    direct = [p for p in changed if "/" not in p]
    nested = [p for p in changed if "/" in p]

    out = [MARKER, "### flake.lock updates", ""]
    if not changed:
        out.append("No input changes.")
    if direct:
        out += rows(direct, before, after)
    if nested:
        out += ["", f"<details><summary>Nested inputs ({len(nested)})</summary>", ""]
        out += rows(nested, before, after)
        out += ["", "</details>"]
    print("\n".join(out))


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
