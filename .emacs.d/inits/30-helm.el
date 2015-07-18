(defun my-helm-mini ()
  (interactive)
  (require 'helm-files)
  (require 'helm-ghq)
  (helm-other-buffer '(
                       helm-source-buffers-list
                       helm-source-recentf
                       helm-source-file-cache
                       helm-source-files-in-current-dir
                       helm-source-ghq
                       )
                     "*helm mini*"))

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

(el-get-bundle helm
  (require 'helm-config)
  (helm-mode 1)
  (with-eval-after-load-feature 'helm
    (define-key helm-map (kbd "C-h") 'delete-backward-char)))

(el-get-bundle helm-ghq)
(el-get-bundle helm-c-yasnippet)

;; el-get-bundle のあとの初期化ゾーンに記述するとコンパイルエラーになる
(with-eval-after-load-feature 'helm-files
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char))
