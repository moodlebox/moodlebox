# MoodleBox – Release Checklist

- [ ] Update CHANGELOG.md
- [ ] Commit the changes:
```
git add CHANGELOG.md
git commit -m "Release notes updated for upcoming release x.y.z."
```

- [ ] Update version date in `default.config.yml`
- [ ] Update version number (can also be 'minor' or 'major' instead of 'patch')
```
bumpversion patch --allow-dirty
```
- [ ] Push: `git push`
- [ ] Push tags: `git push --tags`
- [ ] Edit the release on GitHub (e.g. https://github.com/martignoni/moodlebox/releases). Paste the release notes into the release's release page.
