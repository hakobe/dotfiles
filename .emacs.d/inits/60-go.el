(el-get 'sync 'go-mode)
(add-hook 'go-mode-hook
          '(lambda ()
            (setq c-basic-offset 4)
            (setq indent-tabs-mode t)))

