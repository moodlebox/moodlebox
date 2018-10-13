# MoodleBox – Release Checklist

## From 2 weeks to shortly before release

- [ ] Create and edit the draft of the release on GitHub
- [ ] Update `CHANGELOG.md` (same changes)
- [ ] Commit the changes:
```
git add CHANGELOG.md
git commit -m "Update release notes for upcoming release x.y.z."
```

## Just before preparing the disk image

- [ ] Update version date in `default.config.yml`
- [ ] Update version of Moodle (branch) in `default.config.yml`, if needed
- [ ] Update version of MoodleBox plugin in `default.config.yml`, if needed
- [ ] Update version of MathJax in `default.config.yml`, if needed
- [ ] Update version date in `CHANGELOG.md`, if needed
- [ ] Update version number (can also be 'patch' or 'major' instead of 'minor'):
```
bumpversion minor --allow-dirty
```
- [ ] Push: `git push`
- [ ] Push tags: `git push --tags`

## Now do the real release work

- [ ] Prepare and finalize the image

## Finally, publish the release and the disk image on GitHub

- [ ] Edit and publish the release on GitHub
- [ ] Upload disk image into the release's release page
- [ ] Publish news on website and other media (Twitter, Moodle website, etc.)
