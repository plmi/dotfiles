;; s - string manipulation library (used by my/insert-clipboard-image)
(unless (package-installed-p 's)
  (package-install 's))

;; https://mpas.github.io/posts/2021/03/29/20210329-paste-image-from-clipboard-directly-into-org-mode-document/
(defun my/org-git-root ()
    (let ((default-directory (file-name-directory buffer-file-name)))
      (string-trim (shell-command-to-string "git rev-parse --show-toplevel"))))

  (defun my/insert-clipboard-image (filename)
    "Paste a clipboard image into the current org buffer as an inline link.

Prompts for a FILENAME (without extension), then saves the image as a PNG and
inserts an org link pointing to it.

Save location is determined by #+IMAGE_SAVE_DIR in the org file header:
  - Relative path: resolved against the git root of the current file.
  - Absolute path: used as-is.
  - Not set: falls back to an images/ directory next to the org file.

The inserted link is always a path relative to the org file, so it works
both in Emacs (inline preview) and Hugo (page bundle serving).

Optional variables (set before calling):
  `my/insert-clipboard-image-use-buffername' — prefix filename with buffer name.
  `my/insert-clipboard-image-use-headername' — prefix filename with heading name.

Requires pngpaste (brew install pngpaste) and the s.el string library.
Bound to C-c i c in org-mode."
    (interactive "sFilename to paste: ")
    (let* ((keywords (org-collect-keywords '("IMAGE_SAVE_DIR")))
           (save-dir-raw (cadr (assoc "IMAGE_SAVE_DIR" keywords)))
           (org-dir (file-name-directory buffer-file-name))
           (save-dir (if save-dir-raw
                         (if (file-name-absolute-p save-dir-raw)
                             (file-name-as-directory save-dir-raw)
                           (expand-file-name save-dir-raw (my/org-git-root)))
                       (expand-file-name "images/" org-dir)))
           (link-dir (file-name-as-directory (file-relative-name save-dir org-dir)))
           (basename (concat
                      (format-time-string "%Y%m%d_%H%M%S_-_")
                      (if (bound-and-true-p my/insert-clipboard-image-use-buffername)
                          (concat (s-replace "-" "_"
                                             (downcase (file-name-sans-extension (buffer-name)))) "_-_")
                        "")
                      (if (bound-and-true-p my/insert-clipboard-image-use-headername)
                          (concat (s-replace " " "_" (downcase (nth 4 (org-heading-components)))) "_-_")
                        "")
                      (file-name-sans-extension filename) ".png"))
           (file (concat save-dir basename)))

      (unless (file-exists-p save-dir)
        (make-directory save-dir t))

      (shell-command (concat "pngpaste " file))
      (insert (concat "[[" link-dir basename "]]"))))

  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-c i c") #'my/insert-clipboard-image))
