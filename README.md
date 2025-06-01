# Dev Env Setup

This repository contains scripts to set up Arch Linux to my liking in minutes, not half an hour. It automates package installation, user configuration, and dotfiles deployment.

## Features

- Install a curated set of packages and tools via a single configuration file.
- Automate setup of tmux, neovim, window managers, and more.
- Integrate your personal dotfiles repository using GNU Stow.
- Easily apply custom keybinds (via Kanata) and user services.

## Usage

1. **Clone this repository:**
   ```bash
   git clone https://github.com/z3co/dev-env.git
   cd dev-env
   ```

2. **Edit `packages.conf`:**
   - Add packages you want to install under the relevant categories.
   - Set `REPO_URL` to your dotfiles repository (e.g., `https://github.com/z3co/dotfiles.git`).
   - List which configuration folders to stow in `CONFIG_LIST`.

3. **Run the main setup script:**
   ```bash
   ./run.sh
   ```
   **Do not run as root (do not use sudo).**

4. **(Optional) Set up dotfiles:**
   ```bash
   ./stow-dotfiles.sh
   ```
   This will clone your dotfiles into `~/dotfiles` and stow the listed configurations.

5. **(Optional) Install tmux plugin manager:**
   ```bash
   ./install-tpm.sh
   ```

6. **(Optional) Configure custom keybinds with Kanata:**
   - Add your Kanata config to your dotfiles.
   - Add the kanata service file to your dotfiles (As i did in [my dotfiles](https://github.com/z3co/dotfiles/tree/main/kanata/.config/systemd/user))
   - Run:
     ```bash
     ./install-kanata.sh
     ```

## Customization

- Change package lists and dotfiles as needed.
- See the example `packages.conf` for formatting guidelines.

## Credits

- Heavily inspired by [typecraft-dev/crucible](https://github.com/typecraft-dev/crucible)
- Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT
