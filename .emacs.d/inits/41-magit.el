(defun magit-my-init ()
  ; stashはたくさんためるので表示しない
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes))

(el-get-bundle! magit
  (global-set-key (kbd "C-c s") 'magit-status)
  (add-hook 'git-commit-mode-hook
            '(lambda ()
             (set-buffer-file-coding-system 'utf-8)))
  (add-hook 'magit-mode-hook
            '(lambda () (magit-my-init))))
