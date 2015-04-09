(add-to-list 'el-get-sources
    '(:name helm-ghq
           :type github
           :pkgname "hakobe/emacs-helm-ghq"
           :description "ghq with helm interface" ))

(el-get 'sync '(helm helm-c-yasnippet helm-ls-git helm-ghq))
(require 'helm-ghq)

(defun my-helm-mini ()
  (interactive)
  (require 'helm-files)
  (helm-other-buffer '(
                       helm-source-buffers-list
                       helm-source-recentf
                       helm-source-file-cache
                       helm-source-files-in-current-dir
                       helm-source-ghq
                       )
                     "*helm mini*"))
(require 'cl)
(require 'helm-config)
(require 'helm-files)

;; List files in git repos
(defun helm-c-sources-git-project-for (pwd)
  (loop for elt in
        '(("Modified files" . "--modified")
          ("Untracked files" . "--others --exclude-standard")
          ("All controlled files in this project" . nil))
        for title  = (format "%s (%s)" (car elt) pwd)
        for option = (cdr elt)
        for cmd    = (format "git ls-files %s" (or option ""))
        collect
        `((name . ,title)
          (init . (lambda ()
                    (unless (and (not ,option) (helm-candidate-buffer))
                      (with-current-buffer (helm-candidate-buffer 'global)
                        (call-process-shell-command ,cmd nil t nil)))))
          (candidates-in-buffer)
          (type . file))))

(defun helm-git-project-topdir ()
  (file-name-as-directory
   (replace-regexp-in-string
    "\n" ""
    (shell-command-to-string "git rev-parse --show-toplevel"))))

(defun helm-git-project ()
  (interactive)
  (let ((topdir (helm-git-project-topdir)))
    (unless (file-directory-p topdir)
      (error "I'm not in Git Repository!!"))
    (let* ((default-directory topdir)
           (sources (helm-c-sources-git-project-for default-directory)))
      (helm-other-buffer sources
                         (format "*helm git project in %s*" default-directory)))))


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
