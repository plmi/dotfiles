;; ---------------------------------------------------------------------------
;; Package Manager
;; ---------------------------------------------------------------------------

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(unless package-archive-contents
  (package-refresh-contents))

;; Automatically install missing packages declared in use-package blocks
(setq use-package-always-ensure t)

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

;; Keep backups out of source directories
(setq backup-directory-alist '(("/tmp/.emacs_saves")))

;; Keep Customize-generated code out of init.el
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; ---------------------------------------------------------------------------
;; Search
;; ---------------------------------------------------------------------------

;; Leave point at the start of the match after isearch (not the end)
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (when (and isearch-forward
                       (number-or-marker-p isearch-other-end))
              (goto-char isearch-other-end))))

;; ---------------------------------------------------------------------------
;; Packages
;; ---------------------------------------------------------------------------

;; Deferred — vterm loads a native C module, no need to pay that cost at startup
(use-package vterm
  :defer t)

(use-package multi-vterm
  :after vterm
  :bind (("C-c t v" . multi-vterm)
         ("C-c t n" . multi-vterm-next)
         ("C-c t p" . multi-vterm-prev)
         ("C-c t r" . multi-vterm-rename-buffer)))

;; Sync kill-ring with the system clipboard in terminal frames
(use-package xclip
  :config
  (xclip-mode 1))

(use-package ivy
  :config
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil) ;; allow mid-string matching
  (ivy-mode 1))

;; counsel-mode remaps M-x, C-x C-f, describe-* etc. to ivy-backed equivalents
(use-package counsel
  :config
  (counsel-mode 1))

;; ---------------------------------------------------------------------------
;; Keybindings
;; ---------------------------------------------------------------------------

;; Needed for correct behaviour in terminal frames
(global-set-key (kbd "C-@") #'set-mark-command)
