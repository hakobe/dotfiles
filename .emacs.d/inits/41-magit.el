(defun magit-init ()
  ; stashはたくさんためるので表示しない
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes))

(el-get-bundle! magit
  (setq magit-last-seen-setup-instructions "1.4.0")
  (add-hook 'magit-mode-hook
            '(lambda () (magit-init))))
