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

;; GUI-mode appearance: match Ghostty terminal (Menlo 16, white on black)
;; Keep frame chrome disabled for frames created after startup too.
;; `tool-bar-mode -1` affects the current frame, but `emacsclient` can create
;; later GUI frames from frame defaults, so we also set the frame parameters.
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'initial-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(font . "Menlo-16"))
(add-to-list 'default-frame-alist '(foreground-color . "#ffffff"))
(add-to-list 'default-frame-alist '(background-color . "#282c34"))

;; Hide the icon toolbar
(tool-bar-mode -1)
;; Hide the menu bar
(menu-bar-mode -1)
;; Hide scroll bars
(scroll-bar-mode -1)

;; Skip the default splash/welcome screen on startup
(setq inhibit-startup-screen t)

;; Show line numbers in every buffer
(global-display-line-numbers-mode 1)

;; Enable selection with mouse
(setq select-enable-clipboard t)
(setq select-enable-primary t)
(mouse-wheel-mode 1)
(xterm-mouse-mode 1)

;; ---------------------------------------------------------------------------
;; File Management
;; ---------------------------------------------------------------------------

;; Write backups and auto-saves to /tmp instead of cluttering source dirs
(make-directory "~/.emacs.d/backups" t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

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

;; Enable ivy completion framework globally
(ivy-mode 1)

;; Enable clipboard sync with the X11 / Wayland clipboard
(xclip-mode 1)

;; Enable magit
(use-package magit
  :ensure t)

;; Enable Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  ;; C-u scrolls like vim
  (setq evil-want-C-u-scroll t)
  ;; let org-mode have TAB
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ;; use visual line motions even outside of visual-line-mode
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  ;; Restore TAB for org-mode folding in normal state
  (evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle))

;; Enable evil-mode in magit, dired, help etc.
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

;; Enable snippet system build into org mode
(with-eval-after-load 'org
  (require 'org-tempo))

;; Set all org agenda files
(setq org-agenda-files '("~/.emacs.d/.tasks.org"))

;; ---------------------------------------------------------------------------
;; Server
;; ---------------------------------------------------------------------------

;; Start the server if not already running (fallback for direct emacs launch)
(require 'server)
(unless (server-running-p)
  (server-start))

;; ---------------------------------------------------------------------------
;; Keybindings
;; ---------------------------------------------------------------------------

;; Make C-x C-c close the client frame instead of killing the server
(global-set-key (kbd "C-x C-c") #'delete-frame)

;; Explicit mark binding — ensures it works correctly in terminal frames
(global-set-key (kbd "C-@") #'set-mark-command)

;; Rename buffer
(global-set-key (kbd "C-c r") #'rename-buffer)

;; Better search in org-mode
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c s") #'counsel-rg))

;; ---------------------------------------------------------------------------
;; Screenshots
;; ---------------------------------------------------------------------------

(require 'my-org-screenshot)
(require 'my-org-paste-terminal)

;; This display the taken screenshot in a acceptable format in your org-mode file.
(with-eval-after-load 'org
  (when (display-graphic-p)
    (setq org-image-actual-width '(500))
    (add-hook 'org-mode-hook (lambda () (org-display-inline-images t)))))

;; Load yasnippet
(use-package yasnippet
  :ensure t
  :hook (org-mode . yas-minor-mode)
  :config
  ;; org-mode's TAB is bound in the major-mode map and overrides yasnippet's
  ;; minor-mode TAB. Use org-tab-first-hook so yas-expand runs first; if no
  ;; snippet matches it returns nil and org's normal TAB handling continues.
  (require 'my-yas-org)
  (add-hook 'org-tab-first-hook #'my/yas-org-expand)
  (yas-reload-all))

;; Enable :LOGBOOK: for notes in org-mode
(setq org-log-into-drawer t)

;; Add my custom scripts
(add-to-list 'load-path "~/.emacs.d/lisp")
;; Stage all images referenced in an org file
(require 'my-magit-org-images)
