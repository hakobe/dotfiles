(el-get 'sync 'magit)
(require 'magit)

(defun magit-init ()
  ; stashはたくさんためるので表示しない
  (remove-hook 'magit-status-sections-hook 'magit-insert-stashes))

(add-hook 'magit-mode-hook
          '(lambda () (magit-init)))
