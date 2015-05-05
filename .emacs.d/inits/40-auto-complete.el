(el-get-bundle auto-complete
  (global-auto-complete-mode t)
  (setq ac-auto-show-menu 0.3)
  (setq ac-use-menu-map t)

  (with-eval-after-load-feature 'auto-complete
    (define-key ac-menu-map (kbd "\C-n") 'ac-next)
    (define-key ac-menu-map (kbd "\C-p") 'ac-previous)))
