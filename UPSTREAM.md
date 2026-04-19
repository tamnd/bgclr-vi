# Upstream sync

This translation is based on the English original:

- **Repo:** https://github.com/beejjorgensen/bgclr
- **Commit:** `6f45f77a19feddf9425634fa6cad5a641569f8a9`
- **Version:** v0.9.12 (January 23, 2026)

Update this file when syncing from a newer upstream commit. The release
workflow reads it to embed provenance in the release notes.

## Release tags

We tag translation releases as:

    v<UPSTREAM_VERSION>-vi.<N>

For example, `v0.9.12-vi.1` is the first Vietnamese release based on
upstream v0.9.12. Subsequent translation fixes against the same upstream
version bump `N` (`v0.9.12-vi.2`, `v0.9.12-vi.3`, ...). When upstream
bumps their version, we restart `N` at 1 (`v0.9.13-vi.1`).

Use `scripts/release.sh` to create and push a tag; the
`.github/workflows/release.yml` workflow then builds and publishes a
GitHub Release with all artifacts.
