#!/usr/bin/env python3
"""Flatten Docs/ into a GitHub wiki checkout.

GitHub wikis have a single flat page namespace, so `Docs/Core/Colors.md` and
`Docs/Experimental/Colors.md` cannot both keep the name "Colors". Pages are
renamed to `<Folder>-<Page>.md` (rendered as "Folder Page") and a generated
`_Sidebar.md` restores the folder tree in the wiki UI.
"""

import os
import re
import shutil
import sys

DOCS_DIR = sys.argv[1] if len(sys.argv) > 1 else "Docs"
WIKI_DIR = sys.argv[2] if len(sys.argv) > 2 else "wiki"

# Folders listed first in the sidebar; anything else is appended alphabetically.
FOLDER_ORDER = ["Core", "Optional", "Experimental", "Compatibility"]
# Root pages listed first, before the folder groups.
ROOT_ORDER = ["Home", "Getting-Started", "Documentation"]

LINK_RE = re.compile(r"(\[[^\]]*\]\()([^)\s]+)((?:\s+\"[^\"]*\")?\))")
BLOB_RE = re.compile(r"^https?://github\.com/[^/]+/[^/]+/(?:blob|tree|raw)/[^/]+/(.+)$", re.I)


def page_name(rel_path):
    """Docs-relative path -> wiki page name."""
    stem = os.path.splitext(rel_path)[0]
    return "-".join(p for p in stem.split("/") if p)


def pretty(name):
    return re.sub(r"[_-]+", " ", name).strip()


def collect(docs_dir):
    """Return (root_pages, grouped_pages, lookup) for every markdown file."""
    root_pages, grouped, lookup = [], {}, {}
    for dirpath, dirnames, filenames in os.walk(docs_dir):
        dirnames.sort()
        for filename in sorted(filenames):
            if not filename.lower().endswith(".md"):
                continue
            rel = os.path.relpath(os.path.join(dirpath, filename), docs_dir).replace("\\", "/")
            page = page_name(rel)
            folder = os.path.dirname(rel)
            if folder:
                grouped.setdefault(folder, []).append((rel, page))
            else:
                root_pages.append((rel, page))
            for key in link_keys(rel, page):
                lookup.setdefault(key, page)
    return root_pages, grouped, lookup


def norm(text):
    return re.sub(r"[_\s]+", "-", text.strip().lower()).strip("-")


def link_keys(rel, page):
    """Every spelling of a link that should resolve to this page."""
    stem = os.path.splitext(rel)[0]
    base = os.path.basename(stem)
    variants = {rel, stem, base, page, "Docs/" + rel, "Docs/" + stem}
    return {norm(v) for v in variants}


def resolve(target, lookup):
    """Rewrite one link target to a wiki page name, or None to leave it alone."""
    if target.startswith("#") or target.startswith("mailto:"):
        return None

    url, _, anchor = target.partition("#")
    url = url.strip()

    blob = BLOB_RE.match(url)
    if blob:
        url = blob.group(1)
    elif "://" in url:
        return None  # external link

    url = url.lstrip("./").lstrip("/")
    if not url:
        return None

    page = lookup.get(norm(url))
    if page is None:
        return None
    return page + ("#" + anchor if anchor else "")


def rewrite_links(text, lookup):
    def sub(match):
        new = resolve(match.group(2), lookup)
        return match.group(1) + (new or match.group(2)) + match.group(3)

    return LINK_RE.sub(sub, text)


def build_sidebar(root_pages, grouped):
    lines = ["## GML-Extended", ""]

    ordered_roots = sorted(
        root_pages,
        key=lambda item: (
            ROOT_ORDER.index(item[1]) if item[1] in ROOT_ORDER else len(ROOT_ORDER),
            item[1],
        ),
    )
    for _, page in ordered_roots:
        lines.append("- [[%s|%s]]" % (pretty(page), page))

    def folder_key(folder):
        top = folder.split("/")[0]
        return (FOLDER_ORDER.index(top) if top in FOLDER_ORDER else len(FOLDER_ORDER), folder)

    for folder in sorted(grouped, key=folder_key):
        lines.append("")
        lines.append("**%s**" % pretty(folder.replace("/", " / ")))
        lines.append("")
        for rel, page in grouped[folder]:
            title = pretty(os.path.splitext(os.path.basename(rel))[0])
            lines.append("- [[%s|%s]]" % (title, page))

    lines.append("")
    return "\n".join(lines)


def main():
    if not os.path.isdir(DOCS_DIR):
        sys.exit("Docs directory not found: %s" % DOCS_DIR)

    root_pages, grouped, lookup = collect(DOCS_DIR)

    # Wipe previously synced pages so renames and deletions propagate.
    for entry in os.listdir(WIKI_DIR):
        if entry == ".git":
            continue
        path = os.path.join(WIKI_DIR, entry)
        shutil.rmtree(path) if os.path.isdir(path) else os.remove(path)

    for rel, page in root_pages + [p for pages in grouped.values() for p in pages]:
        with open(os.path.join(DOCS_DIR, rel), encoding="utf-8") as handle:
            content = handle.read()
        with open(os.path.join(WIKI_DIR, page + ".md"), "w", encoding="utf-8", newline="\n") as handle:
            handle.write(rewrite_links(content, lookup))
        print("%s -> %s.md" % (rel, page))

    with open(os.path.join(WIKI_DIR, "_Sidebar.md"), "w", encoding="utf-8", newline="\n") as handle:
        handle.write(build_sidebar(root_pages, grouped))
    print("generated _Sidebar.md")


if __name__ == "__main__":
    main()
