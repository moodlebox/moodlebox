# MoodleBox – Release Checklist

- [ ] Update documentation in doc/MoodleBox.tex
- [ ] Commit the changes:
```
git commit -m "Documentation updated."
```

- [ ] Update CHANGELOG.md
- [ ] Commit the changes: 
```
git add CHANGELOG.md
git commit -m "Changelog for upcoming release x.y.z."
```

- [ ] Update version date in doc/MoodleBox.tex
- [ ] Update version date in make_moodlebox.sh

- [ ] Update version number (can also be minor or major)
```
bumpversion patch
```
- [ ] Compile doc/MoodleBox.tex
- [ ] Push: `git push`
- [ ] Push tags: `git push --tags`
- [ ] Edit the release on GitHub (e.g. https://github.com/martignoni/make-moodlebox/releases). Paste the release notes into the release's release page.
