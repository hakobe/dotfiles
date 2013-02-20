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

;; fix evil.rcp
(add-to-list 'el-get-sources '(:name evil :build (("make" "all")) :info nil))

;; evil
(el-get 'sync 'evil)
(require 'evil)
(evil-mode 1)
