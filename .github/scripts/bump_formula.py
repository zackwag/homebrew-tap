"""Bump a formula or cask to a new release in place.

Rewrites the version in the top-level `url` and `version` lines and replaces
the top-level `sha256`; everything else in the file (caveats, tests,
resources, hand edits) is left alone. "Top-level" means indented exactly two
spaces, which keeps `resource` blocks (indented four) untouched.

Usage: bump_formula.py PATH VERSION SHA256
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

TOP_LEVEL_VERSION = re.compile(r'^  version "([^"]+)"$', re.M)
TOP_LEVEL_URL_VERSION = re.compile(r'^  url "[^"]*/v(\d+(?:\.\d+)*)[/."]', re.M)
TOP_LEVEL_SHA256 = re.compile(r'^  sha256 "[0-9a-f]{64}"$', re.M)
VERSION = re.compile(r"^\d+(?:\.\d+)*(?:[-+][0-9A-Za-z.-]+)?$")
SHA256 = re.compile(r"^[0-9a-f]{64}$")


def bump(text: str, version: str, sha256: str) -> str:
    current = TOP_LEVEL_VERSION.search(text) or TOP_LEVEL_URL_VERSION.search(text)
    if current is None:
        raise ValueError("no top-level version or versioned url found")
    old = current.group(1)

    lines = [
        line.replace(old, version) if line.startswith(("  url ", "  version ")) else line
        for line in text.splitlines(keepends=True)
    ]
    text, replaced = TOP_LEVEL_SHA256.subn(f'  sha256 "{sha256}"', "".join(lines), count=1)
    if not replaced:
        raise ValueError("no top-level sha256 found")
    return text


def main() -> None:
    path, version, sha256 = sys.argv[1:4]
    if not VERSION.match(version):
        sys.exit(f"::error::{version!r} doesn't look like a version")
    if not SHA256.match(sha256):
        sys.exit(f"::error::{sha256!r} isn't a sha256")
    file = Path(path)
    try:
        file.write_text(bump(file.read_text(), version, sha256))
    except ValueError as exc:
        sys.exit(f"::error file={path}::{exc}")


if __name__ == "__main__":
    main()
