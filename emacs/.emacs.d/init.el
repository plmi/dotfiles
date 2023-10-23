; disable splash screen
(setq inhibit-startup-screen t)
; disable menu bar
(menu-bar-mode 0)
; disable toolbar
(tool-bar-mode 0)
; disable scrollbar
(scroll-bar-mode 0)
; set auto-saving directory
(setq backup-directory-alist '(("/tmp/.emacs_saves")))
; configure interactive DO things
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
; set font
(set-frame-font "JetbrainsMono Nerd Font 11" nil t)
; use system clipboard
(xclip-mode 1)
; move custom data out of init.el
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
; add MELPA repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
; nyan-mode
(require 'nyan-mode)
(nyan-mode)
; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
; evil-mode + evil-collection
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))
(evil-mode 1)
(define-key evil-insert-state-map "jk" 'evil-normal-state)
; enable theme
(load-theme 'catppuccin :no-confirm)
; enable doom-modeline
(require 'doom-modeline)
(doom-modeline-mode 1)
(setq inhibit-compacting-font-caches t)
; enable interaction-log
(require 'interaction-log)
(interaction-log-mode 1)
