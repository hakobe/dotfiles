(el-get-bundle carltonf/emacs-tss
  :depends (auto-complete json-mode log4e yaxception))

(autoload 'typescript-mode "typescript" nil t)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(add-hook 'typescript-mode-hook
        '(lambda ()
            (require 'tss)
            (set (make-local-variable 'typescript-indent-level) 2)))
