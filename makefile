SHELL := /bin/bash

TARGET ?= $(HOME)
# System-level target used for privileged packages (for example `etc`).
SYSTEM_TARGET ?= /etc
STOW ?= stow
STOW_FLAGS ?= --verbose --target="$(TARGET)"
# Override with `SUDO=doas` if you prefer a different privilege escalator.
SUDO ?= sudo

# Shared package groups
BASE_PACKAGES := \
	bin git nvim tmux vim yazi zathura zsh

MEDIA_PACKAGES := \
	mpd ncmpcpp sxiv

# Profiles
PACKAGES_fedora-hyprland := \
	$(BASE_PACKAGES) $(MEDIA_PACKAGES) \
	hypr waybar wofi swaync foot swappy wallpapers autostart

PACKAGES_macos-aerospace := \
	$(BASE_PACKAGES) \
	aerospace karabiner

# Optional system packages per profile.
# These are stowed to SYSTEM_TARGET with sudo in the same make command.
SYSTEM_PACKAGES_fedora-hyprland := etc
SYSTEM_PACKAGES_macos-aerospace :=

PROFILES := fedora-hyprland macos-aerospace

.PHONY: help list-profiles list-packages \
	fedora-hyprland unfedora-hyprland \
	macos-aerospace unmacos-aerospace \
	_apply-profile _unapply-profile \
	everything uneverything all delete

help:
	@printf "Usage:\n"
	@printf "  make <profile>              Install profile packages\n"
	@printf "  make un<profile>            Remove profile packages\n"
	@printf "  (Profiles can also include system files, applied automatically with sudo)\n"
	@printf "  make list-profiles          Show available profiles\n"
	@printf "  make list-packages PROFILE=<name>  Show packages in profile\n"
	@printf "\nProfiles: $(PROFILES)\n"

list-profiles:
	@printf "%s\n" $(PROFILES)

list-packages:
	@if [ -z "$(PROFILE)" ]; then \
		printf "Set PROFILE. Example: make list-packages PROFILE=fedora-hyprland\n"; \
		exit 1; \
	fi
	@printf "%s\n" $(PACKAGES_$(PROFILE))

_apply-profile:
	@if [ -z "$(PROFILE)" ]; then \
		printf "PROFILE is required\n"; \
		exit 1; \
	fi
	# 1) User-level dotfiles -> $(TARGET) (usually $HOME)
	$(STOW) $(STOW_FLAGS) --restow $(PACKAGES_$(PROFILE))
	# 2) System-level dotfiles -> $(SYSTEM_TARGET) (for example /etc), if configured
	@sys_pkgs='$(SYSTEM_PACKAGES_$(PROFILE))'; \
	if [ -n "$$sys_pkgs" ]; then \
		$(SUDO) $(STOW) --dir="$(CURDIR)" --target="$(SYSTEM_TARGET)" --restow $$sys_pkgs; \
	fi

_unapply-profile:
	@if [ -z "$(PROFILE)" ]; then \
		printf "PROFILE is required\n"; \
		exit 1; \
	fi
	# Reverse operation of _apply-profile for user-level packages.
	$(STOW) $(STOW_FLAGS) --delete $(PACKAGES_$(PROFILE))
	# Reverse operation of _apply-profile for system-level packages.
	@sys_pkgs='$(SYSTEM_PACKAGES_$(PROFILE))'; \
	if [ -n "$$sys_pkgs" ]; then \
		$(SUDO) $(STOW) --dir="$(CURDIR)" --target="$(SYSTEM_TARGET)" --delete $$sys_pkgs; \
	fi

# Public profile targets. Add a new profile by defining:
# - PACKAGES_<profile>
# - optional SYSTEM_PACKAGES_<profile>
# - a pair of targets mirroring the pattern below.
fedora-hyprland: PROFILE=fedora-hyprland
fedora-hyprland: _apply-profile

unfedora-hyprland: PROFILE=fedora-hyprland
unfedora-hyprland: _unapply-profile

macos-aerospace: PROFILE=macos-aerospace
macos-aerospace: _apply-profile

unmacos-aerospace: PROFILE=macos-aerospace
unmacos-aerospace: _unapply-profile

# Convenience target: install or remove every package folder.
everything:
	$(STOW) $(STOW_FLAGS) --restow */

uneverything:
	$(STOW) $(STOW_FLAGS) --delete */

# Backward-compatibility aliases.
all: everything
delete: uneverything
