;; ---------------------------------------------------------------------------
;; Package Manager
;; ---------------------------------------------------------------------------

(require 'package)

;; Add GNU ELPA and MELPA as package sources
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

;; Initialize the package system
(package-initialize)

;; Refresh package list on first run (when cache is empty)
(unless package-archive-contents
  (package-refresh-contents))

;; ---------------------------------------------------------------------------
;; Package Installation
;; ---------------------------------------------------------------------------

;; vterm - terminal emulator inside Emacs
(unless (package-installed-p 'vterm)
  (package-install 'vterm))

;; multi-vterm - manage multiple vterm instances (only if vterm loaded cleanly)
(when (require 'vterm nil 'noerror)
  (unless (package-installed-p 'multi-vterm)
    (package-install 'multi-vterm))
  (require 'multi-vterm))

;; smex - M-x with frecency sorting (ido-style)
(unless (package-installed-p 'smex)
  (package-install 'smex))

;; xclip - sync kill-ring with system clipboard via xclip
(unless (package-installed-p 'xclip)
  (package-install 'xclip))

;; ivy - lightweight completion framework
(unless (package-installed-p 'ivy)
  (package-install 'ivy))

;; counsel - ivy-enhanced replacements for common Emacs commands
(unless (package-installed-p 'counsel)
  (package-install 'counsel))

;; ---------------------------------------------------------------------------
;; UI / Appearance
;; ---------------------------------------------------------------------------

;; Hide the icon toolbar
(tool-bar-mode   -1)
;; Hide the menu bar
(menu-bar-mode   -1)
;; Hide scroll bars
(scroll-bar-mode -1)

;; Skip the default splash/welcome screen on startup
(setq inhibit-startup-screen t)

;; Show line numbers in every buffer
(global-display-line-numbers-mode 1)

;; ---------------------------------------------------------------------------
;; File Management
;; ---------------------------------------------------------------------------

;; Write backups and auto-saves to /tmp instead of cluttering source dirs
(setq backup-directory-alist '(("/tmp/.emacs_saves")))

;; Keep Customize-generated code out of init.el by redirecting it to its own file
(setq custom-file (concat user-emacs-directory "custom.el"))
;; Only load it if it actually exists yet
(when (file-exists-p custom-file)
  (load custom-file))

;; ---------------------------------------------------------------------------
;; Search
;; ---------------------------------------------------------------------------

;; After isearch ends, leave point at the beginning of the match
;; (default Emacs behaviour leaves it at the end, which can be surprising)
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (when (and isearch-forward
                       (number-or-marker-p isearch-other-end))
              (goto-char isearch-other-end))))

;; ---------------------------------------------------------------------------
;; Package Setup
;; ---------------------------------------------------------------------------

;; Load vterm explicitly so its functions are available
(require 'vterm)

;; Load multi-vterm only if vterm loaded cleanly
;;(when (featurep 'vterm)
  ;;(require 'multi-vterm))

;; Enable ivy completion framework globally
(ivy-mode 1)

;; Enable clipboard sync with the X11 / Wayland clipboard
(xclip-mode 1)

;; Enable clipboard sync with the X11 / Wayland clipboard
(xclip-mode 1)

;; ---------------------------------------------------------------------------
;; Keybindings
;; ---------------------------------------------------------------------------

;; smex replaces the default M-x with frecency-sorted completion
;(global-set-key (kbd "M-x") #'smex)

;; M-X limits smex to commands relevant to the current major mode
;(global-set-key (kbd "M-X") #'smex-major-mode-commands)

;; multi-vterm: open/cycle/rename terminal instances
(global-set-key (kbd "C-c t v") #'multi-vterm)
(global-set-key (kbd "C-c t n") #'multi-vterm-next)
(global-set-key (kbd "C-c t p") #'multi-vterm-prev)
;;(global-set-key (kbd "C-c t r") #'multi-vterm-rename-buffer)

;; Explicit mark binding — ensures it works correctly in terminal frames
(global-set-key (kbd "C-@") #'set-mark-command)

;; rename buffer
(global-set-key (kbd "C-c r") #'rename-buffer)
