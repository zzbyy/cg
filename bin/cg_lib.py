#!/usr/bin/env python3
"""
Shared library for context governance bin/ scripts.
Uses stdlib only — no PyYAML required.
"""
import os
import re

CONTEXT_ROOT = os.path.realpath(os.path.expanduser("~/context"))
REGISTRY_PATH = os.path.join(CONTEXT_ROOT, "registry.yaml")


def _parse_yaml(text):
    """
    Parse a subset of YAML matching registry.yaml's schema.
    Handles: scalars, inline dicts ({}), inline lists ([]),
    block lists (- item), and 2-level block dicts.
    """
    result = {}
    lines = text.splitlines()
    i = 0

    while i < len(lines):
        line = lines[i]
        stripped = line.rstrip()

        if not stripped or stripped.lstrip().startswith('#'):
            i += 1
            continue

        # Top-level key
        m = re.match(r'^([A-Za-z_][A-Za-z0-9_]*)\s*:\s*(.*)', stripped)
        if not m:
            i += 1
            continue

        key, rest = m.group(1), m.group(2).strip()

        if rest == '{}':
            result[key] = {}
            i += 1
            continue

        if rest == '[]':
            result[key] = []
            i += 1
            continue

        if rest and not rest.startswith('#'):
            result[key] = rest.strip('"\'')
            i += 1
            continue

        # Collect indented block
        i += 1
        block = []
        while i < len(lines):
            bl = lines[i]
            if bl and not bl[0].isspace():
                break
            block.append(bl)
            i += 1

        # Determine list vs dict from first non-empty, non-comment child
        first = next(
            (l.strip() for l in block if l.strip() and not l.strip().startswith('#')),
            ''
        )

        if first.startswith('- '):
            items = []
            for bl in block:
                cm = re.match(r'\s+- (.+)', bl)
                if cm:
                    items.append(cm.group(1).strip().strip('"\''))
            result[key] = items
        else:
            d = {}
            current_sub = None
            for bl in block:
                bs = bl.rstrip()
                if not bs or bs.lstrip().startswith('#'):
                    continue
                # 2-space child key
                m2 = re.match(r'^  ([A-Za-z_][A-Za-z0-9_-]*)\s*:\s*(.*)', bs)
                if m2:
                    sk, sv = m2.group(1), m2.group(2).strip().strip('"\'')
                    if sv == '{}':
                        d[sk] = {}
                    elif sv:
                        d[sk] = sv
                    else:
                        d[sk] = {}
                    current_sub = sk
                    continue
                # 4-space grandchild key (project properties)
                m3 = re.match(r'^    ([A-Za-z_][A-Za-z0-9_-]*)\s*:\s*(.*)', bs)
                if m3 and current_sub is not None:
                    gk, gv = m3.group(1), m3.group(2).strip().strip('"\'')
                    if isinstance(d.get(current_sub), dict):
                        d[current_sub][gk] = gv
            result[key] = d

    return result


def load_registry():
    """Load and parse registry.yaml. Returns empty structure if missing."""
    if not os.path.exists(REGISTRY_PATH):
        return {
            "system": {},
            "projects": {},
            "domains": [],
            "reading_topics": [],
            "writing_topics": [],
        }
    with open(REGISTRY_PATH) as f:
        return _parse_yaml(f.read())


def resolve_slug(cwd=None):
    """
    Resolve a path to a project slug using longest-prefix-match.
    Returns (slug, project_data) or (None, None) if no match.
    """
    if cwd is None:
        cwd = os.getcwd()
    cwd = os.path.realpath(os.path.expanduser(str(cwd)))

    registry = load_registry()
    projects = registry.get('projects', {})

    best_slug, best_len, best_data = None, 0, None
    for slug, data in projects.items():
        if not isinstance(data, dict):
            continue
        path = data.get('path', '')
        if not path:
            continue
        path = os.path.realpath(os.path.expanduser(path))
        if (cwd == path or cwd.startswith(path + os.sep)) and len(path) > best_len:
            best_slug, best_len, best_data = slug, len(path), data

    return best_slug, best_data


def inbox_dir():
    return os.path.join(CONTEXT_ROOT, "inbox")


def count_inbox():
    """Return count of .md files in inbox/."""
    d = inbox_dir()
    if not os.path.exists(d):
        return 0
    return len([f for f in os.listdir(d) if f.endswith('.md')])


def list_inbox():
    """Return sorted list of inbox .md filenames."""
    d = inbox_dir()
    if not os.path.exists(d):
        return []
    return sorted(f for f in os.listdir(d) if f.endswith('.md'))


def checkpoint_path():
    return os.path.join(CONTEXT_ROOT, "scratchpad", "checkpoint.md")


def checkpoint_exists():
    return os.path.exists(checkpoint_path())


def active_projects():
    """Return list of slug dirs in projects/_active/."""
    active_dir = os.path.join(CONTEXT_ROOT, "projects", "_active")
    if not os.path.exists(active_dir):
        return []
    return [d for d in os.listdir(active_dir)
            if os.path.isdir(os.path.join(active_dir, d)) and not d.startswith('_')]
