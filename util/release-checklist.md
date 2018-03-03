# MoodleBox – Release Checklist

- [ ] Update CHANGELOG.md
- [ ] Commit the changes:
```
git add CHANGELOG.md
git commit -m "Release notes updated for upcoming release x.y.z."
```

- [ ] Update version date in `default.config.yml`
- [ ] Update version number (can also be 'patch' or 'major' instead of 'minor')
```
bumpversion minor --allow-dirty
```
- [ ] Push: `git push`
- [ ] Push tags: `git push --tags`
- [ ] Prepare and finalize the image
- [ ] Edit the release on GitHub (e.g. https://github.com/martignoni/moodlebox/releases); paste the release notes into the release's release page
- [ ] Upload disk image into the release's release page
- [ ] Publish news on website and other media (Twitter, Moodle website, etc.)
