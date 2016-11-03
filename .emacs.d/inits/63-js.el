(el-get-bundle js2-mode)
(setq auto-mode-alist (cons '("\\.js$" . js2-mode) auto-mode-alist))
(add-hook 'js2-mode-hook
          '(lambda ()
            (flycheck-mode 1)
            (let* ((local-bin (replace-regexp-in-string
                      "[\r\n]+$" "" (shell-command-to-string "npm bin"))))
                (flycheck-set-checker-executable 'javascript-eslint (concat local-bin "/eslint")))
            (set (make-local-variable 'flycheck-checker) 'javascript-eslint)
            (set (make-local-variable 'js-indent-level) 4)
            (set (make-local-variable 'evil-shift-width) 4)))
