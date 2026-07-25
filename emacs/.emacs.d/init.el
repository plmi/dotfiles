;; ---------------------------------------------------------------------------
;; Package Manager
;; ---------------------------------------------------------------------------

(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

;; Keep package autoloads available even when this file is loaded directly
;; in batch mode or from a minimal startup.
(package-initialize)

;; Bootstrap use-package once, then keep package declarations uniform below.
(unless (package-installed-p 'use-package)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

;; ---------------------------------------------------------------------------
;; Custom Scripts
;; ---------------------------------------------------------------------------

;; Add lisp/ to load-path so custom modules can be required below
(add-to-list 'load-path "~/.emacs.d/lisp")

;; ---------------------------------------------------------------------------
;; UI / Appearance
;; ---------------------------------------------------------------------------

;; Frame defaults apply to all frames, including those opened via emacsclient.
;; The mode calls below only affect the current frame, so we also suppress
;; chrome via frame-alist to keep later frames consistent.
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'initial-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(font . "Menlo-16"))
(add-to-list 'default-frame-alist '(foreground-color . "#ffffff"))
(add-to-list 'default-frame-alist '(background-color . "#282c34"))

(tool-bar-mode   -1)
(menu-bar-mode   -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode 1)

;; Mouse and clipboard support in terminal frames
(setq select-enable-clipboard t)
(setq select-enable-primary   t)
(mouse-wheel-mode 1)
(xterm-mouse-mode 1)

;; ---------------------------------------------------------------------------
;; File Management
;; ---------------------------------------------------------------------------

;; Redirect backups to avoid cluttering source directories
(make-directory "~/.emacs.d/backups" t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Keep Customize-generated code out of init.el
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; ---------------------------------------------------------------------------
;; Evil (Vim emulation)
;; ---------------------------------------------------------------------------

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)  ; C-u scrolls like vim
  (setq evil-want-C-i-jump nil)  ; leave TAB for org-mode
  :config
  (evil-mode 1)
  ;; j/k move by display line so wrapped lines behave naturally
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  ;; Restore TAB for org-mode folding in normal state
  (evil-define-key 'normal org-mode-map (kbd "TAB")   #'org-cycle)
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle))

;; Extends evil keybindings to magit, dired, help, etc.
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; ---------------------------------------------------------------------------
;; Completion
;; ---------------------------------------------------------------------------

(use-package ivy
  :config
  (ivy-mode 1))

(use-package counsel
  :after ivy)

;; ---------------------------------------------------------------------------
;; Clipboard
;; ---------------------------------------------------------------------------

(use-package xclip
  :config
  (xclip-mode 1))  ; sync kill-ring with X11 / Wayland clipboard

;; ---------------------------------------------------------------------------
;; Magit
;; ---------------------------------------------------------------------------

(use-package magit
  :commands (magit magit-status magit-dispatch)
  :config
  ;; Stage an org file together with all images it links to
  (require 'my-magit-org-images))

;; ---------------------------------------------------------------------------
;; Org Mode
;; ---------------------------------------------------------------------------

;; org-tempo enables <s TAB-style structure template expansion
(with-eval-after-load 'org
  (require 'org-tempo))

(setq org-agenda-files '("~/.emacs.d/.tasks.org"))

;; Store notes and state changes in :LOGBOOK: drawers
(setq org-log-into-drawer t)

;; Display inline images in GUI frames, capped at 500 px wide
(with-eval-after-load 'org
  (when (display-graphic-p)
    (setq org-image-actual-width '(500))
    (add-hook 'org-mode-hook (lambda () (org-display-inline-images t)))))

;; yasnippet — active only in org-mode.
;; org's major-mode TAB overrides the minor-mode binding, so yas-expand is
;; hooked into org-tab-first-hook and returns nil when no snippet matches,
;; letting org's normal TAB behaviour take over.
(use-package yasnippet
  :hook (org-mode . yas-minor-mode)
  :config
  (require 'my-yas-org)
  (add-hook 'org-tab-first-hook #'my/yas-org-expand)
  (yas-reload-all))

;; Insert the latest screenshot from ~/screenshots as an org image block (C-c i s)
(require 'my-org-screenshot)

;; Paste clipboard terminal output as bash src + example blocks (C-c i t)
(require 'my-org-paste-terminal)

;; ---------------------------------------------------------------------------
;; Search
;; ---------------------------------------------------------------------------

;; Leave point at the start of the match after isearch, not the end
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (when (and isearch-forward
                       (number-or-marker-p isearch-other-end))
              (goto-char isearch-other-end))))

;; ---------------------------------------------------------------------------
;; Server
;; ---------------------------------------------------------------------------

;; Start server if not already running so emacsclient can connect
(require 'server)
(unless (server-running-p)
  (server-start))

;; ---------------------------------------------------------------------------
;; Keybindings
;; ---------------------------------------------------------------------------

;; Close the client frame instead of killing the server
(global-set-key (kbd "C-x C-c") #'delete-frame)

;; Ensure set-mark works correctly in terminal frames
(global-set-key (kbd "C-@") #'set-mark-command)

(global-set-key (kbd "C-c r") #'rename-buffer)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c s") #'counsel-rg))
