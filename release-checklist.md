## MoodleBox – Checklist for next release

### From 2 weeks to shortly before release

- [ ] Create and edit the [draft of the release](https://github.com/moodlebox/moodlebox/releases) on GitHub
- [ ] Update `CHANGELOG.md` (same changes)
- [ ] Commit the changes:
```
git add CHANGELOG.md
git commit -m "Update release notes for upcoming release x.y.z"
```

### Just before preparing the disk image

- [ ] Update version of Moodle (branch) in `default.config.yml`, if needed
- [ ] Update version of Moodle in summary string, in `default.config.yml`
- [ ] Update version of MoodleBox plugin in `default.config.yml`, if needed
- [ ] Update version of [MathJax](https://www.mathjax.org/#docs) in `default.config.yml`, if needed
- [ ] Update version date in `default.config.yml`
- [ ] Update version date and other content in `CHANGELOG.md`, if needed
- [ ] Update version number (can also be `patch` or `major` instead of `minor`):
```
bumpversion minor --allow-dirty
```
- [ ] Push: `git push`
- [ ] Push tags: `git push --tags`

### Now do the real release work

- [ ] Comment out any local configuration in `config.yml`
- [ ] Prepare and finalize the image

### Publish the release and the disk image on GitHub

- [ ] Upload disk image to release's page
- [ ] Compute and upload SHA hash file to release's page
- [ ] Publish the release on GitHub

### Update website and publish news about new release

- [ ] Update Moodle version number on MoodleBox website [home page](https://moodlebox.net/), [download page](https://moodlebox.net/download) and [Moodle update page](https://moodlebox.net/en/help/moodle-version-update/)
- [ ] Update documentation on MoodleBox website, if needed
- [ ] Publish news on MoodleBox website
- [ ] Publish news on MoodleBox discussion forum
- [ ] Publish news on Twitter
- [ ] Publish news on Moodle website
