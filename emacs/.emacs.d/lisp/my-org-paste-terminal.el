;; Splits the clipboard on newlines: the first line is treated as the shell
;; command (wrapped in a bash src block) and the remaining lines as its output
;; (wrapped in an example block). Useful for documenting terminal sessions.
(defun my/org-paste-terminal-output ()
  "Paste clipboard content as org-mode src/example blocks.
The first line is treated as the command and wrapped in a bash src block.
Any remaining lines are treated as output and wrapped in an example block."
  (interactive)
  (let* ((clipboard (current-kill 0))
         (lines     (split-string clipboard "\n"))
         (command   (car lines))
         (output    (mapconcat 'identity (cdr lines) "\n")))
    (insert (format "#+BEGIN_SRC bash\n%s\n#+END_SRC" command))
    (unless (string-blank-p output)
      (insert (format "\n#+BEGIN_EXAMPLE\n%s\n#+END_EXAMPLE" output)))))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c i t") #'my/org-paste-terminal-output))

(provide 'my-org-paste-terminal)
