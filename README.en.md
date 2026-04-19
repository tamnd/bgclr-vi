# Beej's Guide to C Programming, Library Reference (Vietnamese)

> [Tiếng Việt](README.md) &middot; English

Vietnamese translation of [Beej's Guide to C Programming, Library
Reference][bgclr] by Brian "Beej Jorgensen" Hall. This is the
companion to [Beej's Guide to C Programming][bgc], focused on
standard C library reference: each function, each macro, each type.
Free to read, free to share, just like the original.

> Writing real C and need to know what `strtod()` returns on
> overflow? Or what's inside `fenv_t`? Or how `memcpy()` differs from
> `memmove()`? This is the book you open when stdlib bites you.

[bgclr]: https://beej.us/guide/bgclr/
[bgc]: https://beej.us/guide/bgc/

## Is this for me?

Yes if you already know C well enough to use it and want a Vietnamese
standard-library reference. If you're still learning C from scratch,
read the [Vietnamese language guide][bgc-vi] first, then come back
when you need specific function details.

If you read English comfortably, just read the [original
guide][bgclr], it's right there.

[bgc-vi]: https://github.com/tamnd/bgc-vi

## What you'll look up

Thirty-two chapters, one per standard C header. From `<assert.h>` to
`<wctype.h>`, through `<stdio.h>`, `<stdlib.h>`, `<string.h>`,
`<math.h>`, `<time.h>`, `<threads.h>`, `<stdatomic.h>`, `<stdbit.h>`
(C23), and every other header. Full list in
[ROADMAP.md](ROADMAP.md).

## Status

The build pipeline is wired up but CI is paused while the translation
marathon is in progress, to avoid rebuilding on every chapter merge.
Once all 32 chapters are translated, CI/CD will be re-enabled and the
first release cut. Track progress in [ROADMAP.md](ROADMAP.md) or the
[merged PRs](https://github.com/tamnd/bgclr-vi/pulls?q=is%3Apr+is%3Amerged).

## Repo layout

```
bgclr-vi/
├── src/         # English originals (from upstream, do not edit)
├── src_vi/      # Vietnamese translations (the interesting stuff)
├── source/      # Example C programs (unchanged from upstream)
├── translations/# Other-language builds shipped by upstream
├── website/     # Upstream website assets
├── scripts/     # Build and release helpers
├── bgbspd/      # Beej's shared build-system submodule
├── ROADMAP.md   # Translation plan and progress
├── UPSTREAM.md  # Which upstream commit we track
├── LICENSE.md   # CC BY-NC-ND 3.0, same as upstream
└── README.md    # You are here
```

Each translated chapter in `src_vi/` matches a file in `src/`
one-to-one (same filename, same section anchors). Diffing the two is
the simplest way to spot drift.

## How to read

**Online:** will live at <https://tamnd.github.io/bgclr-vi/> once the
translation marathon finishes and CI is re-enabled.

**Offline:** grab files from the
[Releases](https://github.com/tamnd/bgclr-vi/releases) page after the
first release cut (PDF, EPUB, HTML zip, source code). Or read
markdown directly in `src_vi/`, GitHub renders it fine.

**Build it yourself:** see [Building](#building) below.

## Contributing

Pull requests welcome. A few ground rules so the text stays readable:

- **One chapter per PR.** Don't batch. Small PRs get merged, big PRs
  sit.
- **Translate meaning, not words.** If a literal translation reads
  like a robot wrote it, rewrite it. Beej's tone is casual; yours
  should be too.
- **No machine translation.** Seriously. We can tell.
- **Keep code blocks, function names, variable names, header names,
  and C keywords in English.** `malloc()` stays `malloc()`.
  `<stdio.h>` stays `<stdio.h>`.
- **First use of a technical term:** give the English word first,
  then Vietnamese in parentheses if helpful. Subsequent uses can drop
  the Vietnamese.
- **No em dashes in Vietnamese prose.** Rewrite the sentence or use a
  comma.
- **Section anchors stay intact.** If the English says `{#stdio}`,
  the Vietnamese says `{#stdio}`.
- **Preserve index tags `[i[...]]`, `[fl[...]]`, `[flw[...]]`,
  `[nh[...]]`.** They drive the print index.

### Workflow

1. Pick a chapter in [ROADMAP.md](ROADMAP.md) marked "not started".
2. Open an issue saying you're taking it, so no one duplicates work.
3. Branch: `translate/<chapter-slug>` (e.g. `translate/stdio`).
4. Copy `src/bgclr_part_NNNN_<slug>.md` to `src_vi/` with the same
   filename. Translate in place.
5. Open a PR against `main`. Update the chapter status in ROADMAP.
6. Expect review. The goal is prose that reads like a Vietnamese
   developer wrote it from scratch.

## Building

The repo uses the same build system as upstream (`bgbspd`, `pandoc`,
`xelatex`), packaged in the shared `ghcr.io/tamnd/beej-vi-docker`
image.

Build locally via Docker or Podman:

```
./scripts/build_vi_docker.sh
```

The `docs/` directory will contain HTML, PDFs, EPUB, and a landing
page, identical to what will land on GitHub Pages later.

Building without a container: see `scripts/build_vi.sh` for the
steps (you'll need `pandoc`, `texlive-xetex`, `python3`, `make`,
`zip`, `imagemagick`, `fonts-libertinus`).

## Sync with upstream

The upstream commit we track is recorded in
[UPSTREAM.md](UPSTREAM.md).

When upstream ships changes, we re-sync `src/` against upstream; the
diff then tells us which translated chapters need touch-ups. If you
spot drift, open an issue.

## Credits

- **Original guide:** Brian "Beej Jorgensen" Hall, 2007-present,
  https://beej.us/guide/bgclr/
- **Vietnamese translation:** Duc-Tam Nguyen (tamnd@liteio.dev) and
  [contributors](https://github.com/tamnd/bgclr-vi/graphs/contributors)

## License

[CC BY-NC-ND 3.0](LICENSE.md), same as upstream. You can read it,
share it, and translate it. You can't sell it or make derivative
works (other than translations, which upstream explicitly permits).
Source code in the guide is public domain.

Full text: [LICENSE.md](LICENSE.md) &middot; [Creative Commons
page](https://creativecommons.org/licenses/by-nc-nd/3.0/).
