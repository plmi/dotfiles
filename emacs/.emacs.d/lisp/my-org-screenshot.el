(defvar my/screenshot-dir "~/screenshots"
  "Directory where screenshots are saved.")

;; Picks the most recently modified PNG from `my/screenshot-dir', copies it
;; into the current buffer's directory with a timestamp name, then prompts for
;; a caption and figure name before inserting a full org image block at point.
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

(provide 'my-org-screenshot)
