# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Requirements

- `stow`
- `sudo` (or set `SUDO=doas` if preferred)

## Usage

```sh
make <profile>      # install a profile
make un<profile>    # remove a profile
```

## Profiles

| Profile | Description |
|---|---|
| `fedora-hyprland` | Fedora, Hyprland (Wayland) |
| `kali-i3` | Kali Linux, i3 (X11) |
| `macos-aerospace` | macOS, AeroSpace tiling WM |
| `arch-desktop` | Arch Linux, desktop |

```sh
make fedora-hyprland
make kali-i3
make macos-aerospace
make arch-desktop
```

## Options

| Variable | Default | Description |
|---|---|---|
| `TARGET` | `$HOME` | Destination for user dotfiles |
| `SYSTEM_TARGET` | `/etc` | Destination for system dotfiles |
| `STOW` | `stow` | Stow binary |
| `SUDO` | `sudo` | Privilege escalator |

```sh
make kali-i3 TARGET=/home/user SUDO=doas
```

## Other targets

```sh
make list-profiles                        # list all profiles
make list-packages PROFILE=kali-i3        # list packages in a profile
make everything                           # stow every package folder
make uneverything                         # unstow every package folder
```
