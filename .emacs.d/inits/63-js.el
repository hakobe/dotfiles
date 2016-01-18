(el-get-bundle js2-mode)
(setq auto-mode-alist (cons '("\\.js$" . js2-mode) auto-mode-alist))
(add-hook 'js2-mode-hook
          '(lambda ()
            (flycheck-mode 1)
            (set (make-local-variable 'js-indent-level) 4)
            (set (make-local-variable 'evil-shift-width) 4)))
