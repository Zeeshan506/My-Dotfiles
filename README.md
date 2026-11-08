# My Dotfiles

Modern, reproducible Arch Linux workstation setup featuring **Hyprland** (native Lua) and **Niri** (native scrollable tiling), managed seamlessly with **GNU Stow**.

---

## 1. Prerequisites & Required Packages

Install the desktop stack, utilities, and dependencies using `pacman` and an AUR helper (e.g. `yay` or `paru`):

### Core Compositors & Display
```bash
sudo pacman -S --needed \
  hyprland \
  niri \
  waybar \
  hyprlock \
  hypridle \
  hyprshot \
  swaylock \
  swayidle \
  sddm
```

### Authentication, Keyring & Polkit
```bash
sudo pacman -S --needed \
  gnome-keyring \
  libsecret \
  seahorse \
  gcr-4 \
  hyprpolkitagent \
  polkit-gnome
```

### Desktop UI & Utilities
```bash
sudo pacman -S --needed \
  kitty \
  thunar \
  nautilus \
  rofi-wayland \
  swaync \
  cliphist \
  wl-clipboard \
  network-manager-applet \
  blueman \
  udiskie \
  xfce4-power-manager \
  brightnessctl \
  playerctl \
  wireplumber \
  pipewire-audio
```

### Wallpapers
```bash
sudo pacman -S --needed \
  waypaper \
  awww \
  swaybg
```

### Terminal Shell & Editors
```bash
sudo pacman -S --needed \
  zsh \
  neovim \
  git \
  stow \
  fzf \
  zoxide
```

---

## 2. Deployment with GNU Stow

Clone the repository into your home directory as `~/dotfiles`:

```bash
git clone --recurse-submodules https://github.com/Zeeshan506/My-Dotfiles.git ~/dotfiles
cd ~/dotfiles
```

If Neovim was cloned without submodules:
```bash
git submodule update --init --recursive
```

Deploy all symlinks directly using GNU Stow:
```bash
cd ~/dotfiles
stow -v .
```

To simulate before deploying:
```bash
stow -v -n .
```

To remove deployed symlinks:
```bash
stow -D .
```

---

## 3. Architecture & Modular Layout

```text
~/dotfiles/
├── .config/
│   ├── hypr/
│   │   ├── hyprland.lua       # Main Lua configuration entry
│   │   ├── lua/               # Modular Hyprland Lua components
│   │   │   ├── environment.lua
│   │   │   ├── monitors.lua
│   │   │   ├── input.lua
│   │   │   ├── appearance.lua
│   │   │   ├── animations.lua
│   │   │   ├── keybinds.lua
│   │   │   ├── windowrules.lua
│   │   │   ├── workspaces.lua
│   │   │   └── autostart.lua
│   │   ├── hypridle.conf
│   │   └── hyprlock.conf
│   ├── niri/
│   │   ├── config.kdl         # Niri scrollable compositor config
│   │   ├── dms/               # DMS binds, colors, layout & outputs
│   │   └── swayidle.conf
│   ├── waybar/
│   │   ├── config-hyprland    # Dedicated Hyprland bar config
│   │   ├── config-niri        # Dedicated Niri bar config
│   │   ├── style.css          # Shared monochrome styling
│   │   └── watch.sh           # Atomic inotify auto-reloader
│   ├── kitty/
│   ├── nvim/                  # Submodule: LazyVim starter
│   ├── rofi/
│   └── zed/
├── .p10k.zsh
├── .zshrc
├── .gitmodules
├── .stowrc
├── .stow-local-ignore
└── README.md
```

---

## 4. Workflows & Keybindings

### Hyprland (Native Scrolling)
- **Mod + Return**: Launch Kitty terminal
- **Mod + Q**: Close window
- **Mod + Space**: Rofi application menu
- **Mod + F**: Expand scrolling column (`layoutmsg fit expand`)
- **Mod + C**: Center column into view (`layoutmsg fit_into_view`)
- **Mod + Shift + Left / Right**: Resize scrolling column width
- **Mod + 1..9**: Focus workspaces 1 to 9
- **Mod + Shift + 1..9**: Move active window to workspace 1 to 9
- **Mod + Tab**: Gloview overview (when loaded)
- **Mod + X**: Power menu

### Niri (Native Scrolling & Overview)
- **Mod + Return**: Launch Kitty terminal
- **Mod + Q**: Close window
- **Mod + D / Mod + Tab**: Native overview
- **Mod + Space**: App launcher
- **Mod + F**: Maximize column
- **Mod + C**: Center column
- **Mod + Minus / Equal**: Adjust column width
- **Mod + X**: Power menu

---

## 5. Security & Keyring Unlocking

SDDM unlocks GNOME Keyring automatically via PAM upon successful graphical login (`pam_gnome_keyring.so`).
- Secret Service D-Bus provider: `gnome-keyring-daemon`
- SSH agent integration: systemd socket-activated `gcr-ssh-agent.socket` or `gpg-agent-ssh`
- Vault storage: Developer API tokens and sensitive credentials must be stored in Bitwarden or KeePassXC, never in git repositories or unencrypted dotfiles.
