(setq-default evil-auto-indent t
              evil-shift-width 2
              evil-cross-lines nil
              evil-echo-state nil
              evil-want-C-i-jump nil
              evil-want-fine-undo t
              evil-want-C-w-in-emacs-state t
              evil-search-module 'evil-search
              evil-ex-search-vim-style-regexp t)

(el-get-bundle! evil
  (evil-mode 1)
  ;; keys
  (defun evil-swap-key (map key1 key2)
    "Swap KEY1 and KEY2 in MAP."
    (let ((def1 (lookup-key map key1))
          (def2 (lookup-key map key2)))
      (define-key map key1 def2)
      (define-key map key2 def1)))

  ;; move cursor visually by default
  (evil-swap-key evil-motion-state-map "j" "gj")
  (evil-swap-key evil-motion-state-map "k" "gk"))

(el-get-bundle evil-leader
  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "w" 'save-buffer)
  (global-evil-leader-mode))

(el-get-bundle tarao/elisp)

(el-get-bundle tarao/evil-plugins
  :features (evil-mode-line evil-little-word evil-operator-comment evil-operator-moccur)
  :depends (color-moccur))

(el-get-bundle bling/evil-visualstar
  (global-evil-visualstar-mode t))
