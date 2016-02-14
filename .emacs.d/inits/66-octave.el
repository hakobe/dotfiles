
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          '(lambda ()
             (define-key octave-mode-map (kbd "C-h") nil)))
