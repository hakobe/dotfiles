(el-get-bundle auto-complete
  (setq-default ac-sources '(ac-source-yasnippet ac-source-filename ac-source-words-in-buffer ac-source-words-in-same-mode-buffers ac-source-files-in-current-dir ac-source-dictionary ac-source-abbrev))
  (global-auto-complete-mode t)
  (setq ac-auto-show-menu 0.3)
  (setq ac-use-menu-map t)

  (with-eval-after-load-feature 'auto-complete
    (define-key ac-menu-map (kbd "\C-n") 'ac-next)
    (define-key ac-menu-map (kbd "\C-p") 'ac-previous)))
