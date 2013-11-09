(el-get 'sync '(helm helm-c-yasnippet))

(require 'helm)
(require 'helm-config)

(global-set-key (kbd "C-;") 'helm-mini)
(global-set-key (kbd "C-:") 'helm-M-x)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)))

(eval-after-load 'helm-files
  '(progn
     (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)))
