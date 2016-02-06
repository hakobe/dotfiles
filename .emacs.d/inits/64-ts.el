(el-get-bundle ananthakumaran/typescript.el)
(el-get-bundle ananthakumaran/tide)

(autoload 'typescript-mode "typescript" nil t)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(add-hook 'typescript-mode-hook
        '(lambda ()
            (set (make-local-variable 'typescript-indent-level) 2)
            (require 'tide)
            (tide-setup)
            (flycheck-mode t)
            (eldoc-mode t)))
