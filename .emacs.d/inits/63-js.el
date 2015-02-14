(add-hook 'js-mode-hook
          '(lambda ()
            (flycheck-mode 1)
            (set (make-local-variable 'js-indent-level) 2)))
