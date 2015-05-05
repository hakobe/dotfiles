;; emacs directory
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

; el-get
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(setq-default el-get-dir (locate-user-emacs-file "el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle tarao/with-eval-after-load-feature-el)

; exec-path-from-shell
(el-get-bundle exec-path-from-shell
  (exec-path-from-shell-copy-env "PATH"))

; init-loader
(el-get-bundle init-loader
  (setq init-loader-show-log-after-init nil))

;; If you omit arguments, then `init-loader-directory' is used
(init-loader-load)
