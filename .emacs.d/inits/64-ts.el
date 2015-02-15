(add-to-list 'el-get-sources
    '(:name tss
       :website "https://github.com/aki2o/emacs-tss"
       :description "provide a interface for auto-complete.el/flymake.el on typescript-mode."
       :type github
       :pkgname "aki2o/emacs-tss"
       :depends (auto-complete json-mode log4e yaxception)))

(el-get 'sync 'tss)

(autoload 'typescript-mode "typescript" nil t)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(add-hook 'typescript-mode-hook
        '(lambda ()
            (require 'tss)
            (tss-config-default)
            (set (make-local-variable 'js-indent-level) 2)))
