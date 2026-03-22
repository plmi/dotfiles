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
(setq mouse-wheel-mode 1)
(setq xterm-mouse-mode 1)

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

;; Load vterm explicitly so its functions are available
(require 'vterm)

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

;; multi-vterm: open/cycle/rename terminal instances
(global-set-key (kbd "C-c t v") #'multi-vterm)
(global-set-key (kbd "C-c t n") #'multi-vterm-next)
(global-set-key (kbd "C-c t p") #'multi-vterm-prev)

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

(defvar my/screenshot-dir "~/screenshots"
  "Directory where screenshots are saved.")

(defun my/org-insert-screenshot ()
  "Copy the latest PNG from `my/screenshot-dir' to the current file's
directory and insert a relative org-mode link at point."
  (interactive)
  (let* ((src-dir (expand-file-name my/screenshot-dir))
         (files (directory-files src-dir t "\\.png$"))
         (latest (car (sort files
                            (lambda (a b)
                              (time-less-p (nth 5 (file-attributes b))
                                           (nth 5 (file-attributes a)))))))
         (dest-name (format-time-string "img%Y%m%dT%H%M%S.png"))
         (dest-path (expand-file-name dest-name default-directory)))
    (if (null latest)
        (user-error "No screenshots found in %s" src-dir)
      (let* ((caption (read-string "Caption: "))
             (name    (read-string "Figure name (fig:...): " "fig:")))
        (copy-file latest dest-path)
        (insert (format "#+CAPTION: %s\n#+NAME: %s\n#+ATTR_HTML: :width 900px\n[[./%s]]"
                        caption name dest-name))))))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c i s") #'my/org-insert-screenshot))
