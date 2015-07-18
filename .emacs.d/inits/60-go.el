(el-get-bundle go-mode)
(el-get-bundle go-autocomplete)
(el-get-bundle go-eldoc)

(add-hook 'go-mode-hook
          '(lambda ()
            (require 'go-autocomplete)
            (require 'auto-complete-config)
            (flycheck-mode 1)
            (add-hook 'before-save-hook 'gofmt-before-save)
            (add-hook 'go-mode-hook 'go-eldoc-setup)
            (set (make-local-variable 'gofmt-command) "goimports")
            (set (make-local-variable 'c-basic-offset) 4)
            (set (make-local-variable 'indent-tabs-mode) t)))
