;; Attempts snippet expansion without falling back to yasnippet's default
;; behaviour (which would insert a literal TAB). Returning nil lets org's own
;; TAB handler take over when no snippet matches at point.
(defun my/yas-org-expand ()
  "Try to expand a yasnippet at point, returning nil if no snippet matches.
Intended for use in `org-tab-first-hook' so yasnippet runs before org's
normal TAB handling."
  (let ((yas-fallback-behavior 'return-nil))
    (yas-expand)))

(provide 'my-yas-org)
