;; emacs directory
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

; el-get
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(setq-default el-get-dir (locate-user-emacs-file "el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "http://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

; init-loader
(add-to-list 'el-get-sources
             '(:name init-loader :type github :pkgname "emacs-jp/init-loader"))
(el-get 'sync 'init-loader)
(require 'init-loader)
(setq init-loader-show-log-after-init nil)

; exec-path-from-shell
(el-get 'sync 'exec-path-from-shell)
(require 'exec-path-from-shell)
(exec-path-from-shell-copy-env "PATH")


;; If you omit arguments, then `init-loader-directory' is used
(init-loader-load)
