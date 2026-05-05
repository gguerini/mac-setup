<div align="center">
  <h1>Mac Setup</h1>
  <p>
    <em>Full Stack Development Setup for macOS</em>
  </p>
  <p>
    <a href="https://github.com/gguerini/mac-setup/commits/main">
      <img src="https://img.shields.io/github/last-commit/gguerini/mac-setup.svg" alt="Last Commit" />
    </a>
  </p>
  <br>
</div>

Automated macOS setup script for full stack development. Installs and configures tools, applications, shell environment, and system preferences.

---

## Table of Contents

- [Installation](#installation)
- [What Gets Installed](#what-gets-installed)
- [System Preferences](#system-preferences)
- [Shell](#shell)
- [Git](#git)
- [Version Manager](#version-manager)

---

## Installation

Clone the repository and run the install script from the repo root:

```shell
$ git clone https://github.com/gguerini/mac-setup.git
$ cd mac-setup
$ zsh script/install.sh
```

The installer is interactive — it will prompt you before each step so you can skip anything you don't need. Useful when setting up a work laptop vs. a personal machine.

---

## What Gets Installed

### Base packages (always installed)

- `mas` — Mac App Store CLI
- `gh` — GitHub CLI

### App groups (opt-in per group)

Apps are organized into groups under `brewfiles/`. The installer prompts for each group:

| Group | Apps |
|---|---|
| **development** | Cursor, VS Code, GitHub Desktop, iTerm2, Insomnia, Figma |
| **databases** | TablePlus, Postico |
| **productivity** | Alfred, Rectangle, Caffeine, xbar, AppCleaner, 1Password, MeetingBar, Hidden Bar, Things, Bumpr |
| **communication** | Slack, ChatGPT, WhatsApp, Claude |
| **browsers** | Firefox, Google Chrome, Brave |
| **media** | VLC, LiceCap, ImageOptim, TrainerRoad |
| **utilities** | Wipr 2, Vinegar, GIPHY, Xcode |

To add a new group, create a `brewfiles/Brewfile.<group>` file — the installer picks it up automatically.

---

## System Preferences

macOS system preferences are configured via `script/defaults.sh`. It covers:

- **Finder** — status/path bars, list view, show hidden Library, spring loading
- **Dock** — size 35, auto-hide, no animations, minimize to app icon
- **Trackpad** — tap-to-click, two-finger right-click, three-finger swipe
- **Keyboard** — fast key repeat, disable press-and-hold, disable smart punctuation
- **Appearance** — Dark Mode, graphite accent color
- **Safari** — full URL display, developer tools, favorites bar

Run it standalone at any time:

```shell
$ zsh script/defaults.sh
```

> If you see "Could not write domain" errors, grant Full Disk Access to your terminal app in System Settings > Privacy & Security.

---

## Shell

Uses [Oh My Zsh](https://ohmyz.sh/) with a custom theme and aliases.

- **Theme** — `tranquility` (shows Git branch, commit age, dirty state)
- **Plugins** — `git`, `rails`
- **Aliases** — defined in `oh-my-zsh/aliases.zsh`

VS Code settings are managed via [VS Code Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync) backed by GitHub — not stored in this repo.

---

## Git

The installer creates `~/.gitconfig` from the template in this repo, prompting for your name, email, and preferred editor.

Includes a set of aliases for common workflows:

| Alias | Command |
|---|---|
| `s` | `status` |
| `aa` | `add --all` |
| `cm` | `add --all && commit -m` |
| `co` | `checkout` |
| `cob` | `checkout -b` |
| `up` | `fetch && pull --rebase` |
| `reb` | `fetch && rebase -i origin/main` |
| `lg` | fancy log with graph |
| `wip` | commit all as WIP |
| `undo` | reset last commit (mixed) |
| `wipe` | hard reset |
| `bdone` | checkout main, update, delete merged branches |

### SSH via 1Password

The installer can configure 1Password as your SSH agent — no key files on disk, protected by biometric unlock. Enable it in 1Password under **Settings > Developer > Use the SSH agent**.

---

## Version Manager

The installer offers a choice between [asdf](https://asdf-vm.com/) and [mise](https://mise.jdx.dev/) for managing Ruby versions. Both support `.tool-versions` files.

- **asdf** — battle-tested, widely used
- **mise** — faster, actively maintained, drop-in replacement for asdf
