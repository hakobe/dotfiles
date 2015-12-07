(defun magit-my-init ()
  ; stashはたくさんためるので表示しない
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes))

(el-get-bundle! magit
  (setq magit-last-seen-setup-instructions "1.4.0")
  (global-set-key (kbd "C-c s") 'magit-status)
  (add-hook 'magit-mode-hook
            '(lambda () (magit-my-init))))
