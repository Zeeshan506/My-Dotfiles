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

### Niri (Native Scrolling, Overview & Mouse First)
- **Hot Corners**: Move cursor into **top-right** or **top-left** screen corner to instantly toggle native overview.
- **Mod + Return**: Launch Kitty terminal.
- **Mod + Space**: Launch Rofi application menu (`rofi -show drun`).
- **Mod + Q**: Close window.
- **Mod + D / Mod + Tab**: Native overview (`toggle-overview`).
- **Mod + F / Mod + Shift + F**: Maximize column / Fullscreen window.
- **Mod + C**: Center focused column.
- **Mod + Minus / Equal**: Decrease / increase column width by 10%.
- **Mod + Left Mouse Drag**: Interactive window movement.
- **Mod + Right Mouse Drag**: Interactive window resizing.
- **Mod + Mouse Wheel**: Scroll workspaces vertically (`Mod + WheelDown/Up`) and columns horizontally (`Mod + WheelRight/Left`).
- **Mod + Shift + S / W / O**: Screenshot region / window / full output.
- **Mod + Shift + C**: Clipboard history menu via Cliphist and Rofi.
- **Mod + T**: Open Waypaper graphical wallpaper manager.
- **Mod + X**: Power menu (Lock, Suspend, Logout, Reboot, Shutdown).
- **Hardware Keys**: Native volume (`wpctl`), brightness (`brightnessctl`), and media playback (`playerctl`).

---

## 5. Security, Keyring Unlocking & Vault Strategy

- **Session Unlock**: SDDM unlocks GNOME Keyring automatically via PAM upon successful graphical login (`pam_gnome_keyring.so`).
- **Secret Service**: Single ownership of `org.freedesktop.secrets` by `gnome-keyring-daemon`.
- **SSH Agent Integration**: Systemd user socket `gcr-ssh-agent.socket` or `gpg-agent-ssh`.
- **Developer Secret Storage**:
  - Personal Vault: **Bitwarden** (cloud-synchronized, encrypted vault with MFA, CLI access via `bw`).
  - Local Encrypted Database: **KeePassXC** (local offline `.kdbx` file).
  - Never commit API keys, cloud tokens, or database passwords to Git.
  - Inject secrets into development shells using environment managers or local uncommitted `.env` files.
- **Credential Recovery Workflow**:
  - Export Bitwarden vault as password-protected encrypted JSON (`.json`) periodically to an offline, encrypted USB drive.
  - On a fresh installation, restore the vault using your master password and emergency sheet recovery kit.

