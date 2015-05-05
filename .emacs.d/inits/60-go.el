(el-get-bundle go-mode)
(el-get-bundle go-autocomplete)

(add-hook 'go-mode-hook
          '(lambda ()
            (require 'go-autocomplete)
            (require 'auto-complete-config)
            (flycheck-mode 1)
            (set (make-local-variable 'c-basic-offset) 4)
            (set (make-local-variable 'indent-tabs-mode) t)))
