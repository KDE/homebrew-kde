---
name: Build issue
about: Formula doesn't build
title: "[Build]"
labels: build
assignees: yurikoles

---

# Please note we will close your issue without comment if you delete, do not read or do not fill out the issue checklist below and provide ALL the requested information. If you repeatedly fail to use the issue template, we will block you from ever submitting issues to Homebrew again.

- [ ] tried install latest git version by `brew install --HEAD <failed-formula>` and can still reproduce the problem?
- [ ] ran `brew update` and can still reproduce the problem?
- [ ] ran `brew doctor`, fixed all issues and can still reproduce the problem?
- [ ] ran `"$(brew --repo kde-mac/kde)/tools/do-caveats.sh"`, don't see perl-related issues in ouptut and can still reproduce the problem?
- [ ] ran `brew gist-logs <failed-formula>` (where `<failed-formula>` is the name of the formula that failed) and included the output link?
- [ ] Have you checked that there aren't other similar [issues](https://github.com/KDE-mac/homebrew-kde/issues) already reported?

<!-- To help us debug your issue, please complete these sections: -->

# Please specify exact formula that has issue

<!-- replace me -->

# What happened (include command output)

<!-- replace me -->

<details>
  <summary>Command output</summary>
  <pre>

  <!-- replace this with the command output -->

  </pre>
</details>

# URL to gist, invoke `brew gist-logs <failed-formula>`

<!-- replace me -->
