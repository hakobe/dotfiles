(el-get 'sync 'helm)

(require 'helm)
(require 'helm-config)

(defun my-helm-mini ()
  (interactive)
  (require 'helm-files)
  (helm-other-buffer '(
                       helm-source-buffers-list
                       helm-source-files-in-current-dir
                       helm-source-recentf
                       helm-source-file-cache
                       helm-source-locate
                       )
                     "*helm mini*"))

(global-set-key (kbd "C-;") 'my-helm-mini)
(global-set-key (kbd "C-:") 'helm-M-x)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)))

(eval-after-load 'helm-files
  '(progn
     (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)))
