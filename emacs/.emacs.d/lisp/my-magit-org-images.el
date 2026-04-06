(require 'org)
(require 'org-element)
(require 'magit)

(defvar my/org-image-extensions
  '("png" "jpg" "jpeg" "gif" "svg" "webp" "bmp" "tif" "tiff"))

(defun my/org-linked-image-files (org-file)
  (with-temp-buffer
    (insert-file-contents org-file)
    (org-mode)
    (let* ((ast (org-element-parse-buffer))
           (base-dir (file-name-directory (expand-file-name org-file)))
           result)
      (org-element-map ast 'link
        (lambda (link)
          (let ((type (org-element-property :type link))
                (path (org-element-property :path link)))
            (when (and (string= type "file")
                       path
                       (member (downcase (or (file-name-extension path) ""))
                               my/org-image-extensions))
              (let ((full (expand-file-name path base-dir)))
                (when (file-exists-p full)
                  (push full result)))))))
      (delete-dups result))))

(defun my/magit-stage-org-file-and-linked-images (org-file)
  (interactive
   (list
    (or (magit-file-at-point)
        (read-file-name "Org file: " nil nil t nil
                        (lambda (f) (string-match-p "\\.org\\'" f))))))
  (unless (and org-file (string-match-p "\\.org\\'" org-file))
    (user-error "Not an Org file"))
  (let* ((org-file (expand-file-name org-file))
         (files (cons org-file (my/org-linked-image-files org-file))))
    (magit-stage-files files)
    (message "Staged %d file(s)" (length files))))

(provide 'my-magit-org-images)
