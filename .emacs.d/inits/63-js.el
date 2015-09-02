(add-hook 'js-mode-hook
          '(lambda ()
            (flycheck-mode 1)
            (set (make-local-variable 'js-indent-level) 4)
            (set (make-local-variable 'evil-shift-width) 4)))
