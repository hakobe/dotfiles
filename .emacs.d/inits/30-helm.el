(el-get 'sync '(helm helm-c-yasnippet helm-ls-git))

(defun my-helm-mini ()
  (interactive)
  (require 'helm-files)
  (helm-other-buffer '(
                       helm-source-buffers-list
                       helm-source-recentf
                       helm-source-file-cache
                       helm-source-files-in-current-dir
                       )
                     "*helm mini*"))

(eval-after-load 'helm
  '(progn
     (global-set-key (kbd "C-;") 'my-helm-mini)
     (global-set-key (kbd "M-;") 'helm-ls-git-ls)
     (global-set-key (kbd "C-:") 'helm-M-x)
     (global-set-key (kbd "M-x") 'helm-M-x)
     (global-set-key (kbd "M-y") 'helm-show-kill-ring)
     (define-key helm-map (kbd "C-h") 'delete-backward-char)))

(eval-after-load 'helm-files
  '(progn
     (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)))
