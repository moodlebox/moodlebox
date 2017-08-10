# MoodleBox – Release Checklist

- [ ] Update CHANGELOG.md
- [ ] Commit the changes: 
```
git add CHANGELOG.md
git commit -m "Changelog for upcoming release x.y.z."
```

- [ ] Update version number (can also be minor or major)
```
bumpversion patch
```

- [ ] Push: `git push`
- [ ] Push tags: `git push --tags`
- [ ] Edit the release on GitHub (e.g. https://github.com/martignoni/make-moodlebox/releases). Paste the release notes into the release's release page.