(el-get-bundle erlang-mode)

(add-hook 'erlang-mode-hook
          '(lambda ()
            (flycheck-mode 1)))
