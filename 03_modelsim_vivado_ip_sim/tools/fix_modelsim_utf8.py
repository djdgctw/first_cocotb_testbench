#!/usr/bin/env python3
"""
Filter to fix ModelSim's double-encoded UTF-8 output.

ModelSim SE-64 (2020.x) sometimes interprets UTF-8 text as Latin-1 and then
re-encodes it, producing mangled strings such as "å¤ä½".  This script
converts those sequences back to proper UTF-8 so logs stay readable.
"""

from __future__ import annotations

import sys


def _maybe_fix(text: str) -> str:
    """Convert ModelSim double-encoded lines back to UTF-8 when possible."""
    try:
        return text.encode("latin1").decode("utf-8")
    except UnicodeDecodeError:
        return text


def main() -> int:
    for line in sys.stdin:
        sys.stdout.write(_maybe_fix(line))
    sys.stdout.flush()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
