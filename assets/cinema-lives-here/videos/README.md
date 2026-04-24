# Cinema Lives Here — source footage

Drop MP4 clips in this folder via the GitHub web UI (or git push). Naming spec:

```
01-jeddah-aerial.mp4
05-rsiff-venue-dusk.mp4            (primary)
05-rsiff-venue-dusk-alt1.mp4       (second take)
06-festival-district-timelapse.mp4
07-ahwash-archival.mp4
08-audience-faces.mp4
09-scale-montage.mp4
10-full-theater.mp4
11-rsiff-night-crowds.mp4
12e-cultures-meet.mp4
```

Extras without a specific scene match go in with `xx-` prefix:
```
xx-day-3-sizzle-v3-clean.mp4
xx-day-6-sizzle-clean.mp4
xx-souk-h.mp4
xx-souk-all-days-recap-hr.mp4
```

## Upload via GitHub web UI

1. On GitHub, switch to branch `claude/web-setup-l0Z6X`
2. Open this folder
3. **Add file → Upload files** → drag clips in → commit to this branch
4. 100MB per-file limit applies; use `git push` from your machine for larger files

Once uploaded, tell Claude "videos pushed" and it will `git pull` and wire them into the Remotion project.
