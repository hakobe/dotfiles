(el-get 'sync 'auto-complete)

(require 'auto-complete nil t)
(global-auto-complete-mode t)
(setq ac-auto-show-menu 0.3)
(setq ac-use-menu-map t)

(define-key ac-menu-map (kbd "\C-n") 'ac-next)
(define-key ac-menu-map (kbd "\C-p") 'ac-previous)
